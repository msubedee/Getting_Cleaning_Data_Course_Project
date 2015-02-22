# <h1> Description
This code book describes the variables, data, and any transformations or work that is performed to clean up the data. 

The R script "run_analysis.R" basically consists of 6 sections. 
* Section 1: This section is for the initial preparation before any analysis is done. 
  * This section downloads and loads required R packages, downloads the data zip file from the web, and unzip the data zip file.
* Section 2: This section merges the training and the test sets to create one data set. 
  * This section reads the 'test' and 'train' data,  concatenates 'x', 'y' and 'subject' data tables to create new data set, and merges columns to have training and test data sets together as 'all_data'.
* Section 3: This section extracts only the measurements on the mean and standard deviation for each measurement. 
  * This section sets the name of last two variables in 'all_data', gets only columns with 'mean()' and 'std()' in their names, and defines columns for extracting the subset of 'all_data' based on the the selected columns.
* Section 4: This section uses descriptive activity names to name the activities in the data set.
  * This section reads the 'activity_labels' data and makes the activity a factor and naming its levels based on the labels in 'ActicityLabel'.
* Section 5: This section appropriately labels the data set with descriptive variable names.
  * This section checks the column names and getting all the column names in 'all_data' to 'colNames' vector, cleans up the variable names and reassigns the new column names to the 'all_data' data set.
* Section 6: This section creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  *  This section uses ddply function to split data frame 'all_data', apply function 'colMeans', and return results in data frame 'avearge_data', and finally exports the tidydata set.

### <h3> Variables
Among many files in the zip file downloaded for this project, only 8 text files are used. Any files in the Inertial Signals folders are not used. The files that are used to load data are:
* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt

The variables used in the script are:
* X_train, y_train, X_test, y_test, subject_train and subject_test represent the data from those downloaded files
* X_data, y_data and subject_data represent the merged data set from the above 6 datasets for further analysis
* Features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
