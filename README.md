# Getting and Cleaning Data Course Project

This repository have the requested files for the final project in the Coursera's course Cleaning Data Course Project

## Content
- The **run_analysis.R** script that performs all the analysis
- This **README.md** with all the instructions to run and explanations
- The **CodeBook.md** with description of all the variables in the final tidy data set


## How to run the analysis

All the needed is in the **run_analysis.R** script, but you need to have the tidyverse colelction already installed in R (as the script is based in packages in the tidyverse like dplyr, readr or tibble). If you need to install the tidyverse just run `install.packages("tidyverse")` in your R session.
Then you can run the analysis requested in this project by just cloning this repo and run in R: `source("run_analysis.R")` from the project home directory.

## How it works

These are the steps followed in the **run_analysis.r** script

1. Load the dependence (tidyverse)
```r
library(tidyverse)
```

2. Download and unzip the data. It checks if the data directory exists, if not it creates it. Then checks if the file is already downloaded, if not it downloads it. Finally check if it was already unzipped. At the end we will have a directory called "data/UCI HAR Dataset" where the needed files will be.
```r
if (!(file.exists("data")))
  { dir.create("data")}
if (!(file.exists("data/Dataset.zip")))
{ download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile ="data/Dataset.zip", method="curl")}
if (!(file.exists("data/UCI HAR Dataset")))
  {unzip("data/Dataset.zip",exdir="data")}
```

3. Read the features.txt file, that contains the names of the variables and store them in a character vector for assign column names later.
```r
features <- read_delim('./data/UCI HAR Dataset/features.txt', " ", col_names = F) %>% pull(2)
```

4. Read the data files for the train set. These are under the train directory and they are X_train.txt (the values for the features measured), y_train.txt (the encoded type of activity) and subject_train.txt (the codes for the individuals). As we are using readr::read_table we can also assign the right variables names stored in the features vector (step 3). We also convert the activity column into a factor while loading the data.
Finally we bind the columns of the three files into a single train data frame with a column indicating that thse case come from the train set, and then remove all the intermediate data.
```r
x_train <- read_table("./data/UCI HAR Dataset/train/X_train.txt", col_names = features)
y_train <- read_table("data/UCI HAR Dataset/train/y_train.txt", col_names = "activity", col_types = cols(col_factor(levels=1:6)))
subject_train <- read_table("data/UCI HAR Dataset/train/subject_train.txt", col_names = "subject")
train <- bind_cols(subject_train,y_train, x_train) %>% mutate(set="train") %>% select(set, everything())
rm(list = c("y_train","x_train","subject_train"))
```

5. Read the data files for the test set. These are under the train directory and they are X_test.txt (the values for the features measured), y_test.txt (the encoded type of activity) and subject_test.txt (the codes for the individuals). As we are using readr::read_table we can also assign the right variables names stored in the features vector (step 3). We also convert the activity column into a factor while loading the data.
Finally we bind the columns of the three files into a single train data frame with a column indicating that thse case come from the test set, and then remove all the intermediate data.
```r
x_test <- read_table("./data/UCI HAR Dataset/test/X_test.txt", col_names = features)
y_test <- read_table("data/UCI HAR Dataset/test/y_test.txt", col_names = "activity", col_types = cols(col_factor(levels=1:6)))
subject_test <- read_table("data/UCI HAR Dataset/test/subject_test.txt", col_names = "subject")
test <- bind_cols(subject_test,y_test, x_test) %>% mutate(set="test") %>% select(set, everything())
rm(list = c("y_test","x_test","subject_test"))
```

6. Now we have the two data frames (tibbles), one for the test and one for the train. Let's bind it by rows into the tidy_data tibble and delete the intermediate.
```r
tidy_data <- bind_rows(train,test)
rm(list = c("test","train"))
```

7. In the compact data set, let's keep only the features that refer to the mean and standar deviation, those that contain "mean()" and "std()".
```r
tidy_data <- tidy_data %>% select(1:3, contains("mean()"), contains("std()"))
```

8. Now, the activiy column is a factor with the encoded levels as 1 to 6. Let's read the activity labels from the activity_labels.txt file and assing them to the activity factor levels
```r
activity_labels <- read_delim('./data/UCI HAR Dataset/activity_labels.txt', " ", col_names = F) %>% pull(2)
levels(tidy_data$activity) <- activity_labels
```

9. creates a second, independent tidy data set with the average of each variable for each activity and each subject. For that we group the tidy_data by subject and activity and then summarise all the feature variables by its mean. We use dplyr functions group_by and summarise_at for this
```r
avgd_data <- tidy_data %>% group_by(subject, activity) %>% summarise_at(-(1:3),mean,na.rm = T)
```

10. The last step is to write the final tidy dataset into a txt file
```r
write.table(avgd_data, file="tidy_dataset.txt", row.names = FALSE)
```

## Description of the variables.
The variables in the final tidy_dataset.txt are described in the **CodeBook.md** file of this repository
