---
title: "README.md"
output: word_document
---

##Overview of Script
**run_analysis.R** is a script produced for Coursera's Data Gathering and Cleaning class, August, 2014.  It's purpose is to demonstrate some techniques of data tidying, by downloading, merging and creating a "clean" data set of the mean and standard deviation of measurements of UC Irvine's Human Activity Recognition Using Smartphones Data Set.

Full information about the data set can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The script runs five functions based on the basic steps of the assignment:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

**How to Run the Script
After changing the working directory to be where run_analysis.R is located, run the tidy operations by either:
* Downloading the data file, called getdata-projectfiles-UCI HAR Dataset.zip, leaving it zipped, into the same directory as run_analysis.R is being run.
* Allowing the script to download and unzip a fresh copy of the data.

To run the actual script, source **run_analysis.R** and type *>run_analysis()* at the console prompt. An internet connection is required to download the data set.

##Operation of the Script
The functions of run_analysis() are:
- get_data: makes the working directory, *data*, and unzips the downloaded data set into it.
- merge_data: merges the training and test data into one data frame, preserving coorspondence between subject, activities and measurements.
- extract_data: pulls the measurements with "mean" & "std" in their descriptors into a new data frame and then properly labels each variable and observation.
export_data: Using **write.table**, output the tidy data set into a text file named *tidy_dataset.txt*.

The script performs the following:
* Training/Test measurements are read into different dataframes.  Subject and activity factors are combined using cbind.
* Both sets are merged using rbind.
* Features indices are read into a dataframe.
* Features are filtered using grep containing "mean" or "std".
* Data frame columns are filtered by indices returned in the above step.
* Activity factors are properly denoted by features indices.
* Activity and Subject columns are converted into factors.
* After sourcing "reshape2", measurement variables are aggregated using **melt** & **dcast** with variables averaged.
* Activity factor is renamed with descriptive activity names.
* Tidy set is written to a file.

##Notes
* The exported text file uses white space as a seperator.  To import the text file into R, use the following command:

*tidy_dataset <- read.table("./data/tidy_dataset.txt", header=TRUE, quote="\"", stringsAsFactors=FALSE)*

* run_analysis script was written for maximum readability and user evaluation.  As such it has not been optimized for performance or durability.