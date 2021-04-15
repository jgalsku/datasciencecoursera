# datasciencecoursera 
## Getting and Cleaning Data course

### Steps taken in the run_analysis.R file

1. load dplyr library and set working directory
2. load all data files needed to prepare tidy data set, this is achieved using readLines and read.table
3. bind subject, activity and data files from train and test data sets using rbind()
4. manipulate data files for subject, activity and data by labeling columns using names(), specifically using the features data to label the data columns
5. select variables of the data set that take the mean and standard deviation of the 3-axial signals using select() and contains()
6. rename activity label classes with descriptive activity labels by using match()
7. create tidy data set by finally binding activity labels, subjects and the selected data set using cbind()
8. write .txt file with the tidy data set
9. clean global environment to remove all objects except the tidy data set
10. create a second data set with the average of each variable for each activity for each subject
11. write .txt file with the second data set
