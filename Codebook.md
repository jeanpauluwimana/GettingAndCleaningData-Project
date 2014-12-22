### Data collection
Raw data was obtained from UCI Machine Learning Repository. And this data was obtained using an experiment conducted through
smartphone users.

### Signals
The 3 types of time domain signalsfrom accelerometer and gyroscope were captured at a constant rate of 50 HZ and were later filtered 
to remove the noise.

Variables that were used from these signals:
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values.
* iqr(): Interquartile range
* entropy(): Signal entropy
* arCoeff(): Autoregression coefficients with Burg order equal to 4
* correlation(): Correlation coefficient between two signals
* maxInds(): Index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): Skewness of the frequency domain signal
* kurtosis(): Kurtosis of the frequency domain signal
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between some vectors.

###Data manipulation
The raw data was processed using the following script: run_analysis.R

###Data merging
All the data related to test was merged to the traning data. Namely, x_train.txt, x_test.txt, and combined with subject data, subject_train.txt, subject_test.txt and activity ID - y_train.txt, y_test.txt. The above data was all merged to obtain one dataset. 

###Getting the mean and standard deviation variables

With the merged dataset, I extracted variables with the word 'mean' and those with the word 'std'

###Creating a Tidy dataset

From the dataset created in the previous step, the numeric variables were averaged for each activity and each subject
