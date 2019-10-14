library(dplyr)
library(stringr)
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

# ---- start of Q:1 ----
# col bind y_test and subject_test
test_m <- cbind(subject_test, y_test)
colnames(test_m) <- c("subject","label")
test_m <- cbind(test_m, x_test)

# merge train and test
merge_data <- rbind(train_m, test_m)

# create dir and save file
dir.create(file.path("result-dataset"))
write.csv(merge_data, file="result-dataset/1-merge-data.csv")

# ----- start of Q:2 -----
# filter feature indexs from features.txt
d <- read.table("dataset/uci_dataset/features.txt")
col_indices <- c(paste("V",d[grep("std", d$V2),"V1"], sep=""), paste("V",d[grep("[Mm]ean", d$V2),"V1"], sep=""))
extracted_data <- merge_data[,c("subject", "label",col_indices)]
write.csv(extracted_data, file="result-dataset/2-extract-data.csv")

# ---- start of Q:3 ----
labels <- read.table("dataset/uci_dataset/activity_labels.txt")
colnames(labels) <- c("no", "text")
label_data <- merge(labels, merge_data, by.x="no", by.y="label")
write.csv(label_data, file="result-dataset/3-label-data.csv")


# ---- start of Q:4 ----
feature_list <- read.table("dataset/uci_dataset/features.txt")
feature_labels <- feature_list$V2
feature_labels <- str_replace_all(feature_labels, c("-"=".", "[(]"="", "[)]"="", ","="."))
colnames(label_data) <- c("activity_no", "activity_label","subject", feature_labels)
write.csv(label_data, file="result-dataset/4-descriptive-data.csv")

# ----- start of Q:5 ----

