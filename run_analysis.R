# Directions provided: 
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis<-function(){

# libraries used  
library(dplyr);  library(plyr); library(data.table)

# Set working directory   
setwd("~/Desktop")  
workpath<-"~/Desktop/Coursera/HWwk3"

# Download the file into a folder HWwk3. Check if folder data exists if not creates it.
# Extract zipped content to file Assignmen.zip in working directory.
# Extract file content of the zipped file into the working directory.
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(workpath)){dir.create(workpath)}
download.file(fileUrl,destfile="~/Desktop/Coursera/HWwk3/Assignment.zip",method="curl")
setwd(workpath) 
for (i in "Assignment.zip"){
  unzip(i, exdir=workpath, overwrite=TRUE)
}

# Extract all file content into variables
activities<- read.table("./UCI HAR Dataset/activity_labels.txt", sep="",header=FALSE)
features<- read.table("./UCI HAR Dataset/features.txt", sep="", header=FALSE)
testsubject<- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
testX<-read.table("./UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testy<-read.table("./UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
testbody_acc_x<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", sep="", header=FALSE)
testbody_acc_y<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", sep="", header=FALSE)
testbody_acc_z<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", sep="", header=FALSE)
testbody_gyro_x<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", sep="", header=FALSE)
testbody_gyro_y<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", sep="", header=FALSE)
testbody_gyro_z<-read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", sep="", header=FALSE)
testtotal_acc_x<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", sep="", header=FALSE)
testtotal_acc_y<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", sep="", header=FALSE)
testtotal_acc_z<-read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", sep="", header=FALSE)
trainsubject<- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
trainX<-read.table("./UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
trainy<-read.table("./UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
trainbody_acc_x<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", sep="", header=FALSE)
trainbody_acc_y<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", sep="", header=FALSE)
trainbody_acc_z<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", sep="", header=FALSE)
trainbody_gyro_x<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", sep="", header=FALSE)
trainbody_gyro_y<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", sep="", header=FALSE)
trainbody_gyro_z<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", sep="", header=FALSE)
traintotal_acc_x<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", sep="", header=FALSE)
traintotal_acc_y<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", sep="", header=FALSE)
traintotal_acc_z<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", sep="", header=FALSE)


# Create a variable Testcomplete binding test label column and test set data
# Create a variable Traincomplete binding train label column and train set data
# Create a variable completeset binding the rows of the Traincomplete and Testcomplete variables 
Testcomplete<-cbind(testX,testy, 'recordtype'="test")
Traincomplete<-cbind(trainX,trainy,'recordtype'="train")
completeset<-rbind(Traincomplete,Testcomplete)
colnames(completeset)<-c(as.character(features$V2),"activities","recordtype")

# Find the names of the columns containing "mean" and "std" in completeset
# Store the list of column names in extractioncol
meanextract<-grep('mean', colnames(completeset),value=FALSE)
stdextract<-grep('std', colnames(completeset), value=FALSE)
extractioncol<-c(meanextract,stdextract)

# Subset the completeset with the columns containing "mean" or "std"
Extract<-subset(completeset, select=extractioncol)

# Convert data in secon column of the data frame activities to the character format
# Rename the columns of the data frame activities
# Lookup activity_label in the table activities and create a column with explicit 
# activities in completeset by joining the two label through the common column activities
activities[,2]<-as.character(activities[,2])
colnames(activities)<-c("activities","activity_label")
completeset<-join(completeset,activities,by="activities")

# Create a data frame Subjects in binding the rows of the two data frames where 
# test sujects and train subjects are stored
# Subset completeset to the columns containing "mean", recordtype (train or test), 
# activities codes and activity-label 
Subjects<-rbind(trainsubject,testsubject)
Question5<-subset(completeset, select=c(meanextract,recordtype,activities,activity_label))

# Binding the Subject data frame and Question5 data frames and changing the name
# of the 50th column to make it more explicit
Question5<-cbind(Question5,Subjects)
colnames(Question5)[50]<-"subjects"

# Group the tidy data frame built for Question5 by subjects and activity_label
# while summarizing the data by means
# Make column names more explicit by getting rid of the ()
# Get rid of the "." in the column names and get all names in small case format 
Question5<-Question5 %>% group_by(subjects, activity_label) %>% summarise_each(funs(mean))
names(Question5)<-make.names(names(Question5))
names(Question5)<-tolower(gsub("\\.","",names(Question5)))

# Exporting the resulting file Question5.txt into the working directory
write.table(Question5,file="Question5.txt",sep=" ",row.names=FALSE,col.names=TRUE)

}
