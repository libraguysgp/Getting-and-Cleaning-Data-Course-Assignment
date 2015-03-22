## Code book

The tidy data set consists of a subset of the fields from the ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

### Original Study Design

The UCI HAR data set, upon which our study is based, contains the following description of how the original study was conducted (from its readme.txt):

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


### Tidy Data Study Design

#### Recombining the original data set
We downloaded the UCI HAR data set on 2014-12-20. Since the data set is spread over a number of separate files, it was necessary to reassemble it. We combined the subjects, the observations, and the list of activities [using the files subject_*.txt, X_*.txt, and y_*.txt] into a single data.frame, then applied the column names and factored the activity column using the provided activity labels (the features.txt and activity_labels.txt files). We repeated this for both the train and test subsets and then combined the subsets into a final data.frame.

This recombination produces a data set with a number of characterics of tidy data. Each observation is in a single row. Each variable is in a single column. Also, since the train and test subsets are merely subsets of the same kind of data, it is appropriate to combine them into a single table.

#### Removing some columns
To produce the designated subset of only mean and std variables, we removed all columns where the original name did not contain -std or -mean. This method deliberately excludes a number of columns with 'mean' in the name because they are not actually mean values. This includes variables containing "meanFreq" and the variables which begin with "angle." We also retained the subject and activity columns.

#### Tidying up the column names
We have renamed the metrics column names to make them more descriptive and human readable. The codebook contains a mapping of new variable names to old variable names.
* The prefixes 't' and 'f'  have been replaced with 'time' and 'frequency' respectively so our readers will not have to look up their meanings.
* Illegal and non-semantic characters have been removed. eg. "(" and ")" and "-"
* Removed duplicate phrases in variable names. eg. 'BodyBody' becomes 'Body'
* Columns names have been converted to lower case as is common in tidy data.
* Although tidy data often avoids using punctuation in column names, here we choose deliberately to separate the various elements of the names with periods to make them more human readable. It is not readable to have long compound variable names be both lower case and to lack separators. Periods in variable names are legal and common in R practice. 
    * eg. "mean.frequency.bodyacc.std.x" vs meanfrequencybodyaccstdx"
* Since the columns in the tidy data set represent the mean of each variable (See the 'Summarizing the data' section below), we have also prefixed the column names with "mean."

#### Summarizing the data
We grouped the data by subject and activity, then calculated the mean of each metric in order to create "a second, independent tidy data set with the average of each variable for each activity and each subject."

### 
The UCI HAR data set's codebook (features_info.txt) describes the original variables this way:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

### Codebook

* **subject**
  * integer. 1 to 30. The identifier of the study subject.
* **activity**
  * character. The physical activity in which the subject was engaged at the time of the observation. 
    1. WALKING 
    2. WALKING_UPSTAIRS 
    3. WALKING_DOWNSTAIRS 
    4. SITTING 
    5. STANDING 
    6. LAYING
* **mean.time.bodyacc.mean.x**
	* number. The mean of the tBodyAcc-mean()-X variable from the UCI HAL data set
* **mean.time.bodyacc.mean.y**
	* number. The mean of the tBodyAcc-mean()-Y variable from the UCI HAL data set
* **mean.time.bodyacc.mean.z**
	* number. The mean of the tBodyAcc-mean()-Z variable from the UCI HAL data set
* **mean.time.bodyacc.std.x**
	* number. The mean of the tBodyAcc-std()-X variable from the UCI HAL data set
* **mean.time.bodyacc.std.y**
	* number. The mean of the tBodyAcc-std()-Y variable from the UCI HAL data set
* **mean.time.bodyacc.std.z**
	* number. The mean of the tBodyAcc-std()-Z variable from the UCI HAL data set
* **mean.time.gravityacc.mean.x**
	* number. The mean of the tGravityAcc-mean()-X variable from the UCI HAL data set
* **mean.time.gravityacc.mean.y**
	* number. The mean of the tGravityAcc-mean()-Y variable from the UCI HAL data set
* **mean.time.gravityacc.mean.z**
	* number. The mean of the tGravityAcc-mean()-Z variable from the UCI HAL data set
* **mean.time.gravityacc.std.x**
	* number. The mean of the tGravityAcc-std()-X variable from the UCI HAL data set
* **mean.time.gravityacc.std.y**
	* number. The mean of the tGravityAcc-std()-Y variable from the UCI HAL data set
* **mean.time.gravityacc.std.z**
	* number. The mean of the tGravityAcc-std()-Z variable from the UCI HAL data set
* **mean.time.bodyaccjerk.mean.x**
	* number. The mean of the tBodyAccJerk-mean()-X variable from the UCI HAL data set
* **mean.time.bodyaccjerk.mean.y**
	* number. The mean of the tBodyAccJerk-mean()-Y variable from the UCI HAL data set
* **mean.time.bodyaccjerk.mean.z**
	* number. The mean of the tBodyAccJerk-mean()-Z variable from the UCI HAL data set
* **mean.time.bodyaccjerk.std.x**
	* number. The mean of the tBodyAccJerk-std()-X variable from the UCI HAL data set
* **mean.time.bodyaccjerk.std.y**
	* number. The mean of the tBodyAccJerk-std()-Y variable from the UCI HAL data set
* **mean.time.bodyaccjerk.std.z**
	* number. The mean of the tBodyAccJerk-std()-Z variable from the UCI HAL data set
* **mean.time.bodygyro.mean.x**
	* number. The mean of the tBodyGyro-mean()-X variable from the UCI HAL data set
* **mean.time.bodygyro.mean.y**
	* number. The mean of the tBodyGyro-mean()-Y variable from the UCI HAL data set
* **mean.time.bodygyro.mean.z**
	* number. The mean of the tBodyGyro-mean()-Z variable from the UCI HAL data set
* **mean.time.bodygyro.std.x**
	* number. The mean of the tBodyGyro-std()-X variable from the UCI HAL data set
* **mean.time.bodygyro.std.y**
	* number. The mean of the tBodyGyro-std()-Y variable from the UCI HAL data set
* **mean.time.bodygyro.std.z**
	* number. The mean of the tBodyGyro-std()-Z variable from the UCI HAL data set
* **mean.time.bodygyrojerk.mean.x**
	* number. The mean of the tBodyGyroJerk-mean()-X variable from the UCI HAL data set
* **mean.time.bodygyrojerk.mean.y**
	* number. The mean of the tBodyGyroJerk-mean()-Y variable from the UCI HAL data set
* **mean.time.bodygyrojerk.mean.z**
	* number. The mean of the tBodyGyroJerk-mean()-Z variable from the UCI HAL data set
* **mean.time.bodygyrojerk.std.x**
	* number. The mean of the tBodyGyroJerk-std()-X variable from the UCI HAL data set
* **mean.time.bodygyrojerk.std.y**
	* number. The mean of the tBodyGyroJerk-std()-Y variable from the UCI HAL data set
* **mean.time.bodygyrojerk.std.z**
	* number. The mean of the tBodyGyroJerk-std()-Z variable from the UCI HAL data set
* **mean.time.bodyaccmag.mean**
	* number. The mean of the tBodyAccMag-mean() variable from the UCI HAL data set
* **mean.time.bodyaccmag.std**
	* number. The mean of the tBodyAccMag-std() variable from the UCI HAL data set
* **mean.time.gravityaccmag.mean**
	* number. The mean of the tGravityAccMag-mean() variable from the UCI HAL data set
* **mean.time.gravityaccmag.std**
	* number. The mean of the tGravityAccMag-std() variable from the UCI HAL data set
* **mean.time.bodyaccjerkmag.mean**
	* number. The mean of the tBodyAccJerkMag-mean() variable from the UCI HAL data set
* **mean.time.bodyaccjerkmag.std**
	* number. The mean of the tBodyAccJerkMag-std() variable from the UCI HAL data set
* **mean.time.bodygyromag.mean**
	* number. The mean of the tBodyGyroMag-mean() variable from the UCI HAL data set
* **mean.time.bodygyromag.std**
	* number. The mean of the tBodyGyroMag-std() variable from the UCI HAL data set
* **mean.time.bodygyrojerkmag.mean**
	* number. The mean of the tBodyGyroJerkMag-mean() variable from the UCI HAL data set
* **mean.time.bodygyrojerkmag.std**
	* number. The mean of the tBodyGyroJerkMag-std() variable from the UCI HAL data set
* **mean.frequency.bodyacc.mean.x**
	* number. The mean of the fBodyAcc-mean()-X variable from the UCI HAL data set
* **mean.frequency.bodyacc.mean.y**
	* number. The mean of the fBodyAcc-mean()-Y variable from the UCI HAL data set
* **mean.frequency.bodyacc.mean.z**
	* number. The mean of the fBodyAcc-mean()-Z variable from the UCI HAL data set
* **mean.frequency.bodyacc.std.x**
	* number. The mean of the fBodyAcc-std()-X variable from the UCI HAL data set
* **mean.frequency.bodyacc.std.y**
	* number. The mean of the fBodyAcc-std()-Y variable from the UCI HAL data set
* **mean.frequency.bodyacc.std.z**
	* number. The mean of the fBodyAcc-std()-Z variable from the UCI HAL data set
* **mean.frequency.bodyaccjerk.mean.x**
	* number. The mean of the fBodyAccJerk-mean()-X variable from the UCI HAL data set
* **mean.frequency.bodyaccjerk.mean.y**
	* number. The mean of the fBodyAccJerk-mean()-Y variable from the UCI HAL data set
* **mean.frequency.bodyaccjerk.mean.z**
	* number. The mean of the fBodyAccJerk-mean()-Z variable from the UCI HAL data set
* **mean.frequency.bodyaccjerk.std.x**
	* number. The mean of the fBodyAccJerk-std()-X variable from the UCI HAL data set
* **mean.frequency.bodyaccjerk.std.y**
	* number. The mean of the fBodyAccJerk-std()-Y variable from the UCI HAL data set
* **mean.frequency.bodyaccjerk.std.z**
	* number. The mean of the fBodyAccJerk-std()-Z variable from the UCI HAL data set
* **mean.frequency.bodygyro.mean.x**
	* number. The mean of the fBodyGyro-mean()-X variable from the UCI HAL data set
* **mean.frequency.bodygyro.mean.y**
	* number. The mean of the fBodyGyro-mean()-Y variable from the UCI HAL data set
* **mean.frequency.bodygyro.mean.z**
	* number. The mean of the fBodyGyro-mean()-Z variable from the UCI HAL data set
* **mean.frequency.bodygyro.std.x**
	* number. The mean of the fBodyGyro-std()-X variable from the UCI HAL data set
* **mean.frequency.bodygyro.std.y**
	* number. The mean of the fBodyGyro-std()-Y variable from the UCI HAL data set
* **mean.frequency.bodygyro.std.z**
	* number. The mean of the fBodyGyro-std()-Z variable from the UCI HAL data set
* **mean.frequency.bodyaccmag.mean**
	* number. The mean of the fBodyAccMag-mean() variable from the UCI HAL data set
* **mean.frequency.bodyaccmag.std**
	* number. The mean of the fBodyAccMag-std() variable from the UCI HAL data set
* **mean.frequency.bodyaccjerkmag.mean**
	* number. The mean of the fBodyBodyAccJerkMag-mean() variable from the UCI HAL data set
* **mean.frequency.bodyaccjerkmag.std**
	* number. The mean of the fBodyBodyAccJerkMag-std() variable from the UCI HAL data set
* **mean.frequency.bodygyromag.mean**
	* number. The mean of the fBodyBodyGyroMag-mean() variable from the UCI HAL data set
* **mean.frequency.bodygyromag.std**
	* number. The mean of the fBodyBodyGyroMag-std() variable from the UCI HAL data set
* **mean.frequency.bodygyrojerkmag.mean**
	* number. The mean of the fBodyBodyGyroJerkMag-mean() variable from the UCI HAL data set
* **mean.frequency.bodygyrojerkmag.std**
	* number. The mean of the fBodyBodyGyroJerkMag-std() variable from the UCI HAL data set