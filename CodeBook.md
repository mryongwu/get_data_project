### Data Source
The data sets were downloaded as a zipped file from `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`.

### Data Processing
All the data sets were loaded into R using `read.table()` and were marked as `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test`. Similar data sets were then merged, for example, `x_train` and `x_test` were merged into `x_data` set, `y_train` and `y_test` were merged into `y_data` set, etc. These merged data sets were subsequently combined into a `final_data` set using `cbind()`.

Those columns with the mean and standard deviation measures from the whole dataset were extracted and more descriptive names were assigned to each column, taken from the file `features.txt`.

The activity names were also used as described in `activity_labels.txt` file to make sure that the descriptions of activities were readable.

Finally, a new dataset were generated with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `average_data.txt`, and uploaded to this repository.

### Variables 

* `activityId`: Activity ID
* `activityType`: Activity type
* `subjectId`: Subject ID
* `timeBodyAccMagnitudeMean`: Average time of body acceleration magnitude.
* `timeBodyAccMagnitudeStdDev`: Standard deviation of time of body acceleration magnitude.
* `timeGravityAccMagnitudeMean`: Average time of gravity acceleration magnitude.
* `timeGravityAccMagnitudeStdDev`: Standard deviation of time of gravity acceleration magnitude.
* `timeBodyAccJerkMagnitudeMean`: Average time of body acceleration jerk magnitude.
* `timeBodyAccJerkMagnitudeStdDev`: Standard deviation of time of body acceleration jerk magnitude.
* `timeBodyGyroMagnitudeMean`: Average time of body gyroscope magnitude.
* `timeBodyGyroMagnitudeStdDev`: Standard deviation of time of body gyroscope magnitude.
* `timeBodyGyroJerkMagnitudeMean`: Average time of body gyroscope jerk magnitude.
* `timeBodyGyroJerkMagnitudeStdDev`: Standard deviation of time of body gyroscope jerk magnitude.
* `freqBodyAccMagnitudeMean`: Average frequency of body acceleration magnitude
* `freqBodyAccMagnitudeStdDev`: Standard deviation of frequency of body acceleration magnitude.   
* `freqBodyAccJerkMagnitudeMean`: Average frequency of body acceleration jerk magnitude
* `freqBodyAccJerkMagnitudeStdDev`: Standard deviation of frequency of body acceleration jerk magnitude.  
* `freqBodyGyroMagnitudeMean`: Average frequency of body gyroscope magnitude.
* `freqBodyGyroMagnitudeStdDev`: Standard deviation of body gyroscope magnitude. 
* `freqBodyGyroJerkMagnitudeMean`: Average frequency of body gyroscope jerk magnitude.
* `freqBodyGyroJerkMagnitudeStdDev`: Standard deviation of body gyroscope jerk magnitude.
