##########################################################
# Getting and Cleaning Data - Course Project - CodeBook.md
##########################################################

This document describes how the tidy data is produced.

###########################
## Source of Data
###########################
The original data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original data used for the project can be obtained from:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once decompressed the contents are the following ones:

├── activity_labels.txt
├── features_info.txt
├── features.txt
├── README.txt
├── test
│   ├── Inertial Signals
│   │   ├── body_acc_x_test.txt
│   │   ├── body_acc_y_test.txt
│   │   ├── body_acc_z_test.txt
│   │   ├── body_gyro_x_test.txt
│   │   ├── body_gyro_y_test.txt
│   │   ├── body_gyro_z_test.txt
│   │   ├── total_acc_x_test.txt
│   │   ├── total_acc_y_test.txt
│   │   └── total_acc_z_test.txt
│   ├── subject_test.txt
│   ├── X_test.txt
│   └── y_test.txt
├── tidy_data_set.csv
├── tidy_data_set.txt
└── train
    ├── Inertial Signals
    │   ├── body_acc_x_train.txt
    │   ├── body_acc_y_train.txt
    │   ├── body_acc_z_train.txt
    │   ├── body_gyro_x_train.txt
    │   ├── body_gyro_y_train.txt
    │   ├── body_gyro_z_train.txt
    │   ├── total_acc_x_train.txt
    │   ├── total_acc_y_train.txt
    │   └── total_acc_z_train.txt
    ├── subject_train.txt
    ├── X_train.txt
    └── y_train.txt


- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


Note: For this project, raw inertial signal data files were not used. 

###########################
# Data Trasnformations
###########################

The following processing steps where performed on the original data to get the tidy datase:

1. Trainig and Test data were merged in a temporal data set named XYmergedDF. This DF had the following collumns: (Subject, Activity, 561-feature vector from training and test data).
   Activity codes were linked to activity names using the R factor function. features where named from the contents of features.txt.

2. Measurements on the mean and standard deviation features from the merged data set where extracted in a temporal DF named mean_std_measurementsDF. This DF had the following collumns: (Subject, Activity, Vector for mean and std data features)

3. From mean_std_measurementsDF a tidy data set with the average of each variable for each activity and each subject. To do so first we used the R function melt() to combine the activity and subject indexes and then the dcast() function to compute the average.



