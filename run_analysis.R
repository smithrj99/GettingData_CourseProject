library(plyr)

# Function to determine features with Mean() or Std()
endsWithMorS <- function(s){
  result <- FALSE
  func <- substr(s, nchar(s) - 8 + 1, nchar(s) - 2)
  if (func == "mean()" || func == "-std()")
  {
    result <- TRUE
  }
  
  result
}

# 0a. Read the features
features_raw <- read.table("./data/features.txt")
features <- t(features_raw[2])

# 0b. Read the test data

test_x <- read.table("./data/test/X_test.txt")
test_y <- read.table("./data/test/y_test.txt")
test_subject <- read.table("./data/test/subject_test.txt")

# 0c. Read the training data

train_x <- read.table("./data/train/X_train.txt")
train_y <- read.table("./data/train/y_train.txt")
train_subject <- read.table("./data/train/subject_train.txt")


# 1. Combine the Test & Training Data

combined_raw_x <- rbind(test_x, train_x)
combined_y <- rbind(test_y, train_y)
combined_subject <- rbind(test_subject, train_subject)

## 2. Extract only the measurements with mean and standard deviation

# 2a. Name the features
names(combined_raw_x) <- features
names(combined_y)[1] <- "ActivityId"

# 2b. Filter mean/stdev using above function
combined_x <- combined_raw_x[, sapply(names(combined_raw_x), endsWithMorS)]

# 2c. Combine the activities with measurements
combined <- cbind(combined_y, combined_x)

# 3. Add Descriptive Activity names

activityNames <- data.frame(ActivityId = seq(1, 6), Activity = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))
combined_naming <- join(activityNames, combined)
named <- combined_naming[, 2:50]

# 4. Add the Descriptive Variable names

names(named) <- c(
  "Activity Name",
    "Body Linear Acceleration Mean (X-Dimension)",
    "Body Linear Acceleration Mean (Y-Dimension)",
    "Body Linear Acceleration Mean (Z-Dimension)",
    "Body Linear Acceleration Standard Deviation (X-Dimension)",
    "Body Linear Acceleration Standard Deviation (Y-Dimension)",
    "Body Linear Acceleration Standard Deviation (Z-Dimension)",
    "Gravity Acceleration Mean (X-Dimension)",
    "Gravity Acceleration Mean (Y-Dimension)",
    "Gravity Acceleration Mean (Z-Dimension)",
    "Gravity Acceleration Standard Deviation (X-Dimension)",
    "Gravity Acceleration Standard Deviation (Y-Dimension)",
    "Gravity Acceleration Standard Deviation (Z-Dimension)",
    "Body Jerk Linear Acceleration Mean (X-Dimension)",
    "Body Jerk Linear Acceleration Mean (Y-Dimension)",
    "Body Jerk Linear Acceleration Mean (Z-Dimension)",
    "Body Jerk Linear Acceleration Standard Deviation (X-Dimension)",
    "Body Jerk Linear Acceleration Standard Deviation (Y-Dimension)",
    "Body Jerk Linear Acceleration Standard Deviation (Z-Dimension)",
    "Body Angular Velocity Mean (X-Dimension)",
    "Body Angular Velocity Mean (Y-Dimension)",
    "Body Angular Velocity Mean (Z-Dimension)",
    "Body Angular Velocity Standard Deviation (X-Dimension)",
    "Body Angular Velocity Standard Deviation (Y-Dimension)",
    "Body Angular Velocity Standard Deviation (Z-Dimension)",
    "Body Jerk Angular Velocity Mean (X-Dimension)",
    "Body Jerk Angular Velocity Mean (Y-Dimension)",
    "Body Jerk Angular Velocity Mean (Z-Dimension)",
    "Body Jerk Angular Velocity Standard Deviation (X-Dimension)",
    "Body Jerk Angular Velocity Standard Deviation (Y-Dimension)",
    "Body Jerk Angular Velocity Standard Deviation (Z-Dimension)",
    "Body Linear Acceleration Frequency Mean (X-Dimension)",
    "Body Linear Acceleration Frequency Mean (Y-Dimension)",
    "Body Linear Acceleration Frequency Mean (Z-Dimension)",
    "Body Linear Acceleration Frequency Standard Deviation (X-Dimension)",
    "Body Linear Acceleration Frequency Standard Deviation (Y-Dimension)",
    "Body Linear Acceleration Frequency Standard Deviation (Z-Dimension)",
    "Body Jerk Linear Acceleration Frequency Mean (X-Dimension)",
    "Body Jerk Linear Acceleration Frequency Mean (Y-Dimension)",
    "Body Jerk Linear Acceleration Frequency Mean (Z-Dimension)",
    "Body Jerk Linear Acceleration Frequency Standard Deviation (X-Dimension)",
    "Body Jerk Linear Acceleration Frequency Standard Deviation (Y-Dimension)",
    "Body Jerk Linear Acceleration Frequency Standard Deviation (Z-Dimension)",
    "Body Angular Velocity Frequency Mean (X-Dimension)",
    "Body Angular Velocity Frequency Mean (Y-Dimension)",
    "Body Angular Velocity Frequency Mean (Z-Dimension)",
    "Body Angular Velocity Frequency Standard Deviation (X-Dimension)",
    "Body Angular Velocity Frequency Standard Deviation (Y-Dimension)",
    "Body Angular Velocity Frequency Standard Deviation (Z-Dimension)")

# 5. Create tidy data set with the average of each variable for each activity and each subject.

# 5a. Add the subjectid
subjects = cbind(combined_subject, named)

# 5b. Get the means by Subject, Activity for each variable
subject_means <- ddply(subjects, .(SubjectId, `Activity Name`), numcolwise(mean))

# 5c. Save the means to file for upload to Coursera

write.table(subject_means, "./data/tidy_means_subject_activity.txt", row.name=FALSE )



