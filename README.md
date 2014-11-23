GetData_Project
===============

JH - Data Science : Get Data Project

1. Install required packages
2. Define Folder Locations
3. Read Label Files
4. Coerce Features to char list for later use in Identifying Column Names for Data Sets
5. Read in Test Data
6. Read in Train Data
7. Rename Columns so Join works correctly
8. Join tables to combine Feature Labels with Activity Data Sets
9. Coerce activity sets into tbl_df for manipulation
10. Comibine Activity Labels with test and train activities
11. Combine Subjects ID with Activities Sets
12. Merge Activity Sets: (Training & Test).
13. Determine which Features(columns) are to be extracted based on "mean" and "std" in Variable Name
14. Create sorted list of Features Column Positions
15. Create Subset of Feature Names to Identitfy Column Names
16. Extract relevant Feature Columns from both Data Sets
17. Combine Extracted Test and Train Data Sets
18. Apply descriptive Column Names to new data set
19. Create Master Data Set of Extracted Relevant Columns for Actvities and Data Sets
20. Arrange Data by Subject and Activity
21. Coerce to Data Table for use of lapply()
22. Using the second, independent tidy data set, Calc Mean() of each variable grouped by Subject, then Activity
23. Write run.analysis(.txt) & codebook to R Folder
