setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../../scripts/h2o-r-test-setup.R")



test.summary.factor <- function() {
  Log.info("Importing airlines data...\n")
  pathToData   <- normalizePath(locate("smalldata/airlines/allyears2k_headers.zip"))
  airlines.hex <- h2o.importFile(pathToData)
  airlines.dat <- as.data.frame(airlines.hex)
  
#   Log.info("Comparing R and H2O summaries...\n")
#   sumR <- summary(airlines.dat)
#   sumH2O <- summary(airlines.hex)
#   Log.info("R Summary:"); print(sumR)
#   Log.info("H2O Summary:"); print(sumH2O)
#   checkSummary(sumH2O, sumR)

  Log.info("Subset airlines dataset...\n")
  airlines.hex <- airlines.hex[airlines.hex$Year == 2005,]
  airlines.hex <- airlines.hex[airlines.hex$Origin == "ORD",]  
  airlines.dat <- as.data.frame(airlines.hex)
  
  Log.info("Compute and compare R and H2O Summaries...\n")
  sumR <- summary(airlines.dat)
  sumH2O <- summary(airlines.hex, exact_quantiles=TRUE)
#   Log.info("R Summary:"); print(sumR)
#   Log.info("H2O Summary:"); print(sumH2O)
#   checkSummary(sumH2O, sumR)
  
  
}

doTest("Summary Test: Prostate with Conversion of Cols to Factors", test.summary.factor)
