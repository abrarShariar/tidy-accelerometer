library(dplyr)
# load train data
subject_train <- read.table("dataset/uci_dataset/train/subject_train.txt")
x_train <- read.table("dataset/uci_dataset/train/X_train.txt")
y_train <- read.table("dataset/uci_dataset/train/y_train.txt")

# col bind y_train and subject_train
train_m <- cbind(subject_train, y_train)
colnames(train_m) <- c("subject","label")
train_m <- cbind(train_m, x_train)

# load test data
subject_test <- read.table("dataset/uci_dataset/test/subject_test.txt")
x_test <- read.table("dataset/uci_dataset/test/X_test.txt")
y_test <- read.table("dataset/uci_dataset/test/y_test.txt")

# col bind y_test and subject_test
test_m <- cbind(subject_test, y_test)
colnames(test_m) <- c("subject","label")
test_m <- cbind(test_m, x_test)

# merge train and test
merge_data <- rbind(train_m, test_m)

# create dir and save file
dir.create(file.path("result-dataset"))
write.csv(merge_data, file="result-dataset/1-merge-data.csv")



