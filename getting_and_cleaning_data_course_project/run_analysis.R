#Reading files into R
activity_labels <- read.table("~/R/UCI HAR Dataset/activity_labels.txt", quote="\"")
features <- read.table("~/R/UCI HAR Dataset/features.txt", quote="\"")
#test dataset
subject_test <- read.table("~/R/UCI HAR Dataset/test/subject_test.txt", quote="\"")
y_test <- read.table("~/R/UCI HAR Dataset/test/y_test.txt", quote="\"")
X_test <- read.table("~/R/UCI HAR Dataset/test/X_test.txt", quote="\"")

#train dataset
subject_train <- read.table("~/R/UCI HAR Dataset/train/subject_train.txt", quote="\"")
y_train <- read.table("~/R/UCI HAR Dataset/train/y_train.txt", quote="\"")
X_train <- read.table("~/R/UCI HAR Dataset/train/X_train.txt", quote="\"")

#Renaming column names for activity and subject
subject_test<-rename(subject_test, subject = V1)
y_test<-rename(y_test, activity = V1)

subject_train<-rename(subject_train, subject = V1)
y_train<-rename(y_train, activity = V1)

#Change column names of X_test and X_train to features and remove duplicated columns
colnames(X_test)<-features[,2]
colnames(X_train)<-features[,2]
X_test<-X_test[!duplicated(names(X_test))]
X_train<-X_train[!duplicated(names(X_train))]

#Select columns that have mean() or std() of measurement based on column name
test_means<-select(X_test,contains("mean()"))
test_std<-select(X_test,contains("std()"))
train_std<-select(X_train,contains("std()"))
train_means<-select(X_train,contains("mean()"))

test_meanstd<-bind_cols(test_means,test_std)
train_meanstd<-bind_cols(train_means,train_std)

#Binding test data into one df
test_data<-bind_cols(subject_test, y_test, test_meanstd)
#Binding train data into one df
train_data<-bind_cols(subject_train, y_train, train_meanstd)

#Merging test and train datasets
data<-bind_rows(test_data,train_data)

#convert values of activity column to factor and replace with activity_labels
data$activity<-as.factor(data$activity)
levels(data$activity)<-activity_labels[,2]

#arrange by subject
data<-arrange(data,subject)

#write to text file
write.table(data,"tidy_data.txt,row.name=FALSE")