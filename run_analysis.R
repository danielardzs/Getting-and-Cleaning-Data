MyFile <- "Final_Asignment.zip"

# Check if file exists
if (!file.exists(MyFile)) {
  download.file("http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones", destfile = MyFile, method = curl)
}

# Check if folder exists
if (!file.exists("UCI HAR Dataset")) {
  unzip(MyFile)
}

# 1. Merges the training and the test sets to create one data set.

x<- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, x, y)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

MyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set

MyData$code <- activities[MyData$code ,2]

# 4. Appropriately labels the data set with descriptive variable names.

names(MyData) [2] = 'activity'
names(MyData) <- gsub("Acc", "Accelerometer", names(myData))
names(MyData) <- gsub("Gyro", "Gyroscope", names(MyData))
names(MyData) <- gsub("BodyBody", "Body", names(MyData))
names(MyData) <- gsub("Mag", "Magnitude", names(MyData))
names(MyData) <- gsub("^t", "Time", names(MyData))
names(MyData) <- gsub("^f", "Frequency", names(MyData))
names(MyData) <- gsub("tBody", "TimeBody", names(MyData))
names(MyData) <- gsub("-mean()", "Mean", names(MyData), ignore.case = TRUE)
names(MyData) <- gsub("-std()", "Standard Dev", names(MyData), ignore.case = TRUE)
names(MyData) <- gsub("-freq()", "Frequency", names(MyData), ignore.case = TRUE)
names(MyData) <- gsub("angle", "Angle", names(MyData))
names(MyData) <- gsub("gravity", "Gravity", names(MyData))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

BigData <- MyData %>%
  group_by(subject, activity) %>%
  summarize_all(funs(mean))
write.table(BigData, "BigData.txt", row.name = FALSE)



