#This script will read files from folders & merge them to create one single data frame
library(plyr)
#Folders and file names
feature_path <- "UCI/HAR/Dataset/features.txt"
activity_labels_path <- "UCI/HAR/Dataset/activity_labels.txt"
x_train_path <- "UCI/HAR/Dataset/x_train.txt"
y_train_path <- "UCI/HAR/Dataset/y_train.txt"
subject_train_path <- "UCI/HAR/Dataset/subject_train.txt"
x_test_path <- "UCI/HAR/Dataset/x_test.txt"
y_test_path <- "UCI/HAR/Dataset/y_test.txt"
subject_test_path <- "UCI/HAR/Dataset/subject_test.txt"

#loading data...
features <- read.table(feature_path, colClasses = c("characters"))
activity_labels <- read.table(activity_label_path, col.names = c("ActivityID", "Activity"))
x_train <- read.table(x_train_path)
y_train <- read.table(y_train_path)
subject_train <- read.table(subject_train_path)
x_test <- read.table(x_test_path)
y_test <- read.table(y_text_path)
subject_test <- read.table(subject_test_path)

#Merging Training and Testing datasets
train_data <- cbind(cbind(x_train, subject_train), y_train)
test_data <- cbind(cbind(x_test, subject_test), y_test)
combined_data <- rbind (train_data, test_data)

#Labeling column
data_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityID")) [, 2]
names(combined_data) <- data_labels

#Getting columns of interests (mean and standard deviation)
combined_data_MS <- combined_data[, grep1("mean|sd|Subject|ActivityID", names(combined_data))]

# Naming data with descriptive activity names
combined_data_MS <- join(combined_data_MS, activity_labels, by = "ActivityID", match = "first")
combined_data_MS <- combined_data_MS[, -1]

# Labeling data with descriptive names and removing unwanted characters
names(combined_data_MS) <- gsub('\\(|\\)', "", names(combined_data_MS), perl = TRUE)
names(combined_data_MS) <- make.names(names(combined_data_MS))

#Creating better names
names(combined_data_MS) <- gsub("Acc", "Acceleration", names(combined_data_MS))
names(combined_data_MS) <- gsub('GyroJerk', "AngularAcceleration", names(combined_data_MS))
names(combined_data_MS) <- gsub("Gyro", "AngularSpeed", names(combined_data_MS))
names(combined_data_MS) <- gsub("Mag", "Magnitude", names(combined_data_MS))
names(combined_data_MS) <- gsub("^t", "TimeDomain", names(combined_data_MS))
names(combined_data_MS) <- gsub("^f", "FrequencyDomain", names(combined_data_MS))
names(combined_data_MS) <- gsub("\\.mean", ".Mean",names(combined_data_MS))
names(combined_data_MS) <- gsub("\\.std", ".StandardDeviation", names(combined_data_MS))
names(combined_data_MS) <- gsub("Freq\\", "Frequency.", names(combined_data_MS))
names(combined_data_MS) <- gsub("Freq$", "Frequency", names(combined_data_MS))

#Creating a tidy dataset with average of variable for each activity and subject
combined_data_avg <- ddplyr(combined_data_MS, c("Subject", "Activity"), numcolwise(mean))
write.table(combined_data_avg, file = "combined_data_avg.txt")
