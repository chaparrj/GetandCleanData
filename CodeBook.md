---
title: "Code Book"
author: "Juan Manuel Chaparro"
date: "16 April 2019"
output: html_document
---

## Data Transformation Code Book

The R script called run_analysis.R creates a data set called "allData", that is an R data frame with 89 variables and 10299 records.  

The steps implemented in run_analysis.R are:

1. Set working directory to "Get-and-Clean-Data-Project" folder where all files should be.  
2. Read labels for features of accelerometer data and activity as follows:

- amLabels : reading from file UCI_HAR/features.txt
- acLabels : reading from file UCI_HAR/activity_labels.txt  

3. Read tables in test folder to create the following data sets:

- idTest : from UCI_HAR/test/subject_train.txt file
- xTest : from UCI_HAR/test/X_train.txt file
- yTest : from UCI_HAR/test/y_train.txt file  

4.  Assign names to the variables on the data sets, using the labels read in the first step.  

5. Perform two data transformation:

- Data frame xTest: filter variable names that have the strings "Mean" or "mean" or "std" in the name. A new data frame called xTestR is created.
- Data frame yTest: create a new variable that maps existing IDs for activity codes to the text describing the activity.  

6. Merge bind idTes, yTest and xTestR data frames in to a single data frame called "Test".  

7. Repeat steps 2 to 4 for training data, creating data frames called idTrain, xTrain and yTrain. All training data frames are bind to create a "Train" data set.  

8. Create "allData" data set by merging "Test" and "Train" data sets by the intersect of all variables.  

9. Create the "finalData" data frame, taking "allData" grouping by "subjectID" and "activityText" and computing the mean() of each variable on accelometer variables. 

10. Dump the final data set, "finalData", to a separate file. The file is created on the current directory under the name "UCI-HAR_finalData.csv"  

## Final Data Code Book

The final data set has the following variables:

- subjectID: It is the identifier of the subject performing the test.
- activityText: string name of the activity performed by the subject during the test.
- activityID : mean of the numeric identifier of the activity performed by the subject during the test. 
- 86-variables with the mean value for accelerometer measurements on a smartphone while the subject performed a particular activity (as logged on columns two and three).  
    
  
  
  
  

