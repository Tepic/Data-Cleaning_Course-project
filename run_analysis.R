rm(list=ls())

library(dplyr)
library(tidyr)

#READING DATA
X_train<-read.table("D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\train\\X_train.txt", colClasses = c("character","numeric"))
subject_train<-read.table("D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\train\\subject_train.txt", colClasses = "character")
y_train<-read.table("D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\train\\y_train.txt", colClasses = "character")
NAMES<-read.table("D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\features.txt", colClasses = "character")

X_test<-read.table("D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\test\\X_test.txt", colClasses = c("character","numeric"))
subject_test<-read.table("D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\test\\subject_test.txt", colClasses = "character")
y_test<-read.table("D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\test\\y_test.txt", colClasses = "character")

#RENAMING DATAS COLUMNS
colnames(X_train)<-NAMES[,2]
colnames(X_test)<-NAMES[,2]

#ADDING NEW COLUMN TO DETERMINE WHETHER IT'S TRAINNG OR TEST SAMPLE
subject_train[,2]<-c("TRAINING")
subject_test[,2]<-c("TEST")

colnames(subject_train)[2]<-c("Sample")
colnames(subject_test)[2]<-c("Sample")

#MERGING ALL DATA FOR SPECIFIC SAMPLE
TRAIN<-cbind(subject_train,y_train,X_train)
TEST<-cbind(subject_test,y_test,X_test)

colnames(TRAIN)[1]<-c("ID_person_test")
colnames(TEST)[1]<-c("ID_person_test")
colnames(TRAIN)[3]<-c("Activity_monitored")
colnames(TEST)[3]<-c("Activity_monitored")

#EXTRACTING MEAN AND STANDARD DEVIATION COLUMN
names_all<-names(TRAIN)
vector_mean<-grep("mean",names_all)
vector_std<-grep("std",names_all)

TRAIN_extract<-cbind(TRAIN[,vector_mean],TRAIN[,vector_std])
TEST_extract<-cbind(TEST[,vector_mean],TEST[,vector_std])

#CHANING ACTIVITY_MONITORED DATA FROM NUMERIC SIGNS TO STRING(WORD DESCRIPTION OF ACTIVITY)
for(i in 1:nrow(TRAIN))
{
	if(TRAIN[i,3]=="1")		{TRAIN[i,3]<-c("WALKING")}

	else if(TRAIN[i,3]=="2")	{TRAIN[i,3]<-c("WALKING_UPSTAIRS")}

	else if(TRAIN[i,3]=="3")	{TRAIN[i,3]<-c("WALKING_DOWNSTAIRS")}

	else if(TRAIN[i,3]=="4")	{TRAIN[i,3]<-c("SITTING")}

	else if(TRAIN[i,3]=="5")	{TRAIN[i,3]<-c("STANDING")}

	else if(TRAIN[i,3]=="6")	{TRAIN[i,3]<-c("LAYING")}
}

for(i in 1:nrow(TEST))
{
	if(TEST[i,3]=="1")		{TEST[i,3]<-c("WALKING")}

	else if(TEST[i,3]=="2")	{TEST[i,3]<-c("WALKING_UPSTAIRS")}

	else if(TEST[i,3]=="3")	{TRAIN[i,3]<-c("WALKING_DOWNSTAIRS")}

	else if(TEST[i,3]=="4")	{TEST[i,3]<-c("SITTING")}

	else if(TEST[i,3]=="5")	{TRAIN[i,3]<-c("STANDING")}

	else if(TEST[i,3]=="6")	{TEST[i,3]<-c("LAYING")}
}

#MERGING ALL DATA INTO ONE DATASET
#1 FULL DATA
Dataset<-rbind(TRAIN,TEST)
#2 FULL DATA [MEAN AND STANDARD DEVIATION ONLY]
Dataset_extract<-rbind(TRAIN_extract,TEST_extract)

#CLEAN DATA SET OF AVERAGE FOR EVERY VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT (ID_person_test)
TidyData<-rbind(TRAIN[,c(1:3,vector_mean)],TEST[,c(1:3,vector_mean)])
CleanDataSet<-cbind(TidyData[1,])

#places of exponential numbers
place<-c(4,6,7,9,10,12,13,15,16,18,19,21,23,25,28,30,32,35,37,40,42,43,46,47)
for(k in 1:length(place))
{
	TidyData[,place[k]] <- as.numeric(TidyData[,place[k]])
}

count<-1

for(i in 1:30)
{
		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="WALKING" & TidyData$Sample=="TRAINING")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="WALKING_UPSTAIRS" & TidyData$Sample=="TRAINING")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="WALKING_DOWNSTAIRS" & TidyData$Sample=="TRAINING")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="SITTING" & TidyData$Sample=="TRAINING")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="STANDING" & TidyData$Sample=="TRAINING")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="LAYING" & TidyData$Sample=="TRAINING")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1
}

for(i in 1:30)
{
		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="WALKING" & TidyData$Sample=="TEST")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="WALKING_UPSTAIRS" & TidyData$Sample=="TEST")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="WALKING_DOWNSTAIRS" & TidyData$Sample=="TEST")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="SITTING" & TidyData$Sample=="TEST")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="STANDING" & TidyData$Sample=="TEST")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1

		calculating<-which(TidyData$ID_person_test==i & TidyData$Activity_monitored=="LAYING" & TidyData$Sample=="TEST")
		CleanDataSet[count,1:3]<-TidyData[calculating[1],1:3]
		for(k in 4:ncol(TidyData))
		{
			CleanDataSet[count,k]<-mean(TidyData[calculating,k])
		}
		count<-count+1
}

CleanDataSet<-CleanDataSet[which(CleanDataSet[,1]!="NA"),]
CleanDataSet[,1]<-as.numeric(CleanDataSet[,1])
CleanDataSet<-arrange(CleanDataSet,ID_person_test)

for(i in 4:ncol(CleanDataSet))
{
	CleanDataSet[,i]<-as.numeric(CleanDataSet[,i])
}

View(CleanDataSet)

write.csv(CleanDataSet,file="D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\CleanDataSet.csv",row.names=FALSE)

write.table(CleanDataSet,file="D:\\Coursera\\Data Cleaning\\Course Project\\UCI HAR Dataset\\CleanDataSet.txt",row.names=FALSE)
