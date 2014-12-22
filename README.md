### Assignment

Below are the tasks to be completed for this assignment:

You should create one R script called run_analysis.R that does the following. 
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Logic

#### Step 0: Read in the data

##### 0a) Read in the feature names
The names are in column #2. Store these to features objects.

##### 0b) Read in the test data as follows:
1.  Load X_test.txt into test_x object
2.  Load y_test.txt into test_y object
3.  Load subject_test.txt into test_subject variable

##### 0c. Read the training data as follows:
1.  Load X_train.txt into train_x object
2.  Load y_train.txt into train_y object
3.  Load subject_train.txt into train_subject variable

#### 1. Combine the Test & Training Data
Note: keep the columns separated until large number of variables are filtered in step 2 below

1.  Combine test and training X data to combined_raw_y object
2.  Combine test and training Y data to combined_y object
3.  Combine test and training Subject data to combined_subject object

#### 2. Extract only the measurements with mean and standard deviation
##### 2a. Name the features
For combined_raw_x object, get the names from the features object loaded in step 0a above
For y object, this is the ActivityId

##### 2b. Filter mean/stdev using above function
The function pulls out the last 8 characters, and strips off the last two, which are X or Y direction.
For the 6 characters of interest, do they match "mean" or "std" pattern? 
Store the list of filtered columns to combined_x object

##### 2c. Combine the activities with measurements, store to combined object

#### 3. Add Descriptive Activity names.

The list is simple, and stored to activityNames object, which is then joined to the combined object.
The named list is stored to the named object.

#### 4. Add the Descriptive Variable names
The list is relatively straightforward, and assigned directly to the named object created in step 3 above

#### 5. Create tidy data set with the average of each variable for each activity and each subject.

1.  Add the SubjectId column from combined_subject object created from combining data in step 2.
2.  Get the means of each variable by Subject, Activity by calling ddply function
3.  Save the tidy data set
