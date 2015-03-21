library(dplyr)

##Read activity labels using N/A as missing values
##Name the variables
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", na.strings = "N/A",
                              col.names=c("ActivityLabel","Activity"))

##Read features labels using N/A as missing values
##Name the variables
features <- read.table("UCI HAR Dataset/features.txt", na.strings="N/A", 
                       col.names=c("FeatureLabel","Feature"))
##Read train labes using N/A as missing values
##Name the variable
train_labels<-read.table("UCI HAR Dataset/train/y_train.txt", na.strings = "N/A", 
                         col.names="TrainLabel")

##Read train subject labels
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", na.strings="N/A", 
                             col.names = "SubjectLabel")

##Read train set using N/A as missing values
train_set <- read.table("UCI HAR Dataset/train/X_train.txt", na.strings="N/A") 
##Creates an index for the train labels so we can merge it without losing the order
train_labels$idOrder <- seq_len(nrow(train_labels))

##Merges the train labels with the activity labels
train_labels <- merge(activity_labels,train_labels, by.x="ActivityLabel", 
                      by.y="TrainLabel")

##Arranges by the idOrder variable
train_labels <- arrange(train_labels, idOrder)

##Adds the activity names and subjects to the train set
train_set$Activity <- as.factor(train_labels$Activity)
train_set$Subject <- as.factor(train_subjects$SubjectLabel)

##Now I have the full train set, with activity and subject

##Repeat the steps above for the test set
test_labels<-read.table("UCI HAR Dataset/test/y_test.txt", na.strings = "N/A", 
                         col.names="TestLabel")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", na.strings="N/A", 
                             col.names = "SubjectLabel")
test_set <- read.table("UCI HAR Dataset/test/X_test.txt", na.strings="N/A")
test_labels$idOrder <- seq_len(nrow(test_labels))
test_labels <- merge(test_labels, activity_labels, by.x="TestLabel", 
                      by.y="ActivityLabel")
test_labels <- arrange(test_labels, idOrder)
test_set$Activity <- as.factor(test_labels$Activity)
test_set$Subject <- as.factor(test_subjects$SubjectLabel)

##Merges the two data sets, we don't care about the order here since one data set
##will be added to the other.
data_set <- merge(test_set, train_set, all=TRUE)
##Names the variables using the feature list.
names(data_set)[1:561] <- as.character(features$Feature)

##Subsets the data_set to get only the measues of mean and standard deviation
##Also gets the columns Subject and Activity
data_set <- data_set[,grep("Subject|Activity|mean|std", names(data_set), ignore.case=TRUE)]

##Groups the data by Subject and Activity and summarises using the mean
##function in each column
final_data_set <- summarise_each(group_by(data_set, Subject, Activity),
                                 funs(mean))
##Changes Subject to numeric class so we can arrange by ascending order
final_data_set$Subject <- as.numeric(final_data_set$Subject)
final_data_set <- arrange(final_data_set, Subject)

##Writes the final data set to a file
write.table(final_data_set,"tidydata.txt", row.name=FALSE, quote = FALSE)

##To read the data in
data <- read.table("tidydata.txt", header=TRUE)
