# datasciencecoursera 
## Getting and Cleaning Data course

### Steps taken in the run_analysis.R file 

### Initial steps: 

- load dplyr library 
- set working directory 


### To prepare tidy data set: 

Incorporate data sets and combine them 
- load train and test datasets usind read.table() 
- bind train and test datasets into combined data set by row using rbind() 

Incorporate feature data to label variables in data 
- load features using readLines() 
- assign features as column names to the combined data set using names() 

Select variables in combined data set 
- extract the variables that measure mean() or std() in the combined dataset using select() and contains() 

Load and process activity label data 
- load train and test class label data using read.table() 
- bind train and test class label data by row using rbind() 
- change the name of the class label variable to "activity" to make it easier to call and descriptive using names() 
- load activity labels that link the class labels with their activity name using read.table() 
- match and replace class labels with descriptive activity names using match() 

Load and process activity subject data
- load train and test subject data using read.table()
- bind train and test subject data by row using rbind()
- change the name of the subject variable to "subject" to make it easier to call and descriptive using names() 

Create tidy data set
- create the tidy data set by binding the activity label variable, subject variable, and the selected data set for mean and std variables using cbind()



### Clean global environment

- get list of the objects loaded separated by commas using dput() and ls()
- remove all objects except the tidy_data



### Create second independent data set

- create data set with the average of each variable for each activity and each subject using dplyr's group_by(), summarise(), across() and mean(), and adding the string "mean" at the beggining of each modified variable name
- write a txt file with the second data set using write.table()

