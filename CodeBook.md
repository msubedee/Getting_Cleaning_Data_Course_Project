# <h1> Description
This code book describes the variables, data, and any transformations or work that is performed to clean up the data. 

The R script "run_analysis.R" basically consists of 6 sections. 
* Section 1: This section is for the initial preparation before any analysis is done. This section downloads and loads required R packages, downloads the data zip file from the web, and unzip the data zip file.
* Section 2:

## <h2> tag


### <h3> Variables

x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
