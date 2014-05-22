# This script follows the steps of the course project,
# taking raw data and obtaining tidy data

## Step 1
# Download zip file
download.file(url="http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="data.zip")
# Unzip file
unzip(zipfile="data.zip")
# Extract training and test sets
feat <- read.table("UCI HAR Dataset/features.txt")
tr_x <- read.table("UCI HAR Dataset/train/X_train.txt")
tr_y <- read.table("UCI HAR Dataset/train/y_train.txt")
ts_x <- read.table("UCI HAR Dataset/test/X_test.txt")
ts_y <- read.table("UCI HAR Dataset/test/y_test.txt")
tr_s <- read.table("UCI HAR Dataset/train/subject_train.txt")
ts_s <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Convert data of factor class to character class
feat[,2] <- as.character(feat[,2])
# Rename column names of the training and test sets using feature names
names(tr_x) <- feat[,2]
names(ts_x) <- feat[,2]
# Merge training and test sets
x <- rbind(tr_x,ts_x)
# Merge subject info for training and test sets
subj <- rbind(tr_s,ts_s)
# Set the name of the subject column
names(subj) <- "Subject"
# Merge activity info for training and test sets
act <- rbind(tr_y,ts_y)
# Set the name of the activity column
names(act) <- "Activity"
# Merge the training and test sets with subject and activity information
data <- cbind(x,subj,act)

## Step 2
# Find and sort the columns that have as names the strings "mean" or "std"
query <- sort(c(grep("mean",names(data)),grep("std",names(data))))
# Include activity and subject column indexes
query <- c(query,dim(data)[2]-1,dim(data)[2])
# Extract the previous columns from the data set
meanstd <- data[,query]

## Step 3
# Read the labels of the activities
actname <- read.table("UCI HAR Dataset/activity_labels.txt")
# Convert data of factor class to character class
actname$V2 <- as.character(actname$V2)
# A loop replaces all the codes in the activity column with their corresponding
# strings
for (i in actname[,1]) {
    meanstd$Activity <- replace(meanstd$Activity,meanstd$Activity==i,actname[i,2])
}

## Step 4
# https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
# Extract column names
meanstdname <- names(meanstd)
# Change characters to lower case
meanstdname <- tolower(meanstdname)
# Substitute commas by dots
meanstdname <- gsub(",",".",meanstdname)
# Eliminate dashes
meanstdname <- gsub("-","",meanstdname)
# Eliminate parenthesis
meanstdname <- gsub("(", "", meanstdname,fixed=TRUE)
meanstdname <- gsub(")", "", meanstdname,fixed=TRUE)
# Update data column names with the previous changes
names(meanstd) <- meanstdname

## Step 5
# Load library for using melt and cast functions
library(reshape2)
# Melt data taking subject and activity as id variables
aux <- melt(meanstd, id.vars=c("subject","activity"))
# Calculate the mean of the data bay subject and activity
tidydata <- dcast(aux, subject + activity ~ variable, fun.aggregate=mean)
# Save the tidy data set
write.table(tidydata,"tidydata.txt")
# Use read.table("tidydata.txt") for reading the output data file