################################################## INITIAL PREPARATION ##################################################################

# taking care of the required packages
if (!require("downloader")) {
    install.packages("downloader")
}

if (!require("data.table")) {
    install.packages("data.table")
}

if (!require("plyr")) {
    install.packages("plyr")
}

require("downloader")
require("data.table")
require("plyr")

# downloading the file and saving it in the project_data folder
setwd("C:\DataSpecialization_Coursera\GettingCleaningData\CourseProject")
if (!file.exists("project_data")) {
    dir.create("project_data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileURL, destfile = "./GettinCleanin_Data/idaho_data.csv", mode = "w", method = "curl")
download.file(fileURL, "./project_data/data.zip", mode = "wb")

# unzipping the file and deleting the zip file
unzip(zipfile="./project_data/data.zip",exdir="./project_data/data")

# listing the files
fileList <- list.files("./project_data/data", recursive = TRUE); fileList

# defining the file path as the necessary files/folders are in UCI HAR Dataset folder
newPath <- file.path("./project_data/data", "UCI HAR Dataset")


############################# Merges the training and the test sets to create one data set ###############################################

# reading the 'test' data
X_test <- read.table(file.path(newPath, "test", "X_test.txt"), sep="", header = FALSE)
y_test <- read.table(file.path(newPath, "test", "y_test.txt"), sep="", header = FALSE)
subject_test <- read.table(file.path(newPath, "test", "subject_test.txt"), sep="", header = FALSE)

# reading the 'train' data
X_train <- read.table(file.path(newPath, "train", "X_train.txt"), sep="", header = FALSE)
y_train <- read.table(file.path(newPath, "train", "y_train.txt"), sep="", header = FALSE)
subject_train <- read.table(file.path(newPath, "train", "subject_train.txt"), sep="", header = FALSE)

# concatenating 'x', 'y' and 'subject' data tables to create new data set
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# reading the 'features' data
Features <- read.table(file.path(newPath, "features.txt"), sep="", head = FALSE)

# setting names to 'X_data' variables from 'Features'
names(X_data)<- Features$V2

# merging columns to have training and test data sets together as 'all_data'
merged_data <- cbind(subject_data, y_data)
all_data <- cbind(X_data, merged_data)

############### Extracts only the measurements on the mean and standard deviation for each measurement ###################################

# setting the name of last two variables in 'all_data' 
names(all_data)[names(all_data) %in% c("V1","V2")] <- c("Subject","Activity")

# getting only columns with 'mean()' and 'std()' in their names
Features_subset <- Features$V2[grep("(mean|std)\\(\\)", Features$V2)]

# defining columns for extracting the subset of 'all_data' based on the the selected columns
column_Names <- c(as.character(Features_subset), "Subject", "Activity" )
all_data <- subset(all_data, select = column_Names)

############### Uses descriptive activity names to name the activities in the data set ###################################################

# reading the 'activity_labels' data
ActivityLabel <- read.table(file.path(newPath, "activity_labels.txt"), sep="", head = FALSE)

# making the activity a factor and naming its levels based on the labels in 'ActicityLabel'
all_data$Activity <- factor(all_data$Activity, labels = ActivityLabel[,2])

################# Appropriately labels the data set with descriptive variable names ######################################################

# checking the column names and getting all the column names in 'all_data' to 'colNames' vector
colnames(all_data)
colNames  = colnames(all_data)

# Cleaning up the variable names
    # replacing std by StdDev and mean by Mean
    # replacing prefix t and f by time and freq
    # replacing Mag by Magnitude and BodyBody by Body
for (i in 1:length(colNames)) 
{  
  colNames[i] = gsub("std()", "StdDev", colNames[i])
  colNames[i] = gsub("mean()", "Mean", colNames[i])
  colNames[i] = gsub("^t", "time", colNames[i])
  colNames[i] = gsub("^f", "freq", colNames[i])
  colNames[i] = gsub("Mag", "Magnitude", colNames[i])
  colNames[i] = gsub("BodyBody", "Body", colNames[i])
}

# reassigning the new column names to the 'all_data' data set
colnames(all_data) = colNames

############# creates a second, independent tidy data set with the average of each variable for each activity and each subject ###########

# since 'Subject' and 'Activity' are last two columns, finding the number of columns in 'all_data' 
ncol(all_data)

# using ddply function to split data frame 'all_data', apply function 'colMeans', and return results in data frame 'avearge_data'
# applying function to calculate average for the firs 66 columns (out of 68) except last two ('Subject' and 'Activity')

averages_data <- ddply(all_data, .(Subject, Activity), function(x) colMeans(x[, 1:66]))

# exporting the tidydata set
write.table(averages_data, "tidydata.txt", row.name = FALSE)

