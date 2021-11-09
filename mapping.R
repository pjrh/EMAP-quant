
library(tidyverse)
library(sf)
library(tmap)


IMD_2019 <- read_csv("IMD_2019.csv") 

IMD_2019_2 <- IMD_2019 %>%
  filter(Measurement == "Score") %>%
  select(FeatureCode, Value, `Indices of Deprivation`) %>%
  pivot_wider(names_from = `Indices of Deprivation`, values_from = Value) %>%
  transmute(FeatureCode,
            IMD_2019 = `a. Index of Multiple Deprivation (IMD)`)

IMD_2015 <- read_csv("IMD_2015.csv") 

IMD_2015_2 <- IMD_2015 %>%
  filter(Measurement == "Score") %>%
  select(FeatureCode, Value, `Indices of Deprivation`) %>%
  pivot_wider(names_from = `Indices of Deprivation`, values_from = Value) %>%
  transmute(FeatureCode,
            IMD_2015 = `a. Index of Multiple Deprivation (IMD)`)

LSOA_2011 <- read_sf("Lower_Layer_Super_Output_Areas_December_2011_Generalised_Clipped__Boundaries_in_England_and_Wales.shp")

IMD_analysis <- LSOA_2011 %>%
  left_join(IMD_2019_2,
            by = c("lsoa11cd" = "FeatureCode")) %>%
  left_join(IMD_2015_2,
            by = c("lsoa11cd" = "FeatureCode")) %>%
  st_make_valid()

onspd <- read_csv("Data/ONSPD_FEB_2021_UK.csv")


gp_locations <- read_csv("epraccur.csv",
                         col_names = FALSE)

gp_locations2 <- gp_locations %>%
  left_join(onspd,
            by = c("X10" = "pcds")) %>%
  mutate(service = "GP") %>%
  filter(rgn != "S99999999") # remove Scotland

jobcentre_locations <- read_csv("jobcentre_locations.csv")

jobcentre_locations2 <- jobcentre_locations %>%
  left_join(onspd,
            by = c("Postcode" = "pcds")) %>%
  mutate(service = "jobcentre") %>%
  filter(rgn != "S99999999") # remove Scotland

legalaid_work <- read_csv("legal-aid-statistics-civil-completions-provider-area-data-to-mar-2021.csv")


legalaid_locations2 <- legalaid_work %>%
  filter(FIN_YR == "2019-20",
         SCHEME == "Legal Help") %>%
  count(Postcode, lat, long) %>%
  mutate(service = "legal aid")


services <- bind_rows(gp_locations2 %>% select(service, lat, long),
                      jobcentre_locations2 %>% select(service, lat, long),
                      legalaid_locations2 %>% select(service, lat, long)) %>%
  filter(lat <= 90,
         !is.na(lat)) %>%
  st_as_sf(coords = c("long", "lat"), crs = "WGS84")

services_multipoint <- services %>%
  group_by(service) %>%
  summarise(a = st_combine(geometry))

services_multipoint <- services %>%
  split(services$service) %>%
  imap(~.x %>% st_combine() %>% st_sf %>% mutate(service = .y)) %>% 
  bind_rows()

tmap_mode("view")
tm_basemap("Stamen.Watercolor") +
  tm_shape(services) + tm_dots(col = "service")
  

dist_all <- IMD_analysis %>%
  st_distance(services_multipoint) %>%
  as_tibble() %>%
  setNames(services_multipoint$service)

IMD_analysis <- IMD_analysis %>%
  bind_cols(dist_all)

a <- IMD_analysis %>%
  mutate(within_2_miles_GP = if_else(as.numeric(GP) < 2*1609.34, 1, 0),
         within_2_miles_jobcentre = if_else(as.numeric(jobcentre) < 2*1609.34, 1, 0),
         within_2_miles_legalaid = if_else(as.numeric(`legal aid`) < 2*1609.34, 1, 0),
         IMD_change = IMD_2019 - IMD_2015)

res <- lm(IMD_change ~ within_2_miles_jobcentre + within_2_miles_GP + within_2_miles_legalaid, a)
summary.lm(res)