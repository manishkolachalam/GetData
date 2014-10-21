url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "UCIDataset.zip")
unzip("UCIDataset.zip")
setwd("./UCI HAR Dataset")

X_train<- read.table("./train/X_train.txt")
y_train<- read.table("./train/y_train.txt")
subject_train<- read.table("./train/subject_train.txt")

X_test<- read.table("./test/X_test.txt")
y_test<- read.table("./test/y_test.txt")
subject_test<- read.table("./test/subject_test.txt")

features<- read.table("features.txt")

colnames(X_test)<- features$V2
colnames(X_train)<- features$V2
colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"
colnames(subject_train) <- "Subject"
colnames(subject_test) <- "Subject"

Act.train <- cbind(subject_train, y_train, X_train)
Act.test <- cbind(subject_test, y_test, X_test)

Act.merge<- rbind(Act.train, Act.test)

Act.merge$Activity <- factor(Act.merge$Activity, levels = c(1,2,3,4,5,6),
                      labels = c("WALKING", "WALKING_UPSTAIRS", 
                                 "WALKING_DOWNSTAIRS", 
                           "SITTING", "STANDING", "LAYING"))


Act.merge$Subject <- as.factor(Act.merge$Subject)

Act.subset<- Act.merge[,grep("mean|std", features$V2, 
                        ignore.case = TRUE, value = TRUE)]

Subject.Act.subset<- cbind(Act.merge$Subject, Act.merge$Activity, Act.subset)

colnames(Subject.Act.subset) <- c("Subject", "Activity",
                                  grep("mean|std", features$V2, 
                                       ignore.case = TRUE, value = TRUE))

Final <- aggregate(Subject.Act.subset[,-c(1,2)], by = list(
          Subject.Act.subset$Activity, Subject.Act.subset$Subject), 
          FUN=mean)

colnames(Final) <- c("Activity", "Subject", grep("mean|std", features$V2, 
                                       ignore.case = TRUE, value = TRUE))


renameFinal <- gsub("-", "", names(Final))
renameFinal <- gsub("\\(|\\)", "", renameFinal)
renameFinal <- gsub(",", "", renameFinal)

Tidy<- Final
colnames(Tidy) <- renameFinal

oldfeatures<- names(Final)
Codebook <- data.frame(oldfeatures, renameFinal)
write.table(Codebook, file = "Codebook.txt")

write.table(Tidy, file = "Tidy.txt", row.names = FALSE)

head(Tidy)