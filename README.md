Course-Project-Getting-and-Cleaning-Data
========================================

Description of how my run_analysis.R works
-------------------------------------------

This description presumes that the working directory is set to the UCI_HAR_Dataset

### Features and activity labels
First the features.txt and activity_labels.txt are loaded.

### Test set
Then the test data set is loaded together Y_test and subject_test.

### Train set
The same procedure as described above, but for the training set.

### Combining
Then the train and test data set are combined into "data".

### Names
Then feature names are added together with "activities" and "subject.

### Extracting
Then the coloumns of interest is extracted into "data_for_use".

### subject_list
Then subject_list is created which is a list, holding all of the individual data for each subject.
Observation names are added here as well, though the instructions for the tidy_data_set were that row.names should be set to false. Still, with my data a tidy data set can be created with the row (observations) names.

### acitivity_list
Then, as before, activity_list is created and holds all of the indivifual data for each activity.

### Combinement
The activity and subject data is combined to the tidy_data_set, with the variables (the averages of means and standard deviations) in coloum names and the observations in row names. The first 6  rows are for walking, walking_upstairs, walking_downstairs, sitting, standing, laying, and after this the subjects 1-30.
