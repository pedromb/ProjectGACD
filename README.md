#Creating a tidy dataset from the Human Activity Recognition Using Smartphones Dataset

This document explains how to run the script [run_analysis.R](https://github.com/pedromb/ProjectGACD/blob/master/run_analysis.R) that follows.


A full description of the dataset used can be found here 
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 


The actual dataset can be found here
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


##Instructions

In order do read the data, the working directory should have the folder of the data set.
That means you need the following folder tree: working_directory/UCI HAR Dataset/


The script makes use of the [dplyr package](http://cran.rstudio.com/web/packages/dplyr/).
Make sure you have installed. You do not need to load the library before, as the script will do that.


For explanation regarding the variables refer to the [codebook](https://github.com/pedromb/ProjectGACD/blob/master/Codebook.md) 

##Analysis

We have two datasets (train and test) that we want merged and summarized by the mean of each measure grouped by Subject and Activity.


First we read the activity`_`labels.txt and features.txt files that will be used by both datasets. The first has a label number and the name of the corresponding activity. The second has the name of the 561 variables that were estimated.


After that we perform a series of actions, that are the same for both datasets, that includes:


1. Reading the subject labels for the corresponding dataset.
2. Reading the actual data set.
3. Creating an id to keep the order of the subject labels.
4. Merging the subject labels and the activity labels.
5. Ordering the merged list in 4 by the id created in 3.
6. Adding the subject and activity to the dataset.

After performing this actions for both data sets, at the end we will have the data set with all the measures plus the subject and activity for each measure.

With both datasets ready we merge them. With the new merged dataset we perform the following actions:

1. Naming the variables according to the features file.
2. Subsets the dataset by features that have mean or std in their name.
3. Groups the dataset by subject and activity and summarizes each measure by mean.
4. Writes a new file called tidydata.txt with the new dataset.

For actual implementation refer to the [script](https://github.com/pedromb/ProjectGACD/blob/master/run_analysis.R).