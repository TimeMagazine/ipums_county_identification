# The function to load IPUMS needs the "foreign" library, so run this if you don't have it
#install.packages("foreign")

source("id_counties.R")

ipums <- ipums_load("sample_data/usa_00121.sav")

# make a copy to compare final to for quality control
backup <- ipums

ipums <- ipums_get_counties(ipums)

# looks like a match!
print(paste(NROW(subset(ipums, is.na(ipums$COUNTY_FIPS))), "vs", NROW(subset(backup, backup$COUNTYFIPS == "0"))))

# should be zero, meaning we didn't fail to match any COUNTY_FIPS codes to names
print(NROW(subset(ipums, !is.na(ipums$COUNTY_FIPS) & ipums$COUNTY_NAME == "")))

# 431 out of 3,100+ counties show up in the 2015 ACS, apparently
print(paste("Found", length(unique(ipums$COUNTY_FIPS)), "unique counties."))