#########################################################
# Getting and Cleaning Data - Course Project - README.md
#########################################################

###################
## Description
###################
Course project for Getting and Cleaninf Data course offered by Coursera. This repo contains the R script run_alaysis.R to demonstrate the ability of the student to collect, work with, and clean a data set. 
The R script downloads, prepares and summarizes the original data test as requested by the course project instruction to prepare tidy data that can be used for later analysis.

## R Script functioning
#######################
The script downloads the original data set and its descripion from:

data: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
description: "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

The script will extract the contents of the zip file to a directory (UCI HAR Dataset) named within the working directory where the script is ran.

The script then merges the training and the test sets to create one data set. Extracts only the measurements on the mean and standard deviation for each measurement. Provides descriptive activity names to name the activities in the data set and labels the data set with descriptive variable names. 
finally processes the data set to produce a tidy data set with the average of each variable for each activity and each subject.

########################
## How to use the script
########################

Run the script ./run_analysys.R and the output file with the tidy datset will be created in the same working directory where run_analysis.was ran under the file named tidy_dataset.txt
