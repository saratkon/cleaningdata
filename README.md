Getting and Cleaning Data - Coursera - Peer assignment
============

Description
-----------
This repository contains the files that are associated with my work assignment for the course.

### The following is a list of file present:
Name of the file    | Description of the contents
--------------------|--------------------------------
README.md           |   This document
UCI HAR DataSet     |   The original raw data set
run_analysis.r      |   The main R-Script file that documents the work flow of the assignment
helper.r            |   A helper script that contains utility functions that will be used in the main script
merged_tidy.txt     |   The tidy data set containing the observations of means and stds of various readings in the original data set.
average_tidy.text   |   The tidy data set containing the averages of the observations in merged_tidy for each activity and subject combination
CodeBook.md         |   The code book describing the variables in the tidy data sets above

#### UCI HAR DataSet
The original data set (a zip file) is downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The contents of the zip were extracted and placed directly under this folder. This data is split into two parts, train and test and files corresponding to these types are available under train and test sub directories respectively.

#### run_analysis.r
This is the main script that contains the code to tidy up the raw data and extract the required data. When this script is run, two .txt files are created, namely merged_tidy.txt and average_tidy.xtx. The contents of these individual files are detailed below. A more detailed description of the features of these files are present in the CodeBook.md

#### helper.r
A helper script that has a utility function extractdata, which can be called on individual datatypes (test or train). This separation is done so as to reuse the code. Note that the steps required to tidy the training data set are exactly the same as tidying up the test data set.

#### merged_tify.txt
The required features were extrated using the grep command and supplying the following pattern ofr matching: "mean() | std()". This would match all the features that contained the words 'mean()' or 'std()'.

#### average_tidy.txt
This pertains to the output for the second part of the assignment, where the mean of every extracted feature (means and stds) for each activity + subject combination is calculated and is written to a text file.

#### CodeBook.md
This code book describes the list of features containing in each of the above tidy data sets created.

### Steps taken in the run_analysis.r to clean the raw data

#### Part-1
* The features available in the data set are read into allfeatures using read.table("./UCI HAR Dataset/features.txt")
* All the activity labels are read into activities data frame using read.table("./UCI HAR Dataset/activity_labels.txt")
* The activities data frame is converted into a character vector to easy the indexing process
* A match pattern is constructed to locate the required features (means and stds)
* Using the grep function and the above match pattern, the required features list is built into matchfeatures
* Next a colClasses variable (reqcols) is constructured which will aid in reading only the required columns from the data set. This is a huge advantage as less memory will be consumed using this process.
* We have all the top level building blocks to now work on the sub test and train data sets. We make use of the extractdata function iin helper.r
* Extract the tidy data from the train data by passing "train" as argument to the extractdata function.
* The test tidy data can be extract similarly by passing "test" as argument to the extractdata function.
* The merged data can be forming by combining test and train data sets using the rbind function
* Output the contents of this merged data frame to merged_tidy.txt

#### Part-2
* Using the melt function in reshape2 package we combine the merged data to collapse the feature columns into variable and value
* Next dcast function is used to cast this meled data back into a data frame by passing the formula=Activity + Subject ~ variable. Also, since it was asked to calculate the means of the feature observations, we further collapse the identical rows using mean as argument to dcast function.
* Output the contents of this new casted data frame into average_tidy.txt
