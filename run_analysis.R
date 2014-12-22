#This script will read files from folders & merge them to create one single data frame
library(plyr)
#Folders and file names
directory <- "UCI\ HAR\ Dataset"
feature_path <- paste(directory, "/features.txt", sep = "")
activity_labels_path <- paste(directory, "/activity_labels.txt", sep = "")
x_train_path <- paste(directory, "/X_train.txt", sep = "")
y_train_path <- paste(directory, "/y_train.txt", sep = "")
subject_train_path <- paste(directory, "/subject_train.txt", sep = "")
x_test_path <- paste(directory, "/X_test.txt", sep = "")
y_test_path <- paste(directory, "/y_test.txt", sep = "")
subject_test_path <- paste(directory, "/subject_test.txt", sep = "")

#loading data...
features <- read.table(feature_path, colClasses = c("character"))
activity_labels <- read.table(activity_labels_path, col.names = c("ActivityID", "Activity"))
x_train <- read.table(x_train_path)
y_train <- read.table(y_train_path)
subject_train <- read.table(subject_train_path)
x_test <- read.table(x_test_path)
y_test <- read.table(y_test_path)
subject_test <- read.table(subject_test_path)

#Merging Training and Testing datasets
train_data <- cbind(cbind(x_train, subject_train), y_train)
test_data <- cbind(cbind(x_test, subject_test), y_test)
combined_data <- rbind (train_data, test_data)

#Labeling column
data_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityID")) [, 2]
names(combined_data) <- data_labels

#Getting columns of interests (mean and standard deviation)
combined_data_MS <- combined_data[, grepl("mean|sd|Subject|ActivityID", names(combined_data))]

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
names(combined_data_MS) <- gsub("Freq\\.", "Frequency.", names(combined_data_MS))
names(combined_data_MS) <- gsub("Freq$", "Frequency", names(combined_data_MS))

#Creating a tidy dataset with average of variable for each activity and subject
combined_data_avg <- ddply(combined_data_MS, c("Subject", "Activity"), numcolwise(mean))
write.table(combined_data_avg, file = "combined_data_avg.txt")
