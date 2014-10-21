# Coursera Getting and Cleaning Data Course Project
Kolachalam Manish Sharma  


This document is an explanation of the R script "run_analysis.R" used to generate the tidy data set for the Coursera Getting and Cleaning Data Course Project. Each Chunk perfroms a particular function which is described in the section for the function.

####Downloading and unzipping the dataset

It is assumed that your working directory is set to your directory of interest, to which the data will be downloaded and unzipped


```r
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "UCIDataset.zip")
unzip("UCIDataset.zip")
setwd("./UCI HAR Dataset")
```

####Reading in the data

The following commands read in all the files required for this project

```r
X_train<- read.table("./train/X_train.txt")
y_train<- read.table("./train/y_train.txt")
subject_train<- read.table("./train/subject_train.txt")

X_test<- read.table("./test/X_test.txt")
y_test<- read.table("./test/y_test.txt")
subject_test<- read.table("./test/subject_test.txt")

features<- read.table("features.txt")
```

####Assigning column names

The column names for the training and testing datasets are assigned from the "features" table containing information read in to R from the "features"" text file of the UCI HAR dataset. These labels will be modified in a subsequent section of this script to make them more usable. The activity labels and the Subject id data columns are also assigned appropriate labels.

```r
colnames(X_test)<- features$V2
colnames(X_train)<- features$V2
colnames(y_test) <- "Activity"
colnames(y_train) <- "Activity"
colnames(subject_train) <- "Subject"
colnames(subject_test) <- "Subject"
```

####Merging the training and testing datasets

As a first step, the data for the features in the training and testing datasets are combined with the activity labels and subject ids of the corresponding dataset to form two new data frames using the "cbind" function

```r
Act.train <- cbind(subject_train, y_train, X_train)
Act.test <- cbind(subject_test, y_test, X_test)
```

These data frames are then merged using the "rbind" function to create a new data frame containing data from both the testing and training datasets.

```r
Act.merge<- rbind(Act.train, Act.test)
```

####Assigning descriptive activity names

The values of the Column representing the various activities are converted to factors with levels corresponding to those values and are then assigned labels corresponding to their respective activity using the "factor" function. The subject id column is also assigned the class factor.

```r
Act.merge$Activity <- factor(Act.merge$Activity, levels = c(1,2,3,4,5,6),
                      labels = c("WALKING", "WALKING_UPSTAIRS", 
                                 "WALKING_DOWNSTAIRS", 
                           "SITTING", "STANDING", "LAYING"))

Act.merge$Subject <- as.factor(Act.merge$Subject)
```

####Extracting Values of the mean and standard deviation of each feature

The Columns representing the mean and standard deviation of each feature are contained in the dataset and their labels contain the character string "mean" or "std" respectively. To extract these values, the merged data set was subsetted by the column index derived from the "grep" function for mean or std to create another dataset. This dataset was then combined with the subject id and activity labels columns to create a dataset that could be used for further processing. The column names had to be reassigned as the "cbind" functions relabelled the "Subject" and "Activity" columns.

```r
Act.subset<- Act.merge[,grep("mean|std", features$V2, 
                        ignore.case = TRUE, value = TRUE)]

Subject.Act.subset<- cbind(Act.merge$Subject, Act.merge$Activity, Act.subset)

colnames(Subject.Act.subset) <- c("Subject", "Activity",
                                  grep("mean|std", features$V2, 
                                       ignore.case = TRUE, value = TRUE))
```

####Creating a new dataset with average values sorted by subject and activity

The "aggregate" function was used to create a new dataset that was the result of splitting the data set based on subject id and activity and averaging the values of the various features grouped by each factor. The column names had to be reassigned as the aggregate function relabelled the factor columns.

```r
Final <- aggregate(Subject.Act.subset[,-c(1,2)], by = list(
          Subject.Act.subset$Activity, Subject.Act.subset$Subject), 
          FUN=mean)

colnames(Final) <- c("Activity", "Subject", grep("mean|std", features$V2, 
                                       ignore.case = TRUE, value = TRUE))
```

####Appropriate labels with descriptive variable names

As specified by the community TA in the discussion forums, the purpose of this excercise was to convert the labels into a format that is usable in R. To this end, the  hyphens, brackets and commas were removed from the variable names using the "gsub fuction" to create the "Tidy" dataset which is the final output of this script.


```r
renameFinal <- gsub("-", "", names(Final))
renameFinal <- gsub("\\(|\\)", "", renameFinal)
renameFinal <- gsub(",", "", renameFinal)

Tidy<- Final
colnames(Tidy) <- renameFinal
```

######Data for the Codebook
The data corresponding to the original and extracted feature labels were combined into a data frame for comparison

```r
oldfeatures<- names(Final)
Codebook <- data.frame(oldfeatures, renameFinal)
write.table(Codebook, file = "Codebook.txt")
```

######Write "Tidy dataset"
Code to write the "Tidy" dataset into a text file. The head of the dataset is shown below for illustration of the final result.

```r
write.table(Final, file = "Tidy.txt", row.names = FALSE)

head(Tidy)
```

```
##             Activity Subject tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ
## 1            WALKING       1        0.2773     -0.017384       -0.1111
## 2   WALKING_UPSTAIRS       1        0.2555     -0.023953       -0.0973
## 3 WALKING_DOWNSTAIRS       1        0.2892     -0.009919       -0.1076
## 4            SITTING       1        0.2612     -0.001308       -0.1045
## 5           STANDING       1        0.2789     -0.016138       -0.1106
## 6             LAYING       1        0.2216     -0.040514       -0.1132
##   tBodyAccstdX tBodyAccstdY tBodyAccstdZ tGravityAccmeanX tGravityAccmeanY
## 1     -0.28374      0.11446     -0.26003           0.9352          -0.2822
## 2     -0.35471     -0.00232     -0.01948           0.8934          -0.3622
## 3      0.03004     -0.03194     -0.23043           0.9319          -0.2666
## 4     -0.97723     -0.92262     -0.93959           0.8315           0.2044
## 5     -0.99576     -0.97319     -0.97978           0.9430          -0.2730
## 6     -0.92806     -0.83683     -0.82606          -0.2489           0.7055
##   tGravityAccmeanZ tGravityAccstdX tGravityAccstdY tGravityAccstdZ
## 1         -0.06810         -0.9766         -0.9713         -0.9477
## 2         -0.07540         -0.9564         -0.9528         -0.9124
## 3         -0.06212         -0.9506         -0.9370         -0.8959
## 4          0.33204         -0.9685         -0.9355         -0.9490
## 5          0.01349         -0.9938         -0.9812         -0.9763
## 6          0.44582         -0.8968         -0.9077         -0.8524
##   tBodyAccJerkmeanX tBodyAccJerkmeanY tBodyAccJerkmeanZ tBodyAccJerkstdX
## 1           0.07404         0.0282721         -0.004168         -0.11362
## 2           0.10137         0.0194863         -0.045563         -0.44684
## 3           0.05416         0.0296504         -0.010972         -0.01228
## 4           0.07748        -0.0006191         -0.003368         -0.98643
## 5           0.07538         0.0079757         -0.003685         -0.99460
## 6           0.08109         0.0038382          0.010834         -0.95848
##   tBodyAccJerkstdY tBodyAccJerkstdZ tBodyGyromeanX tBodyGyromeanY
## 1           0.0670          -0.5027       -0.04183       -0.06953
## 2          -0.3783          -0.7066        0.05055       -0.16617
## 3          -0.1016          -0.3457       -0.03508       -0.09094
## 4          -0.9814          -0.9879       -0.04535       -0.09192
## 5          -0.9856          -0.9923       -0.02399       -0.05940
## 6          -0.9241          -0.9549       -0.01655       -0.06449
##   tBodyGyromeanZ tBodyGyrostdX tBodyGyrostdY tBodyGyrostdZ
## 1        0.08494       -0.4735     -0.054608       -0.3443
## 2        0.05836       -0.5449      0.004105       -0.5072
## 3        0.09009       -0.4580     -0.126349       -0.1247
## 4        0.06293       -0.9772     -0.966474       -0.9414
## 5        0.07480       -0.9872     -0.987734       -0.9806
## 6        0.14869       -0.8735     -0.951090       -0.9083
##   tBodyGyroJerkmeanX tBodyGyroJerkmeanY tBodyGyroJerkmeanZ
## 1           -0.09000           -0.03984           -0.04613
## 2           -0.12223           -0.04215           -0.04071
## 3           -0.07396           -0.04399           -0.02705
## 4           -0.09368           -0.04021           -0.04670
## 5           -0.09961           -0.04406           -0.04895
## 6           -0.10727           -0.04152           -0.07405
##   tBodyGyroJerkstdX tBodyGyroJerkstdY tBodyGyroJerkstdZ tBodyAccMagmean
## 1           -0.2074           -0.3045           -0.4043        -0.13697
## 2           -0.6148           -0.6017           -0.6063        -0.12993
## 3           -0.4870           -0.2388           -0.2688         0.02719
## 4           -0.9917           -0.9895           -0.9879        -0.94854
## 5           -0.9929           -0.9951           -0.9921        -0.98428
## 6           -0.9186           -0.9679           -0.9578        -0.84193
##   tBodyAccMagstd tGravityAccMagmean tGravityAccMagstd tBodyAccJerkMagmean
## 1       -0.21969           -0.13697          -0.21969            -0.14143
## 2       -0.32497           -0.12993          -0.32497            -0.46650
## 3        0.01988            0.02719           0.01988            -0.08945
## 4       -0.92708           -0.94854          -0.92708            -0.98736
## 5       -0.98194           -0.98428          -0.98194            -0.99237
## 6       -0.79514           -0.84193          -0.79514            -0.95440
##   tBodyAccJerkMagstd tBodyGyroMagmean tBodyGyroMagstd tBodyGyroJerkMagmean
## 1           -0.07447         -0.16098         -0.1870              -0.2987
## 2           -0.47899         -0.12674         -0.1486              -0.5949
## 3           -0.02579         -0.07574         -0.2257              -0.2955
## 4           -0.98412         -0.93089         -0.9345              -0.9920
## 5           -0.99310         -0.97649         -0.9787              -0.9950
## 6           -0.92825         -0.87476         -0.8190              -0.9635
##   tBodyGyroJerkMagstd fBodyAccmeanX fBodyAccmeanY fBodyAccmeanZ
## 1             -0.3253      -0.20279       0.08971       -0.3316
## 2             -0.6486      -0.40432      -0.19098       -0.4333
## 3             -0.3065       0.03823       0.00155       -0.2256
## 4             -0.9883      -0.97964      -0.94408       -0.9592
## 5             -0.9947      -0.99525      -0.97707       -0.9853
## 6             -0.9358      -0.93910      -0.86707       -0.8827
##   fBodyAccstdX fBodyAccstdY fBodyAccstdZ fBodyAccmeanFreqX
## 1     -0.31913      0.05604     -0.27969          -0.20755
## 2     -0.33743      0.02177      0.08596          -0.41874
## 3      0.02433     -0.11296     -0.29793          -0.30740
## 4     -0.97641     -0.91728     -0.93447          -0.04951
## 5     -0.99603     -0.97229     -0.97794           0.08652
## 6     -0.92444     -0.83363     -0.81289          -0.15879
##   fBodyAccmeanFreqY fBodyAccmeanFreqZ fBodyAccJerkmeanX fBodyAccJerkmeanY
## 1           0.11309           0.04973          -0.17055          -0.03523
## 2          -0.16070          -0.52011          -0.47988          -0.41344
## 3           0.06322           0.29432          -0.02766          -0.12867
## 4           0.07595           0.23883          -0.98660          -0.98158
## 5           0.11748           0.24486          -0.99463          -0.98542
## 6           0.09753           0.08944          -0.95707          -0.92246
##   fBodyAccJerkmeanZ fBodyAccJerkstdX fBodyAccJerkstdY fBodyAccJerkstdZ
## 1           -0.4690         -0.13359           0.1067          -0.5347
## 2           -0.6855         -0.46191          -0.3818          -0.7260
## 3           -0.2883         -0.08633          -0.1346          -0.4017
## 4           -0.9861         -0.98749          -0.9825          -0.9883
## 5           -0.9908         -0.99507          -0.9870          -0.9923
## 6           -0.9481         -0.96416          -0.9322          -0.9606
##   fBodyAccJerkmeanFreqX fBodyAccJerkmeanFreqY fBodyAccJerkmeanFreqZ
## 1               -0.2093              -0.38624             -0.185530
## 2               -0.3770              -0.50950             -0.551104
## 3               -0.2532              -0.33759              0.009372
## 4                0.2566               0.04754              0.092392
## 5                0.3142               0.03916              0.138581
## 6                0.1324               0.02451              0.024388
##   fBodyGyromeanX fBodyGyromeanY fBodyGyromeanZ fBodyGyrostdX fBodyGyrostdY
## 1        -0.3390        -0.1031       -0.25594       -0.5167      -0.03351
## 2        -0.4926        -0.3195       -0.45360       -0.5659       0.15154
## 3        -0.3524        -0.0557       -0.03187       -0.4954      -0.18141
## 4        -0.9762        -0.9758       -0.95132       -0.9779      -0.96235
## 5        -0.9864        -0.9890       -0.98077       -0.9875      -0.98711
## 6        -0.8502        -0.9522       -0.90930       -0.8823      -0.95123
##   fBodyGyrostdZ fBodyGyromeanFreqX fBodyGyromeanFreqY fBodyGyromeanFreqZ
## 1       -0.4366           0.014784           -0.06577          0.0007733
## 2       -0.5717          -0.187450           -0.47357         -0.1333739
## 3       -0.2384          -0.100454            0.08255         -0.0756762
## 4       -0.9439           0.189153            0.06313         -0.0297839
## 5       -0.9823          -0.120293           -0.04472          0.1006076
## 6       -0.9166          -0.003547           -0.09153          0.0104581
##   fBodyAccMagmean fBodyAccMagstd fBodyAccMagmeanFreq
## 1        -0.12862        -0.3980             0.19064
## 2        -0.35240        -0.4163            -0.09774
## 3         0.09658        -0.1865             0.11919
## 4        -0.94778        -0.9284             0.23666
## 5        -0.98536        -0.9823             0.28456
## 6        -0.86177        -0.7983             0.08641
##   fBodyBodyAccJerkMagmean fBodyBodyAccJerkMagstd
## 1                -0.05712                -0.1035
## 2                -0.44265                -0.5331
## 3                 0.02622                -0.1041
## 4                -0.98526                -0.9816
## 5                -0.99254                -0.9925
## 6                -0.93330                -0.9218
##   fBodyBodyAccJerkMagmeanFreq fBodyBodyGyroMagmean fBodyBodyGyroMagstd
## 1                     0.09382              -0.1993             -0.3210
## 2                     0.08535              -0.3260             -0.1830
## 3                     0.07649              -0.1857             -0.3984
## 4                     0.35185              -0.9584             -0.9322
## 5                     0.42222              -0.9846             -0.9785
## 6                     0.26639              -0.8622             -0.8243
##   fBodyBodyGyroMagmeanFreq fBodyBodyGyroJerkMagmean
## 1                0.2688444                  -0.3193
## 2               -0.2193034                  -0.6347
## 3                0.3496139                  -0.2820
## 4               -0.0002622                  -0.9898
## 5               -0.0286058                  -0.9948
## 6               -0.1397750                  -0.9424
##   fBodyBodyGyroJerkMagstd fBodyBodyGyroJerkMagmeanFreq
## 1                 -0.3816                       0.1907
## 2                 -0.6939                       0.1143
## 3                 -0.3919                       0.1900
## 4                 -0.9870                       0.1848
## 5                 -0.9947                       0.3345
## 6                 -0.9327                       0.1765
##   angletBodyAccMeangravity angletBodyAccJerkMeangravityMean
## 1                0.0604537                         -0.00793
## 2                0.0960861                         -0.06108
## 3               -0.0026951                          0.08993
## 4                0.0274415                          0.02971
## 5               -0.0002223                          0.02196
## 6                0.0213660                          0.00306
##   angletBodyGyroMeangravityMean angletBodyGyroJerkMeangravityMean
## 1                      0.013059                          -0.01874
## 2                     -0.194700                           0.06568
## 3                      0.063338                          -0.03998
## 4                      0.067698                          -0.06488
## 5                     -0.033794                          -0.02792
## 6                     -0.001667                           0.08444
##   angleXgravityMean angleYgravityMean angleZgravityMean
## 1           -0.7292           0.27695           0.06886
## 2           -0.6472           0.33476           0.07417
## 3           -0.7445           0.26725           0.06500
## 4           -0.5912          -0.06047          -0.21802
## 5           -0.7434           0.27018           0.01225
## 6            0.4267          -0.52034          -0.35241
```

