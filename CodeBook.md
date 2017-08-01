# Code Book
This book describes the functionality of run_analysis along with the necessary inputs and expected outputs.

## Functions

### run_analysis
* This script will use the other functions mentioned below to load and combine data. 
* Then the script will manipulate the loaded data by merging the training and test sets. 
* Extract only the mean and standard deviation measurements for each feature.
* Creates a new table where the measurements are averaged for each subject and activity.
* Saves that table as an output called averageForEachSubject.txt

### load_data
This function loads the test and training data, with column labels from features, then adds the subject and activity columns.

### combine_data
Combines the test and training data into one data frame.

### getPath
Simplifies creation of the paths to the separate data.

## Input
The input to the function is the UCI Human Activity Recognition Using Smartphones Data Set from https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
It should be placed in the data directory.

## Output
The output is a merged table called averageForEachSubject.txt
