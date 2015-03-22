# Tidy Data Analysis of "Human Activity Recognition Using Smartphones"

This data set is a tidy subset of the ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). (Downloadable [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) )

### Reference
We acknowledged our use of the UCI HAR dataset:

> [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

> This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

> Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

### The dataset includes the following files
* [**Tidy-UCI-HAR-Dataset.txt**:] (https://github.com/libraguysgp/Getting-and-Cleaning-Data-Course-Assignment/Tidy-UCI-HAR-Dataset.txt) 
    * The tidy subset of the UCI HAR data set. Provided for convenience. It can by reproduced exactly by running the run_analysis.R script.
* [**CodeBook.md**:] (https://github.com/libraguysgp/Getting-and-Cleaning-Data-Course-Assignment/CodeBook.md)
    * Information about all columns in the data set including portions of the original code book and a full description of our transformation and summarizing of the original data set to produce our tidy data set.
* [**README.md**:] (https://github.com/libraguysgp/Getting-and-Cleaning-Data-Course-Assignment/README.md)
    * This document which explains what the analysis file does. 
* [**run_analysis.R**:] (https://github.com/libraguysgp/Getting-and-Cleaning-Data-Course-Assignment/run_analysis.R) 
    * Source code in R for our transformation of the UCI HAR data set into our tidy data set.

### The instruction list - how the script works
* The only input to the **run_analysis.R** script is the UCI HAR data set which must be in the working directory. The script requires no parameters.
* The output from the script is the tidy data set.
* Although all of tasks required for this analysis are fully scripted in R and no manual steps are required (and thus the script itself *is* the instruction list), here is what the script does:
      * Recombine the UCI data set in memory
      * Load the subject_\*.txt, y_\*.txt, X_\*.txt files.
      * Column bind these three sets together.
    	* Name the columns using the values loaded from features.txt.
    	* Factor the activities column and name the factors using values loaded from activity_labels.txt
    	* Repeat these steps for both the train and test data sets.
    	* Row bind the two data sets.
    	* We now have the original data set loaded.
      * Tidy up the column names
      * Rename all column names using these rules
        	* Replace prefixes 't' and 'f' with 'time' and 'frequency' respectively.
        	* Remove illegal characters and hyphens.
          * Remove duplicate phrases in variable names. eg. 'BodyBody' becomes 'Body'
          * Convert names to lower case
        	* Prefix the column name with 'mean' (See the codebook's 'Summarizing the data' section for justification)
      * Remove some columns
    	* Remove all columns where the original name does not contain -std or -mean including those containing "meanFreq" and those beginning with "angle." 
    	* Except we also retain the subject and activity columns.
    	* See codebook for justifications.
      * Summarize the data
    	* Group by subject and activity
      * Calculate the mean for each metric.
      * Output
    	  * Output the data.frame to disk
      * Note
        * The script also sets the working directory and downloads the original data set if it is not already present.

### Reading the data
Read the tidy data set in R with the following command. First ensure the working directory contains the tidyDataSet.txt file. (On Windows, you may need to adjust the path slightly.)

```R
read.table('./Tidy-UCI-HAR-Dataset.txt', header = TRUE)
```
