# HWwk3 #
Coursera Data Analysis Week 3

## How the script works ##
Script name: run_analysis()

Libraries used: library(dplyr);  library(plyr); library(data.table)

### Assumptions: ###
The initial working directory is set to ~/Desktop (Mac Users).
A workpath ~/Desktop/Coursera/HWwk3 was created for increased code readibility.
The script verifies a folder Coursera and a subfolder HWwk3 exists under the working directory Desktop.
If the folder and subfolder dont exist they are created.
A zip file Assignment.zip is created under the workplath ~/Desktop/Coursera/HWwk3
It contains the content downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The workpath is then set as the working directory.
All files are extracted from the Assignment.zip file.
All files extracted are loaded into individual data frames.

### Algorithm: ###


Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##### Question 1 : Merges the training and the test sets to create one data set.#####
Create a variable Testcomplete binding test label column and test set data.
Create a variable Traincomplete binding train label column and train set data.
Create a variable completeset binding the rows of the Traincomplete and Testcomplete variables.

##### Question 2 : Extracts only the measurements on the mean and standard deviation for each measurement. #####
Find the names of the columns containing "mean" and "std" in completeset.
Store the list of column names in extractioncol.
Subset the completeset with the columns containing "mean" or "std".

##### Question 3 : Uses descriptive activity names to name the activities in the data set #####
Convert data in second column of the data frame activities to the character format.
Rename the columns of the data frame activities.
Lookup activity_label in the table activities and create a column with explicit.
activities in completeset by joining the two label through the common column activities.

##### Preparing for Question 5 #####
Create a data frame Subjects in binding the rows of the two data frames where 
test sujects and train subjects are stored.
Subset completeset to the columns containing "mean", recordtype (train or test), 
activities codes and activity-label.
Binding the Subject data frame and Question5 data frames and changing the name
of the 50th column to make it more explicit.
Group the tidy data frame built for Question5 by subjects and activity_label
while summarizing the data by means.

##### Question 4 : Appropriately labels the data set with descriptive variable names. #####
Make column names more explicit by getting rid of the "()" and the "." while putting all names in lower case format.

##### Question 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. #####
Exporting the resulting file Question5.txt into the working directory.
