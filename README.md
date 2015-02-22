# Getting and Cleaning Data Course Project

This repository contains the R script and other documentation files for the course "Getting and Cleaning Data", available in coursera. The objective of this project is to demonstrate an ability to collect, work with, and clean a data set. The ultimate goal of this project is to create a tidy data set that can be used for further analysis. 

This R script in this repository "run_analysis.R" downloads a data set that is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This data set is further cleaned and converted to a tidy data set that is written as txt file in the working directory. The final tidy data set is named "tidydata.txt".

## How the script works?

In order to make the script work, the user has to make one modification to the R script (run_analysis.R). The user has to set the path of the working directory on line 21 of the script. Once the script is run, the tidy data is going to be available in the working directory. 

The user can find additional information about the variables, data and transformations in the CodeBook.MD file.
