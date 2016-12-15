## Script that processes accelerometer activity data from UCI
##
## Merges training and data sets into one data set and labels the activities
## Creates a second data set that averages each variable
## for the activity and subject
## Assumes script is run in directory where the test and training
## data are located in subfolders test and train

# Load in definitions of columns and activities

column_labels <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

# Create new column names

new_column_names <- c("Body_Acceleration", "Body_Acceleration_StdDev", 
  "Gravity_Acceleration", "Gravity_Acceleration_StdDev",
  "Body_Jerk", "Body_Jerk_StdDev", "Gyro_Acceleration",
  "Gyro_Acceleration_StdDev", "Gyro_Jerk", "Gyro_Jerk_StdDev")

# Function to load, process, and merge the data from a given directory

load_data <- function(directory) {
     
     path <- paste0("./", directory, "/")
     
     # Load activities, subjects, and accelerometer data
     activities <- read.table(paste0(path, "y_", directory,".txt"), col.names = "Activity")
     subjects <- read.table(paste0(path, "subject_", directory,".txt"), col.names = "Subject")
     acc_data <- read.table(paste0(path, "X_", directory,".txt"), col.names = column_labels[,2])
     
     # Convert numeric activity codes to corresponding factor strings
     activities$Activity <- sapply(activities$Activity, function(x){activity_labels[x,2]})
     
     # Subset accelerometer data to only include means and standard deviations
     # of vector magnitudes in the time domain
     acc_data <- acc_data[,grep("^t.*mean..$|^t.*std..$", names(acc_data))]
     
     # Rename column names to be more readable
     
     names(acc_data) <- new_column_names
     
     # Merge together subject, activity, and accelerometer data and return
     
     cbind(subjects, activities, acc_data)
}



# Load test and training data from files and merge

clean_data <- rbind(load_data("test"), load_data("train"))

# Find mean for activity of each subject

measurement_means <- aggregate(clean_data[,-c(1,2)], by = list(clean_data$Subject, clean_data$Activity), mean)

# Change column names back to Subject and Activity

names(measurement_means)[1:2] <- c("Subject", "Activity")

# Write data table to a file

write.table(measurement_means, file="data_summary.txt", row.name=FALSE)

