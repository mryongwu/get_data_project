# This script assumes that all data sets are unzipped in the current working 
# directory.

###############################################################################
# Step 1: Merge the training and test sets to create one data set
###############################################################################

x_train <- read.table("./train/X_train.txt", header=FALSE)
y_train <- read.table("./train/y_train.txt", header=FALSE)
subject_train <- read.table("./train/subject_train.txt", header=FALSE)
features <- read.table("features.txt", header=FALSE)
activities <- read.table("activity_labels.txt", header=FALSE)

# Assigning column names
colnames(activities)  = c('activityId','activityType');
colnames(subject_train)  = "subjectId";
colnames(x_train)        = features[,2]; 
colnames(y_train)        = "activityId";

# Read in the test data
x_test <- read.table("./test/X_test.txt", header=FALSE)
y_test <- read.table("./test/y_test.txt", header=FALSE)
subject_test <- read.table("./test/subject_test.txt", header=FALSE)

colnames(subject_test) = "subjectId";
colnames(x_test)       = features[,2]; 
colnames(y_test)       = "activityId";

# Combine 'x' data set
x_data <- rbind(x_train, x_test)

# Combine 'y' data set
y_data <- rbind(y_train, y_test)

# Combine 'subject' data set
subject_data <- rbind(subject_train, subject_test)

# Combine training and test data to create a final data set
final_data = cbind(y_data, subject_data, x_data);

# Create a vector for the column names from the final_data. We will use this
# to select the desired mean() & stddev() columns
all_col_names  = colnames(final_data); 


###############################################################################
# Step 2: Extract only the measurements on the mean and standard deviation for
# each measurement
###############################################################################


# Create a col_to_be_used that contains TRUE values for the ID, mean() & 
# stddev() columns and FALSE for others
col_to_be_used = (grepl("activity..", all_col_names) | 
                  grepl("subject..", all_col_names) | 
                  grepl("-mean..", all_col_names) & 
                  !grepl("-meanFreq..", all_col_names) & 
                  !grepl("mean..-", all_col_names) | 
                  grepl("-std..", all_col_names) & 
                  !grepl("-std()..-", all_col_names));

# Subset table based on the col_to_be_used to keep only desired columns
final_data = final_data[col_to_be_used==TRUE];

###############################################################################
# Step 3: Use descriptive activity names to name the activities in the data set
###############################################################################

# Merge the final_data set with the acitivities table to include descriptive 
# activity names
final_data = merge(final_data, activities, by='activityId', all.x=TRUE);

# Updating the all_col_names vector to include the new column names after merge
all_col_names  = colnames(final_data); 

###############################################################################
# Step 4: Appropriately label the data set with descriptive variable names
###############################################################################

# Cleaning up the variable names
for (i in 1:length(all_col_names)) 
{
  all_col_names[i] = gsub("\\()","",all_col_names[i])
  all_col_names[i] = gsub("-std$","StdDev",all_col_names[i])
  all_col_names[i] = gsub("-mean","Mean",all_col_names[i])
  all_col_names[i] = gsub("^(t)","time",all_col_names[i])
  all_col_names[i] = gsub("^(f)","freq",all_col_names[i])
  all_col_names[i] = gsub("([Gg]ravity)","Gravity",all_col_names[i])
  all_col_names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",all_col_names[i])
  all_col_names[i] = gsub("[Gg]yro","Gyro",all_col_names[i])
  all_col_names[i] = gsub("AccMag","AccMagnitude",all_col_names[i])
  all_col_names[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",all_col_names[i])
  all_col_names[i] = gsub("JerkMag","JerkMagnitude",all_col_names[i])
  all_col_names[i] = gsub("GyroMag","GyroMagnitude",all_col_names[i])
};

# Reassigning the new descriptive column names to the final_data set
colnames(final_data) = all_col_names;


###############################################################################
# Step 5: Create a second, independent tidy data set with the average of each
# variable for each activity and each subject
###############################################################################

# Create a new table without the activityType column
final_data_no_act_type  = final_data[ , names(final_data) != 'activityType'];

# Summarizing the table to include just the mean of each variable for each 
# activity and each subject
average_data = aggregate(final_data_no_act_type[ , 
                         names(final_data_no_act_type) != c('activityId','subjectId')], 
                         by=list(activityId = final_data_no_act_type$activityId, 
                         subjectId = final_data_no_act_type$subjectId), mean);

# Merging the average_data with activities to include descriptive acitvity names
average_data = merge(activities, average_data, by='activityId', all.x=TRUE);

# Export the average_data set 
write.table(average_data, './average_data.txt', row.names=FALSE, sep='\t');