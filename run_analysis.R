##run_analysis: Downloads and tidies data set on wearable computers.  Scipt is written for 
##Coursera Data Gathering and Cleaning Course.

## Create Working Directory, download and unzip data directories
get_data <- function () {
    if (!file.exists("./data")) {
        dir.create("./data")
    }
    dest_file_name <- "./data/Dataset.zip"
    if (!file.exists(dest_file_name)) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL,destfile = dest_file_name,method = "curl")
        print(date_downloaded <- date())
    }
    unzip(dest_file_name,overwrite = TRUE,exdir = "./data")    
}

## Merge Data
merge_data <- function() {
    X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
    Y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", quote="\"", stringsAsFactors=TRUE)
    subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors=TRUE)
    test_df <- cbind(subject_test,X_test)
    test_df <- cbind(Y_test,test_df)
    X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
    Y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt", quote="\"", stringsAsFactors=TRUE)
    subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors=TRUE)
    train_df <- cbind(subject_train,X_train)
    train_df <- cbind(Y_train,train_df)
    combined_df <- rbind(test_df,train_df)
    return(combined_df)
}

extract_data <- function(df) {
    features <- read.table("./data/UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)
    extract_idx <- grep("*mean*|*std",features[,2],ignore.case = TRUE)
    x_idx <- extract_idx + 2
    x_idx <- c(1:2,x_idx)
    xdf <- df[,x_idx]
    xdf[,1] <- as.factor(xdf[,1])
    xdf[,2] <- as.factor(xdf[,2])
    measurement_names <- features[extract_idx,]
    colnames(xdf) <- c("Activity","Subject",measurement_names$V2)
    require("reshape2")
    m_xdf <- melt(xdf)
    c_xdf <- dcast(m_xdf, Subject + Activity~...,mean)
    c_xdf[,2] <- as.numeric(c_xdf[,2])
    c_xdf$Activity[c_xdf$Activity==1] <- "WALKING"
    c_xdf$Activity[c_xdf$Activity==2] <- "WALKING_UPSTAIRS"
    c_xdf$Activity[c_xdf$Activity==3] <- "WALKING_DOWNSTAIRS"
    c_xdf$Activity[c_xdf$Activity==4] <- "SITTING"
    c_xdf$Activity[c_xdf$Activity==5] <- "STANDING"
    c_xdf$Activity[c_xdf$Activity==6] <- "LAYING"
    return(c_xdf)
}

export_data <- function(xdf) {
    
}

## Run the Data Gathering and Cleaning Functions

run_analysis <- function(get.data = TRUE) {
    if (get.data == TRUE) {
        get_data()
    }
    df <- merge_data()
    xdf <- extract_data(df)
    ## export_data(xdf)
}