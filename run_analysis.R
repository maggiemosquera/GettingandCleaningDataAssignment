## -- 1. Merges the training and the test sets to create one data set.

library(dplyr)

setwd("~/Maggie/R_Magic/3_getting_and_cleaning_data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./accelerometers.zip")
dateDownloaded <- date()

unzip("./accelerometers.zip")
train_set <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityId", header = FALSE)
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjectId", header = FALSE)
test_set <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityId", header = FALSE)
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subjectId", header = FALSE)

subject_data <- rbind(train_subject, test_subject)
labels_data <- rbind(train_labels, test_labels)
set_data <- rbind(train_set, test_set)
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feat_variable"), header = FALSE)
names(set_data) <- features$feat_variable

merged_data <- cbind(subject_data, labels_data, set_data)


## -- 2. Extracts only the measurements on the mean and standard deviation for each measurement.

select_ft <- features$feat_variable[grep("(mean\\(\\)|std\\(\\))", features$feat_variable)]
select_names <- c("subjectId", "activityId", as.character(select_ft))
merged_select <- subset(merged_data, select = select_names)


## -- 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activity"), header = FALSE)
merged_select$activityId <- activity_labels[merged_select$activityId, 2]
merged_select$activityId <- factor(merged_select$activityId)


## -- 4. Appropriately labels the data set with descriptive variable names.

names(merged_select) <- gsub("^t", "Time", names(merged_select))
names(merged_select) <- gsub("^f", "Frequency", names(merged_select))
names(merged_select) <- gsub("Acc", "Accelerometer", names(merged_select))
names(merged_select) <- gsub("Gyro", "Gyroscope", names(merged_select))
names(merged_select) <- gsub("Mag", "Magnitude", names(merged_select))
names(merged_select) <- gsub("BodyBody", "Body", names(merged_select))

write.table(merged_select, "Merged_Dataset.txt", row.names = FALSE)


## -- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

other_tidy_data <- merged_select %>%
        group_by(subjectId, activityId) %>%
        summarise_all(funs(mean))
write.table(other_tidy_data, "Tidy_Dataset.txt", row.names = FALSE)
