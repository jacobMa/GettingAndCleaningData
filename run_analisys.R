#run_analys.R

#Note:  
#file run_analysis.R in can be run as long as the Samsung data UCI_HAR_Dataset is in your working directory

library(data.table)
library(reshape2)

#Function to download the project data #
########################################

# Data URLs
data<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
codeBook<-"http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

## Retrieve the data and the description associated to the data ##
if(!file.exists("UCI_HAR_Dataset.zip")){
  download.file(data,dest="UCI_HAR_Dataset.zip",method="curl")
  
  #extract the contents of the zip file
  unzip("UCI_HAR_Dataset.zip")
  print("Dataset extracted in the directory UCI HAR Dataset ")
  
}else{
  print("Data UCI_HAR_Dataset.zip already downloaded")
}
if(!file.exists("UCI_HAR_Dataset_Codebook.html")){
  download.file(codeBook,dest="UCI_HAR_Dataset_Codebook.html",method="curl")
}else{
  print("Data UCI_HAR_Dataset codebook already downloaded")
}


# Costruct the path to the data files #
#######################################
#Train data (X_train.txt and y_train.txt)
XTrainFile<-file.path(".","UCI HAR Dataset","train","X_train.txt")
YTrainFile<-file.path(".","UCI HAR Dataset","train","y_train.txt")

#Test data (X_test.txt and y_test.txt)
XTestFile<-file.path(".","UCI HAR Dataset","test","X_test.txt")
YTestFile<-file.path(".","UCI HAR Dataset","test","y_test.txt")

#Subject train data (subject_train.txt)
SubjectTrainFile<-file.path(".","UCI HAR Dataset","train","subject_train.txt")

#Subject train data (subject_test.txt)
SubjectTestFile<-file.path(".","UCI HAR Dataset","test","subject_test.txt")

#Feautures train data (features.txt)
features_namesFile<-file.path(".","UCI HAR Dataset","features.txt")

##Activitu labels train data (activity_labels.txt)
activity_labelsFile<-file.path(".","UCI HAR Dataset","activity_labels.txt")

## Load data in Data Frames  ##
###############################
# Load subjects in train data
XSubjectTrainDF<-read.table(SubjectTrainFile)
# Name the subject data with label "subject"

# Load subjects in test data
XSubjectTestDF<-read.table(SubjectTestFile)
# Name the subject data with label "Subject"

# Load the features 
featuresDF<-read.table(features_namesFile)

# Load activity levels in a Data Frame
activity_labelsDF<-read.table(activity_labelsFile)

# Load the Train data in a Data Frame
XtrainDF<-read.table(XTrainFile)
colnames(XtrainDF)<-featuresDF[,2]
YtrainDF<-read.table(YTrainFile)


# Load the Test data in a Data Frame
XtestDF<-read.table(XTestFile)
colnames(XtrainDF)<-featuresDF[,2]
YtestDF<-read.table(YTestFile)



# 1. Merges the training and the test sets to create one data set. #
####################################################################
XYtrainDF<-cbind(YtrainDF,XSubjectTrainDF,XtrainDF)    # XYtrainDF columns = Subject, Activity, 561-feature vector from training data
XYtestDF<-cbind(YtestDF,XSubjectTestDF,XtestDF)        # XYtestDF columns = Subject, Activity, 561-feature vector from test data

# labels the data set with descriptive variable names
colnames(XYtrainDF)<-c("activity","subject",as.character(featuresDF[,2]))
colnames(XYtestDF)<-c("activity","subject",as.character(featuresDF[,2]))

XYmergedDF<-rbind(XYtrainDF,XYtestDF)   #XYmergedDF columns = Subject, Activity, 561-feature vector from test data
                                        #XYmergedDF rows = columns = XYtrainDF rows followed by XYtestDF rows



# 2.Extracts only the measurements on the mean and standard deviation for each measurement. #
#############################################################################################
# Since we have added two collumns to the XYmerged Data Frame to contain the subject and the associated activity
# we need to grep the features names over 563 collumns and not 561, this is achieved by adding 2 to the indexes returned
# by the grep call

mean_std_features<-featuresDF[grep("-std()|-mean()",featuresDF[,2]),1]+2

#  measurements on the mean and standard deviation
mean_std_measurementsDF<-XYmergedDF[,c(1,2,mean_std_features)] #mean_std_measurementsDF columns = Subject, Activity, feature vector for mean ans std data

# 3. Uses descriptive activity names to name the activities in the data set. #
##############################################################################
mean_std_measurementsDF[,2]<-factor(mean_std_measurementsDF[,2],levels=activity_labelsDF[,1],labels=activity_labelsDF[,2])

# 4. Appropriately labels the data set with descriptive variable names. #
#########################################################################
# Already done in 1.

# 5. From the data set in step 4, creates a second, independent tidy data set with #
# the average of each variable for each activity and each subject.                 #
####################################################################################
molten_dataset<-melt(mean_std_measurementsDF,id.vars=c("activity","subject"), measure.vars=colnames(mean_std_measurementsDF)[3:ncol(mean_std_measurementsDF)])
tidy_dataset<-dcast(molten_dataset,molten_dataset[,1]+molten_dataset[,2] ~ variable , mean)

# Write data set into a file #
##############################
write.table(tidy_dataset,file=file.path(".","tidy_data_set.txt"),sep=",",row.names=FALSE)
print("Tidy data set file created!")