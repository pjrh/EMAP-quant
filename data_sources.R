
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Download the data sources
## This file should download the data needed to run the project
## Should only need to run this once (unless new data is added)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Create a directory to store the data
dir.create("data_download")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Jobcentre locations
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

download.file("https://raw.githubusercontent.com/openregister/registers-data-archive/master/jobcentre/records.csv",
              "data_download/jobcentre_register.csv")

download.file("https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/802704/dwp-jcp-office-address-register.csv",
              "data_download/jobcentre_locations.csv")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# GP locations
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

download.file("https://files.digital.nhs.uk/assets/ods/current/epraccur.zip",
              "data_download/gp_locations.zip")

unzip("data_download/gp_locations.zip",
      exdir = "data_download/gp_locations")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Legal aid locations
# https://www.gov.uk/government/statistics/legal-aid-statistics-january-to-march-2021
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
download.file("https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/995925/legal-aid-statistics-civil-starts-provider-location-data-to-mar-2021.zip",
              "data_download/legalaid_work_locations.zip")

unzip("data_download/legalaid_work_locations.zip",
      exdir = "data_download/legalaid_work_locations")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Index of multiple deprivation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

download.file("https://opendatacommunities.org/downloads/cube-table?uri=http%3A%2F%2Fopendatacommunities.org%2Fdata%2Fsocietal-wellbeing%2Fdeprivation%2Fimd-income-score-2010",
              "data_download/IMD_2010_income.csv")

download.file("https://opendatacommunities.org/downloads/cube-table?uri=http%3A%2F%2Fopendatacommunities.org%2Fdata%2Fsocietal-wellbeing%2Fimd%2Findices",
              "data_download/IMD_2015.csv")

download.file("https://opendatacommunities.org/downloads/cube-table?uri=http%3A%2F%2Fopendatacommunities.org%2Fdata%2Fsocietal-wellbeing%2Fimd2019%2Findices",
              "data_download/IMD_2019.csv")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Boundary files for LSOAs
# (for drawing the data out)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

download.file("https://data.cambridgeshireinsight.org.uk/sites/default/files/Lower_Layer_Super_Output_Areas_December_2011_Generalised_Clipped__Boundaries_in_England_and_Wales.zip",
              "data_download/LSOA2011_boundaries.zip")

unzip("data_download/LSOA2011_boundaries.zip",
      exdir = "data_download/LSOA2011_boundaries")

download.file("http://geoportal1-ons.opendata.arcgis.com/datasets/fe6c55f0924b4734adf1cf7104a0173e_0.csv",
              "data_download/(December_2017)_Lookup_with_Area_Classifications_in_Great_Britain.csv")

download.file("http://geoportal1-ons.opendata.arcgis.com/datasets/3a4fa2ce68f642e399b4de07643eeed3_0.zip?outSR={%22latestWkid%22:27700,%22wkid%22:27700}",
              "data_download/la_shapes.zip")

unzip("data_download/la_shapes.zip",
      exdir = "data_download/la_shapes")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# ONS postcode directory
# (for converting postcode to location)
# https://geoportal.statistics.gov.uk/datasets/b8920bf40db14e04a59c331d1663d26e/about
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

download.file("https://www.arcgis.com/sharing/rest/content/items/b8920bf40db14e04a59c331d1663d26e/data",
              "data_download/onspd.zip")

unzip("data_download/onspd.zip",
      exdir = "data_download/onspd")

# #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# # Ordnance Survey location reference
# # (for converting uprns to location)
# #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

options(timeout = max(600, getOption("timeout"))) # as it is a big file, needs a longer timeout
download.file("https://api.os.uk/downloads/v1/products/OpenUPRN/downloads?area=GB&format=CSV&redirect",
              "data_download/uprns.zip")

unzip("data_download/uprns.zip",
      exdir = "data_download/uprns")



