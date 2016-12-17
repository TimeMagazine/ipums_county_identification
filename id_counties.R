library(foreign);

# import the SPSS file from IPUMS
# you may get an error about duplix factor indices. You can ignore it.
ipums_load <- function(filepath) {
  ipums <- read.spss(filepath, to.data.frame = TRUE)
  print(paste("Loaded", NROW(ipums), "rows."));

  print("Converting factors to the appropriate types")
  
  # Year should be an integer, strange as that may seem
  ipums$YEAR     <- as.numeric(as.character(ipums$YEAR))
  
  # de-factorize any of these columns into characters if present
  factor_to_character_columns <- c( "STATEFIP", "COUNTY", "COUNTYFIPS")

  # intersecting to just loop through the above columns we have in this data frame
  for (column in intersect(factor_to_character_columns, colnames(ipums))) {
    ipums[[column]] <- as.character(ipums[[column]])
  }

  return(ipums);
}

# STATES and COUNTIES
ipums_get_counties <- function(ipums) {
  if (!("STATEFIP" %in% colnames(ipums)) | !("COUNTYFIPS" %in% colnames(ipums))) {
    print("Skipping `ipums_get_counties` since 'STATEFIP' and 'COUNTYFIPS' aren't both present.")  
    return(ipums);
  }
  
  print("First, add state FIPs values and abbreviations")
  
  # states.csv comes directly from the Census
  canonical <- as.data.frame(read.csv("fips/states.csv",
    colClasses=c("character","character","character","logical")
  ))
  
  # since we imports the SPSS version, STATEFIP is already the name
  ipums$STATE_NAME <- ipums$STATEFIP
  ipums$STATE_ABBR <- "" # We'll fill this in shortly
  ipums$STATE_FIPS <- "" # Ditto
  
  # We don't need STATEFIP anymore, but we'll leave it in case your code uses it
  # Just uncomment following line to get rid of it
  #ipums <- subset(ipums, select = -STATEFIP )

  # for each row in the canonical file, update the matching states
  convertField <- function(row) {
    fips <- row$FIPS
    abbr <- row$ABBR
    name <- row$NAME
    
    print(paste("Setting FIPS values for", name))
    
    ipums$STATE_FIPS[ipums$STATE_NAME==name] <- fips
    ipums$STATE_ABBR[ipums$STATE_NAME==name] <- abbr
    return (ipums);
  }
  
  for (i in 1:NROW(canonical)) {
    ipums <- convertField(canonical[i,])
  }
  
  #COUNTIES

  # function to add leading zeroes where needed
  substrRight <- function(x, n){
    substr(x, nchar(x)-n+1, nchar(x))
  }    
  
  # create full five-digit code 
  ipums$COUNTY_FIPS <- paste(ipums$STATE_FIPS, substrRight(paste("000", ipums$COUNTYFIPS, sep=""), 3), sep="")
  # DC is incorrect
  ipums$COUNTY_FIPS[ipums$COUNTY_FIPS=="11010"] <- "11001"
  ipums$COUNTY_FIPS[ipums$COUNTYFIPS == "0"] <- NA
  missing <- subset(ipums, is.na(ipums$COUNTY_FIPS))
  print(paste("Found", prettyNum(NROW(ipums) - NROW(missing), big.mark=","), "records with county fips codes.", prettyNum(NROW(missing), big.mark=","), "were not present."))

  # Match FIPS codes. Data also from Census
  canonical <- as.data.frame(read.csv("fips/counties.csv",
    colClasses=rep("character", 4)
  ));
  canonical <- subset(canonical, select=c(FIPS, NAME))
  colnames(canonical) <- c("COUNTY_FIPS", "COUNTY_NAME")

  print("Merging counties with records. This will just take a sec.")
  
  # this time, let's try merging. Easier than looping through 3,000+ counties
  ipums <- merge(ipums, canonical, by="COUNTY_FIPS", all.x=TRUE)
  
  # no longer need COUNTYFIPS
  ipums <- subset(ipums, select = -COUNTYFIPS)
  
  # reorder the columns to be grouped together

  # move COUNTY_FIPS from first in order, which merge took the liberty of doing
  ipums <- subset(ipums, select=c(2:NCOL(ipums),1))

  return(ipums);
}