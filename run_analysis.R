# using dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# unzip all dataset under "data" folder


###### Step 1 read and merges the traning and the test set to create one data set.
# read the data and ccombine the rows
temp1 <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
temp2 <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subject <- rbind(temp1, temp2)

temp1 <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
temp2 <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
X <- rbind(temp1, temp2)

temp1 <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
temp2 <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
Y <- rbind(temp1, temp2)
rm(temp1, temp2)


###### Step 2 Extracts only the measurements on the mean and standard deviation for each measurement
# read the features file and select the features indices when features contain -mean() or -std()
features <- read.table("UCI HAR Dataset/features.txt")
selected_features_indices <- grep("-mean\\(\\)|-std\\(\\)", features[,2])

# select the features and assign the with features name
X <- X[,selected_features_indices]
names(X) <- features[selected_features_indices,2]
# remove "()" and replace features name with descriptive variable name
names(X) <- gsub("\\(|\\)", "", names(X))
names(X)<-gsub("^t", "time", names(X))
names(X)<-gsub("^f", "frequency", names(X))
names(X)<-gsub("Acc", "Accelerometer", names(X))
names(X)<-gsub("Gyro", "Gyroscope", names(X))
names(X)<-gsub("Mag", "Magnitude", names(X))
names(X)<-gsub("BodyBody", "Body", names(X))



###### Step 3 Uses descriptive activity names to name the activities in the dataset
# read the activity labels and remove the "_" and to lower case
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] = gsub("_", "", tolower(activities[,2]))

# replace the activities with labels
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"


###### Step 4 Appropriately labels the data set withg descriptive variable names
names(subject) <- "subject"
cleaned_data <- cbind(subject, Y, X)


###### Step 5 From the data set in step 4 creates a second, independent tidy data set with the average of each variable for each activity and subjects
# "." means "all other variables", compute the mean of each subject and each activity
tidy_data <- aggregate(. ~subject + activity, cleaned_data, mean)
# increasing order by subject and activity
tidy_data<-tidy_data[order(tidy_data$subject,tidy_data$activity),]
# write to file
write.table(tidy_data, file = "tidy_data.txt",row.name=FALSE)