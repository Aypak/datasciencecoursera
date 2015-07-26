Here is my solution for the getting and cleaning data course project

Assumptions:
In my script I assume that the entire dataset has already been downloaded and unzipped, and is contained in a folder called 'UCI HAR Dataset' in the working directory with no alterations to any of the files or folder structure.
I also assume that the packages plyr, dplyr, and tidyr are already installed and loaded in the environment

The script performs analysis as follows:
First all the necessary files are read into R and stored as variables in the environment. In the test data the subject and activity dataframes are bound together as columns and appropriately renamed, and columns in the obsevation data that contain measurements about the mean() and std()(Standard deviation) are selected and these columns are bound with the subject and activity. This process is repeated for the train data, afterwhich the two arising dataframes are combined to form a large dataframe. The activity column is then converted to a factor and the labels are attached. The dataframe is then written to a text file.  

