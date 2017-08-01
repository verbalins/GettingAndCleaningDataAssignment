## This function will take two folders, combine the data from them and tidy it. 
## It will also save a data set to the working folder.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.        

library(dplyr)

# Load activities.
activity_labels <- read.table("data/activity_labels.txt")[,2]

# Load the features to set to the data.
features <- as.character(read.table("data/features.txt")[,2])

# Get combined data.
combined <- combine_data(load_data("train", features), load_data("test", features))

# Replace activities with the names from activity_lables
combined$activity <- as.factor(combined$activity)
levels(combined$activity) <- activity_labels

# Group by activity and subject and calculate mean.
meanOfSubjectAndActivity <- combined %>% group_by(subject, activity) %>% summarise_all(funs(mean))

# Write results file.
write.table(meanOfSubjectAndActivity, file = "averageForEachSubject.txt", row.name = FALSE)
meanOfSubjectAndActivity

## Loads data and assigns feature labels to the columns, only selects columns that have mean() and std() in them.
## Ignores columns which matches angle or Freq.
load_data <- function(experiment, features){
        x <- read_table2(getPath(experiment, "X"), col_names = as.vector(features)) %>%
                select(matches("mean()|std()"), -matches("angle|Freq")) 
        activity <- read_table2(getPath(experiment, "Y"), col_names = c("activity"))
        subjects <- read_table2(getPath(experiment, "subject"), col_names = c("subject"))
        bind_cols(activity, subjects, x)
}

## Combines train and test data.
combine_data <- function(train, test){
        bind_rows(train, test)
}

getPath <- function(experiment, variable){
        paste("data/", experiment, "/", variable, "_", experiment, ".txt", sep = "")
}