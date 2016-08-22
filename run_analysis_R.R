setwd("~/Downloads/UCI HAR Dataset")
### Step 1: Merging Data
##Training Data
features     = read.table('./features.txt',header=FALSE)
activity = read.table('./activity_labels.txt',header=FALSE)
subject = read.table('./train/subject_train.txt',header=FALSE) #imports subject_train.txt
xtrain       = read.table('./train/x_train.txt',header=FALSE) #imports x_train.txt
ytrain       = read.table('./train/y_train.txt',header=FALSE)
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "activityid"
colnames(subject) <- "subjectid"
training <- cbind(subject,ytrain,xtrain)
##Test Data
subject = read.table('./train/subject_train.txt',header=FALSE) #imports subject_train.txt
xtest       = read.table('./test/X_test.txt',header=FALSE) #imports x_train.txt
ytest       = read.table('./test/y_test.txt',header=FALSE)
subjecttest <- read.table('./test/subject_test.txt',header=FALSE)
colnames(xtest) <- features[,2]
colnames(activity) <- c("activityid","activity")
xnames <- features[,2]
colnames(ytest) <- "activityid"
colnames(subjecttest) <- "subjectid"
test <- cbind(subjecttest,ytest,xtest)
##final data
names(final)
final <- rbind(training,test)
names <- colnames(final)
## Step 2: Extract Mean and STD values 
x <- (grepl("activity..",names) | grepl("subject..",names) | grepl("-mean..",names) & !grepl("-meanFreq..",names) & !grepl("mean..-",names) | grepl("-std..",names) & !grepl("-std()..-",names))
finalfinal <- final[x == TRUE]
## Step 3 and Step 4
finally <- merge(finalfinal,activity,by = "activityid",all.x = TRUE)
## 5. averaging the tidy data
tidydata <- ddply(finally, .(subjectid, activity), function(x) colMeans(x[, 3:20]))
write.table(tidydata, "averages_tidy.txt", row.name=FALSE)
