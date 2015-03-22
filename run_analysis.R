#==============================================================================
# R script (run_analysis.R) that does the following:
# --------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#==============================================================================

#------------------------------------------------------------------------------
# Notes:
# 1. The script only tested on windows 8.1 with R Studio only.
#------------------------------------------------------------------------------


#==============================================================================
# Check required packages and install if  necessary:
# --------------------------------------------------
# dplyr: Library for fast, consistent tool for working with data frame like 
#        objects, both in memory and out of memory.
#------------------------------------------------------------------------------

if (!require('dplyr')) packages.install('dplyr'); library('dplyr')

#------------------------------------------------------------------------------
# data.table: Fast aggregation of large data (e.g. 100GB in RAM), fast  
#             ordered joins, fast add/modify/delete of columns by group  
#             copies at all, list # using no columns and a fast file 
#             reader (fread).
#------------------------------------------------------------------------------

if (!require('data.table')) packages.install('data.table'); library('data.table')

#==============================================================================

#------------------------------------------------------------------------------
# Store Web data source as data.url
#------------------------------------------------------------------------------
data.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

#------------------------------------------------------------------------------
# Define course project working directory
#------------------------------------------------------------------------------
working.directory.path <- file.path(getwd(), 'getting-and-cleaning-data-project')

#------------------------------------------------------------------------------
# Define  subfolder to holds the data set
#------------------------------------------------------------------------------
data.directory.name <- 'UCI HAR Dataset'

#==============================================================================
# Set with descriptive variable names fucntion:
# 1. Removing illegal characters, duplicate words 
# 2. Expanding prefixes to make more readable. 
# 3. Covert all to lowercase and separate the components with periods.
#==============================================================================

CleanVariableName <- function (var) {

#------------------------------------------------------------------------------
# Remove parentheses and replace hyphens to dot
#------------------------------------------------------------------------------
  var <- gsub('[(]', '', var)
  var <- gsub('[)]', '', var)
  var <- gsub('[-]', '.', var)

#------------------------------------------------------------------------------
# Converting 't' to 'time' and 'f' to 'frequency'
#------------------------------------------------------------------------------
  prefix <- 'time'
  if (substr(var, 1, 1) == 'f') {
    prefix <- 'frequency'    
  }

#------------------------------------------------------------------------------
# Remove the first character as replacing it with the prefix
#------------------------------------------------------------------------------
  var <- substring(var, 2)

#------------------------------------------------------------------------------
# Remove the infamous double Body variable names
#------------------------------------------------------------------------------
  var <- gsub("BodyBody", "Body", var)
  var <- gsub("Acc", "Accelerometer", var)
  var <- gsub("Gyro", "Gyroscope", var)
  var <- gsub("Mag", "Magnitude", var)

#------------------------------------------------------------------------------
# Concatenate the prefix and variable name.
#------------------------------------------------------------------------------
  return(paste(prefix, tolower(var), sep = '.'))
}

#==============================================================================
# Load dataset function: 
# 1. Loads the train or test dataset into a data.frame; 
# 2. Filters and names the columns according to requirements
#==============================================================================

LoadDataSet <- function (set) {

#------------------------------------------------------------------------------
# Create the base path based on the data set we are loading
#------------------------------------------------------------------------------  
  path = file.path(getwd(), data.directory.name, set)

#------------------------------------------------------------------------------  
# Load data from disk
#------------------------------------------------------------------------------
subjects <- read.table(file.path(path, paste('subject_', set, '.txt', sep = '')))
  activities <- read.table(file.path(path, paste('y_', set, '.txt', sep = '')))
  metrics <- read.table(file.path(path, paste('X_', set, '.txt', sep = '')))

#------------------------------------------------------------------------------  
# Appropriately labels the data set with descriptive variable names. 
#------------------------------------------------------------------------------
  metric.labels <- sapply(metric.labels, CleanVariableName)
  names(metrics) <- metric.labels

#------------------------------------------------------------------------------
# Extracts the mean and standard deviation for each measurement. 
# .meanFreq and angle(*Mean*) are excluded; they're not measurements on the mean
#------------------------------------------------------------------------------
  columnIndexes = sapply(metric.labels, function(colname){ grepl(colname,  pattern = "\\.std") | (grepl(colname,  pattern = "\\.mean") & !grepl(colname,  pattern = "\\.meanfreq")) })
  metrics <- metrics[, columnIndexes]

#------------------------------------------------------------------------------
# Bind subject and activities, then bind metrics
#------------------------------------------------------------------------------
  data <- cbind(subjects, activities)
  names(data) <- c('subject', 'activity')
  data <- cbind(data, metrics)
  
#------------------------------------------------------------------------------
# Clean up some variables to free up memory
#------------------------------------------------------------------------------
  remove(activities)
  remove(metrics)
  remove(subjects)

#------------------------------------------------------------------------------
# Return the data set
#------------------------------------------------------------------------------
  data
}

#==============================================================================
# Sets the working directory function:
# 1. Create the working directory folder if it does not exist
#==============================================================================

SetWorkingDirectory <- function () {
  if(!file.exists(working.directory.path)) {
    dir.create(working.directory.path)
  }

#------------------------------------------------------------------------------  
# Show error if the folder doesn't exist and halt.
#------------------------------------------------------------------------------
  if(!file.exists(working.directory.path)) {
    stop('Unable to establish working directory')    
  }

#------------------------------------------------------------------------------
# Set the working directory
#------------------------------------------------------------------------------
  setwd(working.directory.path)
}

#==============================================================================
# Data set download function:
# 1. Downloads the UCI HAR dataset if we don't already have it locally
#==============================================================================

DownloadDataIfNecessary <- function () {
  datapath <- file.path(working.directory.path, data.directory.name)

#------------------------------------------------------------------------------  
# Check if the UCI subfolder exists; the complete dataset is there
#------------------------------------------------------------------------------
  if (file.exists(datapath)) {
    return(NULL)
  }

#------------------------------------------------------------------------------
# Download and unzip the data set
#------------------------------------------------------------------------------
  message('Downloading the data set; this may take a few moments...')
  tmp <- tempfile()    
  download.file(data.url, tmp, cacheOK = TRUE)
  unzip(tmp)
  unlink(tmp)

#------------------------------------------------------------------------------
# If the data folder still does not exist, something is wrong and stop.
#------------------------------------------------------------------------------
  if (!file.exists(datapath)) {
    stop('Unable to acquire data')
  }
}

###############################################################################
# start of Mail Routine:
# ----------------------
# 1. Set up working environment and check data set. 
# 2. Download dataset if not exist locally.
#
###############################################################################
  SetWorkingDirectory()
  DownloadDataIfNecessary()

#------------------------------------------------------------------------------
# Load labels from disk
#------------------------------------------------------------------------------
metric.labels <- read.table(file.path(getwd(), data.directory.name, 'features.txt'))[, 2]
activity.labels <- as.character(read.table(file.path(getwd(), data.directory.name, 'activity_labels.txt'))[, 2])

#------------------------------------------------------------------------------
# Merges the training and the test sets to create one dataset.
#------------------------------------------------------------------------------
message('Reading data.....')
  data <- rbind(LoadDataSet('train'), LoadDataSet('test'))

#------------------------------------------------------------------------------
# Uses descriptive activity names to name the activities in the dataset. 
# Sort by activity so we can factor activities and apply the labels.
#------------------------------------------------------------------------------
data <- data[order(data[,2]), ]
  data[,2] <- factor(data[,2], labels = activity.labels)

#------------------------------------------------------------------------------
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#------------------------------------------------------------------------------
  summarized.data <- group_by(data, subject, activity) %>% summarise_each(funs(mean))

#------------------------------------------------------------------------------
# Output data to disk in fulfillment of: upload your data set as a txt file created with write.table() using row.name=FALSE
#------------------------------------------------------------------------------
  message('Writing data....')
  write.table(summarized.data, row.name=FALSE, file='./Tidy-UCI-HAR-Dataset.txt')
  message('Done')
