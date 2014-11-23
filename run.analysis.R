##run_analysis.R
##Package Install
library(dplyr)
library(plyr)

        ## Folder Locations
        f_MAIN <- c("C:/Users/iAmCrafty/Documents/R/UCI HAR Dataset/")
        f_test <- c("C:/Users/iAmCrafty/Documents/R/UCI HAR Dataset/test")
        f_train <- c("C:/Users/iAmCrafty/Documents/R/UCI HAR Dataset/train")
        ## Read Label Files
        act <- read.table(paste(f_MAIN, "activity_labels.txt", sep = "/"))
        tmp_features <- read.table(paste(f_MAIN, "features.txt", sep = "/"))
        features <- select(tmp_features, -V1)
        ## Features to char list (Col Names for Data Sets)
        FEAT <- as.character(features[1:561,1,1])
        ## Test Data
        test_act <- read.table(paste(f_test, "y_test.txt", sep = "/"))
        test_sub <- read.table(paste(f_test, "subject_test.txt", sep = "/"))
        test_set <- read.table(paste(f_test, "x_test.txt", sep = "/"))
        ## Train Data
        train_act <- read.table(paste(f_train, "y_train.txt", sep = "/"))
        train_sub <- read.table(paste(f_train, "subject_train.txt", sep = "/"))
        train_set <- read.table(paste(f_train, "x_train.txt", sep = "/"))
        ## Rename Columns
        colnames(act) <- c("Code", "Activity")
        colnames(test_act) <- c("Code")
        colnames(test_sub) <- c("Subject")
        colnames(train_act) <- c("Code")
        colnames(train_sub) <- c("Subject")
        ## Combine Features with Activity Data Sets
        colnames(test_set) <- c(1:561)
        colnames(train_set) <- c(1:561)
        ## Coerce activity sets into tbl_df for manipulation
        df_act <- tbl_df(act)
        df_test_act <- tbl_df(test_act)
        df_test_set <- tbl_df(test_set)
        df_train_act <- tbl_df(train_act)
        df_train_set <- tbl_df(train_set)
        ## Comibine Activity Labels with test and train activities
        test_ACT <- join(df_test_act, df_act)
        train_ACT <- join(df_train_act, df_act)
        ## Combine Subjects with Activities
        TEST_ACT <- cbind(test_sub, test_ACT)
        TRAIN_ACT <- cbind(train_sub, train_ACT)
        ## Merge Activity Sets: (Training & Test).
        FULL_ACT <- rbind(TEST_ACT, TRAIN_ACT)
        
        ## Extract only the "mean" and "std" for each measurement. 
        mean_pos <- as.numeric(grep("mean", features[,1], ignore.case = TRUE))
        stdev_pos <- as.numeric(grep("std", features[,1], ignore.case = TRUE))
        ## Create one list of Column Positions
        tmp_pos <- sort(append(mean_pos, stdev_pos))
        col_pos <- tmp_pos
        ## Identitfy Column Names
        col_names <- FEAT[col_pos]
        ## Extract relevant Columns
        TEST_SET <- select(test_set, col_pos)
        TRAIN_SET <- select(train_set, col_pos)
        ## Combine Extracted Test and Train Data Sets
        FULL_SET <- rbind(TEST_SET, TRAIN_SET)
        ## Apply Column Names
        colnames(FULL_SET) <- c(col_names)
        ## Master Extract of Relevant Columns for all observations
        EXTRACT <- cbind(FULL_ACT, FULL_SET)
        ## Arrange by Subject and Activity
        SORT <- arrange(EXTRACT, Subject, Code)
        ## Coerce to data Table
        DT_EXTRACT <- data.table(SORT)

        ##Create a second, independent tidy data set with Mean() of each variable
        ## Find Mean of each Variable by Subject, then Activity
        FINAL <- DT_EXTRACT[,lapply(.SD, mean), by = list(Subject, Activity)]

        ## Write File.txt to R Folder
        write.table(FINAL, file = "~/R/run.analysis.txt", row.name=FALSE)

        
