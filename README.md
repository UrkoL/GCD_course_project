## README

This data set includes the following files
* 'README.md'
* 'CodeBook.md': shows information about the variables used in the tidy data set
* 'run_analysis.R': script with the data pre-processing to get a tidy data set from a raw data set
* 'tidydata.txt': tidy data set after running the 'run_analysis.R' script

The raw data have been downloaded from the following website:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Information regarding the variables used in the raw data set is provided within the zip file.

The script contains code to carry out the following steps:
* Download and unzip the raw data
* Merge the training sets and the test sets in an only data set
* Extract measurements regarding the mean and standard deviation (for that purpose, every measurement containing the words 'mean' and 'std' in its name has been taken into account)
* Change activity codes by activity names
* Change the labels of the variables (for that purpose, names have been changed to lower case format, commas have been substituted by dots and special characeres (parenthesis and dashes) have been eliminated; this naming strategy follows the guide presented in https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml)
* Create a tidy data set with the average of each variable for each activity and subject

Detailed information about each code line is given in the script file.