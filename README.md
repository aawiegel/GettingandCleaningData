# GettingandCleaningData

Contains a script to analyze data from the UCI Machine Learning repository on physical activity as measured by smart phones. The data is publically available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

# Files included

run_analysis.R

Script to analyze data and write to a new file. The script assumes that the raw data from UCI is available in its directory and the "test" and "train" subdirectories. Means are calculated for the mean and standard deviation for the magnitudes of several vectors.

data_summary.txt

Output from the script that includes means of the magnitudes of the accelerometer data for different subjects and activities. Use the command read.table("data_summary.txt") to load into an R console.
