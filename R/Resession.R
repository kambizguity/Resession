setwd("C:/Users/Kambiz/Desktop/Projects/Resession/Resession")



#Source
source("function.R")


# Check Directories -------------------------------------------------------
directories <-
  c("Export",
    "Export\\Csv",
    "Export\\Plot",
    "Export\\Csv\\SeperatedSessions")

# Make Directories --------------------------------------------------------
for (directory in directories) {
  if (!dir.exists(directory)) {
    dir.create(directory)
  }
}

rm(directories, directory)
# titleOfColumns ----------------------------------------------------------
titles <- c("Date", "Time", "Open", "High", "Low", "Close")

# Filename of source ------------------------------------------------------
listOfFiles <- list.files("Source")
print(listOfFiles)
print("Select source file to read data:")

file <- readline("Type index of file to read as a csv file:")

if (!is.na(file)) {
  fileName <- listOfFiles [as.numeric(file)]
  fileName <- "BTCUSD_Candlestick_1_M_BID_01.01.2022-25.06.2022.csv"
  dataFrame <- NA
  # Read data from csv file -------------------------------------------------
  dataFrame <- read.csv(paste("Source", fileName, sep = "/"))
  head (dataFrame)
  # Rearrange data frame ----------------------------------------------------
  dataColumn <- apply(dataFrame[1], 2, substr, 0, 10)
  dataFrame <- cbind (dataFrame, dataColumn)
  dataColumn <- apply(dataFrame[1], 2, substr, 12, 19)
  dataFrame <- cbind (dataFrame, dataColumn)
  # Remove Volume & DateTime Columns-----------------------------------------
  dataFrame <- dataFrame [ c(-1, -6)]
  dataFrame <- dataFrame [c(5, 6, 1, 2, 3, 4)]
  
  
  # Set titles to columns ---------------------------------------------------
  colnames(dataFrame) <- titles
  head (dataFrame)
  
  # Get Parameters ----------------------------------------------------------
  print("Start time(hour)")
  startHour <- readline("Hour:")
  startHour <- CheckNumber(startHour, TRUE)
  startMinute <- readline("Minute:")
  startMinute <- CheckNumber(startMinute, FALSE)
  print("End time(hour)")
  endHour <- readline("Hour:")
  endHour <- CheckNumber(endHour, TRUE)
  endMinute <- readline("Minute:")
  endMinute <- CheckNumber(endMinute, FALSE)
  
  startTime <- paste (startHour , ":" , startMinute, ":00", sep = "")
  endTime <-  paste (endHour , ":" , endMinute, ":00", sep = "")
  
  head (dataFrame)
  
  timeColumn <-
    as.POSIXlt(strptime(dataFrame$Time, format = "%H:%M:%S", tz = "GMT"))
  sessionFrame <-
    dataFrame [which (dataFrame$Time >= startTime &
                        dataFrame$Time < endTime),]
  
  writeIntoFile <-
    readline(prompt = "Do you want to store dataframe into csv file? (Yes,No)")
  
  if (tolower(writeIntoFile) == "yes") {
    fileName <-
      paste (
        "Export\\BTCUSD-CustomSession",
        gsub (":", "", startTime),
        "To",
        gsub (":", "", endTime),
        ".csv",
        sep = ""
      )
    write.csv(sessionFrame, file = fileName)
  }
  
  print(head (sessionFrame))
  startPoints <- which (sessionFrame$Time == startTime)
  length(startSessions)
  
  endPoints <- which (sessionFrame$Time == startTime)
  length(startSessions)
  
  for (counter in 1:length(startSessions)) {
    print(counter)
  }
}
