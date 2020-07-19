# Getting and Cleaning Data Course Project CodeBook

This CodeBook describes the variables, data, and transformations performed to clean up the data.


### *Data Source*
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

### *Dataset Information*

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

### *Data cleanup*
*R Version 4.0.2 (2020-06-22)*

*dplyr package Version 1.0.0*

#### 1. Merges the training and the test sets to create one data set.
- Download, unzip and read files into R.
  
  'train/X_train.txt': Training set.

  'train/y_train.txt': Training labels.

  'test/X_test.txt': Test set.

  'test/y_test.txt': Test labels.
  
  'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

  'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- Merge training and test sets into one data set.

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
- Read file into R.

  'features.txt': List of all features.

- Identify features with measurements on mean and standard deviation. (mean(): Mean value, std(): Standard deviation)
  
- Extract selected rows and create new table.

#### 3. Uses descriptive activity names to name the activities in the data set
- Read file into R.

  'activity_labels.txt': Links the class labels with their activity name.

- Replace activity variable (integer, 1:6) with a factor with activity name.  

#### 4. Appropriately labels the data set with descriptive variable names.
- Replace variable names description.
  
  Replace 't' with 'Time'
  
  Replace 'f' with 'Frequency'
  
  Replace 'Acc' with 'Accelerometer'
  
  Replace 'Gyro' with 'Gyroscope'
  
  Replace 'Mag' with 'Magnitude'
  
  Replace 'BodyBody' with 'Body'

- Tidy data set created with 10299 rows and 563 columns.
#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Group tidy data set created in step 4 by subject and activity.

- Summarize each variable with the average of each subject and activity.

- Final tidy data set created with 180 rows and 68 columns.

- Write final tidy data set into .txt file.
