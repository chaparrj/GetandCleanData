library(plyr)
library(dplyr)
setwd("Get-and-Clean-Data-Project")
# Read tables that will be used for reference
# Accelerometer feature labels
amLabels <- read.table("UCI_HAR/features.txt")
# Activity labels
acLabels <- read.table("UCI_HAR/activity_labels.txt")


# Work with Test data set
# Read IDs of subjects
idTest <- read.table("UCI_HAR/test/subject_test.txt")
names(idTest) <- "subjectID"
# Read accelerometer data
xTest <- read.table("UCI_HAR/test/X_test.txt")
names(xTest) <- amLabels[, 2]
# Choose only "[Mm]ean" and "std" variables
xTestR <- xTest[, grep("[Mm]ean|std", names(xTest))]
# Read activityID
yTest <- read.table("UCI_HAR/test/y_test.txt")
names(yTest) <- "activityID"
# Add column with text of the activity
a <- as.vector(acLabels[,1])
b <- as.vector(acLabels[,2])
yTest$activityText <- mapvalues(yTest$activityID, a, b)
rm(a)
rm(b)
# Now all columns are binded together on a data set
Test <- cbind(idTest, yTest, xTestR)

# Same process has to be repeated for Train data set
# Work with Test data set
# Read IDs of subjects
idTrain <- read.table("UCI_HAR/train/subject_train.txt")
names(idTrain) <- "subjectID"
# Read accelerometer data
xTrain <- read.table("UCI_HAR/train/X_train.txt")
names(xTrain) <- amLabels[, 2]
# Choose only "[Mm]ean" and "std" variables
xTrainR <- xTrain[, grep("[Mm]ean|std", names(xTrain))]
# Read activityID
yTrain <- read.table("UCI_HAR/train/y_train.txt")
names(yTrain) <- "activityID"
# Add column with text of the activity
a <- as.vector(acLabels[,1])
b <- as.vector(acLabels[,2])
yTrain$activityText <- mapvalues(yTrain$activityID, a, b)
rm(a)
rm(b)
# Now all columns are binded together on a data set
Train <- cbind(idTrain, yTrain, xTrainR)

# To have a single data set, Test and Train are merged
allData <- merge(Test, Train, by = intersect(names(Test), names(Train)), all = TRUE)
# Finally, a new independent, tidy data set is created
# with the average of each variable for each activity and each subject
finalData <- allData %>% 
        group_by(subjectID, activityText) %>% 
        dplyr::summarise_all(funs(mean))
# Dump the merged data set to a separate file
write.table(finalData, file = "UCI-HAR_finalData.csv")


