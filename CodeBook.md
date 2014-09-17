#**Getting and Cleaning Data**
##*Course project*

### *Variable names*
Variable names are all the same except first 3 rows.

###### **1. ID_person_test**
* This is ID number of the subject who was part of the conducted Tests
* In the final data set, CleanDataSet.txt, data set was ordered according to ID number of testers
                    
###### **2. Sample**
* In this collumn is stored information if the subject was tested as part of **test sample**, or **training sample**
                    
###### **3. Activity_monitored**

* Data stored in this row describes measured (monitored) activity, one out of six which are:
- 1. **Walking**
- 2. **Walking upstairs**
- 3. **Walking downstairs**
- 4. **Sitting**
- 5. **Standing**
- 6. **Laying**


The rest variable names are as in the original "not-clean" data set, as follows:

    * "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z"
    * "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z"
    * "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z"
    * "tBodyGyro-mean()-X" "tBodyGyro-mean()-Y" "tBodyGyro-mean()-Z"
    * "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z"
    * "tBodyAccMag-mean()", "tGravityAccMag-mean()", "tBodyAccJerkMag-mean()"
    * "tBodyGyroMag-mean()", "tBodyGyroJerkMag-mean()"
    * "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z"
    * "fBodyAcc-meanFreq()-X", "fBodyAcc-meanFreq()-Y", "fBodyAcc-meanFreq()-Z"
    * "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z"
    * "fBodyAccJerk-meanFreq()-X", "fBodyAccJerk-meanFreq()-Y", "fBodyAccJerk-meanFreq()-Z"
    * "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z"
    * "fBodyGyro-meanFreq()-X", "fBodyGyro-meanFreq()-Y", "fBodyGyro-meanFreq()-Z"
    * "fBodyAccMag-mean()", "fBodyAccMag-meanFreq()"
    * "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-meanFreq()"
    * "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-meanFreq()"
    * "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-meanFreq()" **

During Cleaning Data, operations done through run_analysis.R code are:
*  Reading Data
*  Combining all data with Subject(ID_person_test), Sample(TRAINING or TEST) and Activity being monitored(Activity_monitored)
*  Calculating the task about extracting Mean and Standard deviation values for each participant
*  Turning Ativity_monitored values from number marks(1-6) to word description(ex."WALKING","SITTING"...)
*  Finally merging all cleaned data set into one new Dataset variable
*  Variables TRAIN and TEST merged into Dataset variable are the same, except TRAIN is for TRAINING status and TEST for TEST status of participants
*  Dataset_extract variable is dataset which reachs final end of task aboud Mean and STD values combining TRAING and TEST results
*  TidyData variable is almost the same as Dataset_extract, except TidyData consists only out of MEAN values for TRAINING and TEST samples
*  Final step (2 long for loops in the code) is to extract values for each subject for each activity on average for TRAINING and TEST and storing it into the final variable ** *CleanDataSet* ** arranged according to ID number of tested person

Final data is uploaded in the reposotory *Data-Cleaning_Course-project*: **CleanDataSet.csv** and **CleanDataSet.txt**
