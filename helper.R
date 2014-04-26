
## Helper function that deals with a given dataset
## In the current context, the possible type of dataset are "test" and "train"
##
##
extractdata <- function(datatype="test"){
        ## construct the file name
        datafilename <- paste("./UCI HAR Dataset/", datatype, "/X_", datatype, ".txt", sep="")
        
        ## read the data for only the required colums. Specifying empty for comment.char to speed up the operation
        data <- read.table(datafilename, colClasses=reqcols, comment.char="")
        
        ## Replace the coded column names with the descriptive names from the feature list (allfeatures$V2)
        names(data) <- allfeatures$V2[matchfeatures]
        
        ## read the activity labels that correspond to this data set
        labelsfilename <- paste("./UCI HAR Dataset/", datatype, "/y_", datatype, ".txt", sep="")
        labels <- read.table(labelsfilename)
        
        ## read the subjects that correspond to this data set
        subjectsfilename <- paste("./UCI HAR Dataset/", datatype, "/subject_", datatype, ".txt", sep="")
        subjects <- read.table(subjectsfilename)
        
        ## add both the activity and subject columns to the data set
        data$Activity <- activities[labels$V1]
        data$Subject <- subjects$V1
        
        ## return the extracted tidy data set
        data
}
