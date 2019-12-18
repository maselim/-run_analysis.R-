library(tidyverse)


#Download the data
if (!(file.exists("data")))
  { dir.create("data")}
if (!(file.exists("data/Dataset.zip")))
{ download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile ="data/Dataset.zip", method="curl")}
if (!(file.exists("data/UCI HAR Dataset")))
  {unzip("data/Dataset.zip",exdir="data")}

# Unzipped files lye in the data/UCI\ HAR\ Dataset/ dir

## 1. Merges the training and the test sets to create one data set.

### Get the features and activity labels as character vectors
features <- read_delim('./data/UCI HAR Dataset/features.txt', " ", col_names = F) %>% pull(2)


### read the train data
x_train <- read_table("./data/UCI HAR Dataset/train/X_train.txt", col_names = features)
y_train <- read_table("data/UCI HAR Dataset/train/y_train.txt", col_names = "activity", col_types = cols(col_factor(levels=1:6)))
subject_train <- read_table("data/UCI HAR Dataset/train/subject_train.txt", col_names = "subject")

train <- bind_cols(subject_train,y_train, x_train) %>% mutate(set="train") %>% select(set, everything())
rm(list = c("y_train","x_train","subject_train"))

### read the test data
x_test <- read_table("./data/UCI HAR Dataset/test/X_test.txt", col_names = features)
y_test <- read_table("data/UCI HAR Dataset/test/y_test.txt", col_names = "activity", col_types = cols(col_factor(levels=1:6)))
subject_test <- read_table("data/UCI HAR Dataset/test/subject_test.txt", col_names = "subject")

test <- bind_cols(subject_test,y_test, x_test) %>% mutate(set="test") %>% select(set, everything())
rm(list = c("y_test","x_test","subject_test"))


### Make the tidy_data joint data set
tidy_data <- bind_rows(train,test)
rm(list = c("test","train"))

## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
tidy_data <- tidy_data %>% select(1:3, contains("mean()"), contains("std()"))


## 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read_delim('./data/UCI HAR Dataset/activity_labels.txt', " ", col_names = F) %>% pull(2)
levels(tidy_data$activity) <- activity_labels

## 4. Appropriately labels the data set with descriptive variable names.
### This was already done during the loading of the data for convenience


## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

avgd_data <- tidy_data %>% group_by(subject, activity) %>% summarise_at(-(1:3),mean,na.rm = T)

### Save this dataset to submit
write.table(avgd_data, file="tidy_dataset.txt", row.names = FALSE)

