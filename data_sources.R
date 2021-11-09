

download.file("https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/802704/dwp-jcp-office-address-register.csv",
              "jobcentre_locations.csv")

download.file("https://files.digital.nhs.uk/assets/ods/current/epraccur.zip",
              "gp_locations.zip")

unzip("gp_locations.zip")

download.file("https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/995967/legal-aid-statistics-civil-completions-provider-area-data-to-mar-2021.zip",
              "legalaid_work_locations.zip")

unzip("legalaid_work_locations.zip")


download.file("https://www.arcgis.com/sharing/rest/content/items/b8920bf40db14e04a59c331d1663d26e/data",
             "onspd.zip")


unzip("onspd.zip")


download.file("https://opendatacommunities.org/downloads/cube-table?uri=http%3A%2F%2Fopendatacommunities.org%2Fdata%2Fsocietal-wellbeing%2Fimd%2Findices",
              "IMD_2015.csv")

download.file("https://opendatacommunities.org/downloads/cube-table?uri=http%3A%2F%2Fopendatacommunities.org%2Fdata%2Fsocietal-wellbeing%2Fimd2019%2Findices",
              "IMD_2019.csv")


download.file("https://data.cambridgeshireinsight.org.uk/sites/default/files/Lower_Layer_Super_Output_Areas_December_2011_Generalised_Clipped__Boundaries_in_England_and_Wales.zip",
              "LSOA2011_boundaries.zip")

unzip("LSOA2011_boundaries.zip")
