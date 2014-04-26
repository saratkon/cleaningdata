## read all the features 
allfeatures <- read.table("./UCI HAR Dataset/features.txt")

## read all the activity labels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

## convert the data frame into a charater vector
activities <- activities$V2

message(paste("There are a total of ", as.character(nrow(allfeatures)), " features."))
        
## construct a list of features we are interested in
matchpattern <- c("mean\\(\\)", "std\\(\\)")
matchfeatures <- grep(paste(matchpattern, collapse="|"), allfeatures$V2)

message(paste("We are only interested in ", as.character(length(matchfeatures)), " features."))

## build a colClasses vector
reqcols <- c(rep("NULL", nrow(allfeatures)))
reqcols[matchfeatures] <- "numeric" 

## load the helper function
source("helper.R")

## using the helper routine, extract the tidy data set for the test and train data sets
message("Processing the test data set...")
testdata <- extractdata("test")
message(paste("\t the test data has ", nrow(testdata), " observations."))

message("Processing the train data set...")
traindata <- extractdata("train")
message(paste("\t the train data has ", nrow(traindata), " observations."))

message("Merging the test and train data sets")
## merge them into a single data set
merged <- rbind(traindata, testdata)

message("Dumping the merged content into merged_tidy.txt")
## output the merged data frame into a txt file
write.table(merged, file="merged_tidy.txt")

message("Caculating the means of each observation for each activity+subject combination")
require(reshape2)
## melt the data
molten <- melt(merged, id=c("Activity", "Subject"), na.rm=TRUE)

## take means of all observations for each activity and subject
average_tidy <- dcast(molten, formula = Activity + Subject ~ variable, mean)
message(paste("\t the average data set has ", nrow(average_tidy), " observations."))

message("Dumping the casted content into average_tidy.txt")
write.table(average_tidy, file="average_tidy.txt")