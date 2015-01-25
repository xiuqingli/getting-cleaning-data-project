Getting and cleaning data course project
==============================================
For creating a tidy data set using dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Files in the repository
* README.md -- the file you are reading it now
* CodeBook.md -- codebook for describing variables, data and data transformations
* run_analysis.R -- R code for the project 

### run_analysis.R 
##### The script solve following questions
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The dataset folder "UCI HAR Dataset" need to be in the same directory of the script.