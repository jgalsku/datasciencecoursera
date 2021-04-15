###########################################################################
# initial steps
###########################################################################


#load libraries
library(dplyr)

#set working directory
setwd("C:/Users/yo/Dropbox/coursera/Getting_and_Cleaning_Data/final project/UCI HAR Dataset")



###########################################################################
# to prepare tidy data set
###########################################################################

## Incorporate data sets and combine them 

#load train and test datasets
train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")
#bind train and test datasets by row
bind_data <- rbind(train, test)


## Incorporate feature data to label variables in data 

#load features
features <- readLines("./features.txt")
#assign features as column names of the bind data set
names(bind_data) <- features


## Select variables in combined data set

#extract the variables that measure mean() or std()
bind_data_meanstd <- select(bind_data, contains(c("mean()", "std()")))


## Load and process activity label data

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


## Load and process activity subject data

#load train and test subject data
train_subject <- read.table("train/subject_train.txt")
test_subject <- read.table("test/subject_test.txt")
#bind train and test subject data by row
bind_subject <- rbind(train_subject, test_subject)
#change the name of the subject variable to "subject" to make it easier to call and descriptive
names(bind_subject) <- "subject"


## Create tidy data set

#create the tidy data set by binding the activity label variable, subject variable, and the selected data sets for mean and std variables
tidy_data <- cbind(bind_labels, bind_subject, bind_data_meanstd)



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

#write txt file with second data set
setwd("C:/Users/yo/Dropbox/coursera/Getting_and_Cleaning_Data/final project/datasciencecoursera")
write.table(mean_per_activity_subject, file = "step5table.txt", row.name=FALSE) 
