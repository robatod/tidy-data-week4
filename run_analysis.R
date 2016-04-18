
#####################################################################################
# Assignmet for Week 4, Clean and Tidy Data
# Data: April 18, 2016
#####################################################################################

library(dplyr)

# set up working directiories
setwd("~/Documents/classes/Data Science/Getting and Cleaning Data/UCI HAR Dataset/")

# 4. Appropriately labels the data set with descriptive variable names.
# load the feature names to be used during the data loads - makes it easier
x_feature_file <- "features.txt";
x_feature_df <- read.delim(x_feature_file,sep="",header = FALSE, stringsAsFactors = FALSE,col.names = c("num","feature") )


# load train data files with column names from the features file
x_train_file <- "train/X_train.txt";
x_train_df <- read.delim(x_train_file,sep="",header = FALSE, stringsAsFactors = FALSE, col.names = x_feature_df$feature)
y_train <- "train/y_train.txt";
y_train_df <- read.delim(y_train, header = FALSE, stringsAsFactors = FALSE, col.names=c("activity"));

# append activity column to train data
x_y_train_df <- cbind(y_train_df, x_train_df);

# load test data files
x_test_file <- "test/X_test.txt"
x_test_df <- read.delim(x_test_file, sep="", header = FALSE, stringsAsFactors = FALSE, col.names = x_feature_df$feature)
y_test <- "test/y_test.txt"
y_test_df <- read.delim(y_test, header = FALSE, stringsAsFactors = FALSE, col.names=c("activity"))

# append activity column to test data
x_y_test_df <- cbind(y_test_df, x_test_df);

# 1. Merges the training and the test sets to create one data set.
x_y_df <- rbind(x_y_test_df, x_y_train_df)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
cols_mean_std <- grep("[Mm]ean|[Ss]td",names(x_y_df), value = TRUE)
# don't drop the activity column
x_y_df <- x_y_df[,c("activity",cols_mean_std)]

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels_file <- "activity_labels.txt"
activity_labels_df <- read.delim(activity_labels_file, sep="", header = FALSE, stringsAsFactors = FALSE, col.names = c("num","description"))
x_y_df <- mutate(x_y_df, activity= activity_labels_df[x_y_df$activity,2])

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
x_y_by_activity_df <- group_by(x_y_df, activity)
x_y_activity_summary <- summarise_each(x_y_by_activity_df,funs(mean))

# write data to files
write.table(x_y_activity_summary, file="../week4.txt", row.names = FALSE)


