# <h1> Description
This code book describes the variables, data, and any transformations or work that is performed to clean up the data. 

The R script "run_analysis.R" basically consists of 6 sections. 
* Section 1: This section is for the initial preparation before any analysis is done. 
  * This section downloads and loads required R packages, downloads the data zip file from the web, and unzip the data zip file.
* Section 2: This section merges the training and the test sets to create one data set. 
  * This section reads the 'test' and 'train' data,  concatenates 'x', 'y' and 'subject' data tables to create new data set, and merges columns to have training and test data sets together as 'all_data'.
* Section 3: This section extracts only the measurements on the mean and standard deviation for each measurement. 
  * This section sets the name of last two variables in 'all_data', gets only columns with 'mean()' and 'std()' in their names, and defines columns for extracting the subset of 'all_data' based on the the selected columns.

## <h2> tag


### <h3> Variables

x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
