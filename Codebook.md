# Coursera Getting and Cleaning Data Course Project Codebook
Kolachalam Manish Sharma  
The variables in the "Tidy" dataset are essentially the mean and standard deviation (specified as "mean" or "std" in the data labels) of various decompositions of the triaxial (X-Y-Z) values of the accelerometer and gyroscope from the Samsung Galaxy S II strapped on to 30 participants and grouped according to the activity they were performing at that time. The accelerometer and gyroscope signals contain in their labels "Acc" and "Gyro" respectively and the main grouping of these signals is whether they are signals pertaining to body movement or gravity (prefix "Body" and "Gravity" in the labels respectively), or whether they are signals in the time or fourier transform domain (prefixes "t" or "f" respectively . The signals have also been decomposed along the axes and this is also indicated in the data labels. I feel it is redundant to describe every single measurement the researchers have made and I have appended their description in the last section of this document. However, as the data labels have been processed to be usable in R, please find in the table below the original data labels (oldfeatures) and their corresponding data labels in the "Tidy" dataset(renameFinal).


```
##                             oldfeatures                       renameFinal
## 1                              Activity                          Activity
## 2                               Subject                           Subject
## 3                     tBodyAcc-mean()-X                     tBodyAccmeanX
## 4                     tBodyAcc-mean()-Y                     tBodyAccmeanY
## 5                     tBodyAcc-mean()-Z                     tBodyAccmeanZ
## 6                      tBodyAcc-std()-X                      tBodyAccstdX
## 7                      tBodyAcc-std()-Y                      tBodyAccstdY
## 8                      tBodyAcc-std()-Z                      tBodyAccstdZ
## 9                  tGravityAcc-mean()-X                  tGravityAccmeanX
## 10                 tGravityAcc-mean()-Y                  tGravityAccmeanY
## 11                 tGravityAcc-mean()-Z                  tGravityAccmeanZ
## 12                  tGravityAcc-std()-X                   tGravityAccstdX
## 13                  tGravityAcc-std()-Y                   tGravityAccstdY
## 14                  tGravityAcc-std()-Z                   tGravityAccstdZ
## 15                tBodyAccJerk-mean()-X                 tBodyAccJerkmeanX
## 16                tBodyAccJerk-mean()-Y                 tBodyAccJerkmeanY
## 17                tBodyAccJerk-mean()-Z                 tBodyAccJerkmeanZ
## 18                 tBodyAccJerk-std()-X                  tBodyAccJerkstdX
## 19                 tBodyAccJerk-std()-Y                  tBodyAccJerkstdY
## 20                 tBodyAccJerk-std()-Z                  tBodyAccJerkstdZ
## 21                   tBodyGyro-mean()-X                    tBodyGyromeanX
## 22                   tBodyGyro-mean()-Y                    tBodyGyromeanY
## 23                   tBodyGyro-mean()-Z                    tBodyGyromeanZ
## 24                    tBodyGyro-std()-X                     tBodyGyrostdX
## 25                    tBodyGyro-std()-Y                     tBodyGyrostdY
## 26                    tBodyGyro-std()-Z                     tBodyGyrostdZ
## 27               tBodyGyroJerk-mean()-X                tBodyGyroJerkmeanX
## 28               tBodyGyroJerk-mean()-Y                tBodyGyroJerkmeanY
## 29               tBodyGyroJerk-mean()-Z                tBodyGyroJerkmeanZ
## 30                tBodyGyroJerk-std()-X                 tBodyGyroJerkstdX
## 31                tBodyGyroJerk-std()-Y                 tBodyGyroJerkstdY
## 32                tBodyGyroJerk-std()-Z                 tBodyGyroJerkstdZ
## 33                   tBodyAccMag-mean()                   tBodyAccMagmean
## 34                    tBodyAccMag-std()                    tBodyAccMagstd
## 35                tGravityAccMag-mean()                tGravityAccMagmean
## 36                 tGravityAccMag-std()                 tGravityAccMagstd
## 37               tBodyAccJerkMag-mean()               tBodyAccJerkMagmean
## 38                tBodyAccJerkMag-std()                tBodyAccJerkMagstd
## 39                  tBodyGyroMag-mean()                  tBodyGyroMagmean
## 40                   tBodyGyroMag-std()                   tBodyGyroMagstd
## 41              tBodyGyroJerkMag-mean()              tBodyGyroJerkMagmean
## 42               tBodyGyroJerkMag-std()               tBodyGyroJerkMagstd
## 43                    fBodyAcc-mean()-X                     fBodyAccmeanX
## 44                    fBodyAcc-mean()-Y                     fBodyAccmeanY
## 45                    fBodyAcc-mean()-Z                     fBodyAccmeanZ
## 46                     fBodyAcc-std()-X                      fBodyAccstdX
## 47                     fBodyAcc-std()-Y                      fBodyAccstdY
## 48                     fBodyAcc-std()-Z                      fBodyAccstdZ
## 49                fBodyAcc-meanFreq()-X                 fBodyAccmeanFreqX
## 50                fBodyAcc-meanFreq()-Y                 fBodyAccmeanFreqY
## 51                fBodyAcc-meanFreq()-Z                 fBodyAccmeanFreqZ
## 52                fBodyAccJerk-mean()-X                 fBodyAccJerkmeanX
## 53                fBodyAccJerk-mean()-Y                 fBodyAccJerkmeanY
## 54                fBodyAccJerk-mean()-Z                 fBodyAccJerkmeanZ
## 55                 fBodyAccJerk-std()-X                  fBodyAccJerkstdX
## 56                 fBodyAccJerk-std()-Y                  fBodyAccJerkstdY
## 57                 fBodyAccJerk-std()-Z                  fBodyAccJerkstdZ
## 58            fBodyAccJerk-meanFreq()-X             fBodyAccJerkmeanFreqX
## 59            fBodyAccJerk-meanFreq()-Y             fBodyAccJerkmeanFreqY
## 60            fBodyAccJerk-meanFreq()-Z             fBodyAccJerkmeanFreqZ
## 61                   fBodyGyro-mean()-X                    fBodyGyromeanX
## 62                   fBodyGyro-mean()-Y                    fBodyGyromeanY
## 63                   fBodyGyro-mean()-Z                    fBodyGyromeanZ
## 64                    fBodyGyro-std()-X                     fBodyGyrostdX
## 65                    fBodyGyro-std()-Y                     fBodyGyrostdY
## 66                    fBodyGyro-std()-Z                     fBodyGyrostdZ
## 67               fBodyGyro-meanFreq()-X                fBodyGyromeanFreqX
## 68               fBodyGyro-meanFreq()-Y                fBodyGyromeanFreqY
## 69               fBodyGyro-meanFreq()-Z                fBodyGyromeanFreqZ
## 70                   fBodyAccMag-mean()                   fBodyAccMagmean
## 71                    fBodyAccMag-std()                    fBodyAccMagstd
## 72               fBodyAccMag-meanFreq()               fBodyAccMagmeanFreq
## 73           fBodyBodyAccJerkMag-mean()           fBodyBodyAccJerkMagmean
## 74            fBodyBodyAccJerkMag-std()            fBodyBodyAccJerkMagstd
## 75       fBodyBodyAccJerkMag-meanFreq()       fBodyBodyAccJerkMagmeanFreq
## 76              fBodyBodyGyroMag-mean()              fBodyBodyGyroMagmean
## 77               fBodyBodyGyroMag-std()               fBodyBodyGyroMagstd
## 78          fBodyBodyGyroMag-meanFreq()          fBodyBodyGyroMagmeanFreq
## 79          fBodyBodyGyroJerkMag-mean()          fBodyBodyGyroJerkMagmean
## 80           fBodyBodyGyroJerkMag-std()           fBodyBodyGyroJerkMagstd
## 81      fBodyBodyGyroJerkMag-meanFreq()      fBodyBodyGyroJerkMagmeanFreq
## 82          angle(tBodyAccMean,gravity)          angletBodyAccMeangravity
## 83 angle(tBodyAccJerkMean),gravityMean)  angletBodyAccJerkMeangravityMean
## 84     angle(tBodyGyroMean,gravityMean)     angletBodyGyroMeangravityMean
## 85 angle(tBodyGyroJerkMean,gravityMean) angletBodyGyroJerkMeangravityMean
## 86                 angle(X,gravityMean)                 angleXgravityMean
## 87                 angle(Y,gravityMean)                 angleYgravityMean
## 88                 angle(Z,gravityMean)                 angleZgravityMean
```


Feature Selection
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag


The set of variables that were estimated from these signals are:


mean(): Mean value

std(): Standard deviation

mad(): Median absolute deviation 

max(): Largest value in array

min(): Smallest value in array

sma(): Signal magnitude area

energy(): Energy measure. Sum of the squares divided by the number of values. 

iqr(): Interquartile range 

entropy(): Signal entropy

arCoeff(): Autorregresion coefficients with Burg order equal to 4

correlation(): correlation coefficient between two signals

maxInds(): index of the frequency component with largest magnitude

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

skewness(): skewness of the frequency domain signal 

kurtosis(): kurtosis of the frequency domain signal 

bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.

angle(): Angle between to vectors.


Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean


tBodyAccMean

tBodyAccJerkMean

tBodyGyroMean

tBodyGyroJerkMean
