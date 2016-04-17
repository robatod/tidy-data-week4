
# set up working directios
setwd("~/Documents/classes/Data Science/Getting and Cleaning Data/UCI HAR Dataset/")

# train data files
x_train_file <- "train/X_train.txt";
x_train_df <- read.delim(x_train_file)

x_train_label <- "train/y_train.txt";
x_train_label_df <- read.delim(x_train_label);
x_y_train_df <- cbind(x_train_df, x_train_label_df);

# test data files
x_test_file <- "test/X_test.txt"
x_test_df <- read.delim(x_test_file)

x_test_label <- "test/y_test.txt"
x_test_label_df <- read.delim(x_test_label)
x_y_test_df <- cbind(x_train_df, x_train_label_df);

# activity labels
activity_labels_file <- "activity_labels.txt"
activity_labels_df <- read.delim(activity_labels_file)


#x_df <- rbind(x_test_df, x_train_df)



