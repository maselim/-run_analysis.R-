# Codebook
 
## Human Activity Recognition Using Smartphones Data Set 
 This codebook describes the variables, the data, and any transformations or work that are performed to clean the data.
 
## The Original Dataset 
- Original data is available at:   
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   
- Original description of the dataset is available at: 
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Data Set Information
  
The Human Activity Recognition Using Smartphones experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
 
 The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding  windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
 

## Transformation of the original dataset
The transformation process was already detailed in the **README.md** file. In summary, from the original data, I:

1. Join the test and train sets.
2. Keep only the features that refer to the mean and standard deviation, those that contain "mean()" and "std()" (discarding the meanFreq() and angle varaibles)
3. Group by subject and activity type and then summarise the values by the mean.

## Variables in the tidy dataset

### subject
This is the numeric ID that denotes the subject (person) whose activity was measured. Values are from 1 to 30.

### activity
The type of activity. Values are WALKING,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING or LAYING

### features 
All measurement features come from either  the accelerometer (measured in g's [9.80665 m/seg2]) or the gyroscope  (measured in rad/sec) measurements normalized to [-1,1] and averaged for all data in a single subject for each activity type

The different variable names contain information about its meaning by combining all the name parts

1. **t** at the beginning means that is a measurement based on the "time" domain. Measurements taken from the phone were measured at a frequency of 50Hz, meaning 50 discrete measurements per second.

2. **f** at the beginning means that is a measurement based on the "frequency" domain, taken as a Fast Fourier Transform of the time-based signals.

3. **Body** means that signal is based on the body of the subject, one of two components derived from the time based signals on the phone's accelerometer

4. **Gravity** means that signal is based on gravity. Gravity is the second of the two measurement components derived from the phone's accelerometer.

5. **Gyro** means that signal is taken from the gyroscope on the phone.

6. **Jerk** means that is a measurement of sudden movement, based on body acceleration and angular velocity.

7. **Mag** indicates a measurement of the magnitude of the Euclidean norm  of a three-dimensional signal.

8. **X** indicates that measurement was taken along the "X" dimension of the phone, as in a three-dimensional Cartesian coordinate system of X, Y and Z.

9. **Y** indicates that measurement was taken along the "Y" dimension of the phone, as in a three-dimensional Cartesian coordinate system of X, Y and Z.

10. **Z** indicates that measurement was taken along the "Z" dimension of the phone, as in a three-dimensional Cartesian coordinate system of X, Y and Z.

11. **mean()** indicates that the measurement is a mean in the original dataset

12. **std()** indicates that the measurement is a standard deviation in the original dataset.
