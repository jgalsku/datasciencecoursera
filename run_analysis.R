# Getting and Cleaning Data Course Project
# 
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
#   
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
# 
# You should create one R script called run_analysis.R that does the following. 
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



#load libraries
library(dplyr)

#set working directory
setwd("C:/Users/yo/Dropbox/coursera/Getting_and_Cleaning_Data/final project/UCI HAR Dataset")



###########################################################################
# prepare tidy data set
###########################################################################

## data set

#load train and test datasets
train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")
#bind train and test datasets by row
bind_data <- rbind(train, test)


## features measured

#load features
features <- readLines("./features.txt")
#assign features as column names of the bind data set
names(bind_data) <- features


## select variables in data set 

#extract the variables that measure mean() or std()
bind_data_meanstd <- select(bind_data, contains(c("mean()", "std()")))


## activity labels

#load train and test class label data
train_labels <- read.table("train/y_train.txt")
test_labels <- read.table("test/y_test.txt")
#bind train and test class label data by row
bind_labels <- rbind(train_labels, test_labels)
#change the name of the class label variable to "activity" to make it easier to call and descriptive
names(bind_labels) <- "activity"
#load activity labels that links the class labels with their activity name.
activity_labels <- read.table("./activity_labels.txt")
#match and replace class labels with descriptive activity names
bind_labels$activity <- activity_labels[match(bind_labels$activity, activity_labels$V1),]$V2


## subject data

#load train and test subject data
train_subject <- read.table("train/subject_train.txt")
test_subject <- read.table("test/subject_test.txt")
#bind train and test subject data by row
bind_subject <- rbind(train_subject, test_subject)
#change the name of the subject variable to "subject" to make it easier to call and descriptive
names(bind_subject) <- "subject"


## tidy data

#create the tidy data set by binding the activity label variable, subject variable, and the selected data sets for mean and std variables
tidy_data <- cbind(bind_labels, bind_subject, bind_data_meanstd)

setwd("C:/Users/yo/Dropbox/coursera/Getting_and_Cleaning_Data/final project/datasciencecoursera")
write.table(tidy_data, file = "tidyDataSet.txt", row.name=FALSE) 


###########################################################################
# clean global environment
###########################################################################

#get list of the objects loaded separated by commas 
dput(ls())
#remove all objects except "tidy_data"
rm("activity_labels", "bind_data", "bind_data_meanstd", "bind_labels", 
   "bind_subject", "features", "test", "test_labels", 
   "test_subject", "train", "train_labels", "train_subject")




###########################################################################
# create second independent data set
###########################################################################

#create data set with the average of each variable for each activity and each subject.
mean_per_activity_subject <- tidy_data %>% group_by(activity, subject) %>% summarise(across(.cols = everything(), mean, .names = "mean_{.col}"))
mean_per_activity_subject


setwd("C:/Users/yo/Dropbox/coursera/Getting_and_Cleaning_Data/final project/datasciencecoursera")
write.table(mean_per_activity_subject, file = "step5table.txt", row.name=FALSE) 
