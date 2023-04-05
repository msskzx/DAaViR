library(data.table)
library(magrittr)

# Section 1 Reading and Cleaning up Data
data_folder_name <- "~/Documents/TUM/R/DAaViR/extdata"
users_dt <- fread(file.path(data_folder_name,"BX-Users.csv"))
books_dt <- fread(file.path(data_folder_name,"BX-Books.csv"))
ratings_dt <- fread(file.path(data_folder_name, "BX-Book-Ratings.csv"))

# Change the type of Age to be numeric
users_dt[, Age := as.numeric(Age)]

# Replace all the - in column names by underscores _ in all three data tables.
# For example, Book-Title should be renamed to Book_Title. 
# Hint: You can use the function gsub() that replaces pattern in a character
# string by a defined replacement.
colnames(users_dt) <- gsub("-", "_", colnames(users_dt))
colnames(books_dt) <- gsub("-", "_", colnames(books_dt))
colnames(ratings_dt) <- gsub("-", "_", colnames(ratings_dt))

# 7. Delete the columns Image_URL_S, Image_URL_M and Image_URL_L in the table books_dt.
books_dt[, c("Image_URL_S", "Image_URL_M", "Image_URL_L") := NULL]

# 8. Create a table book_dt_2 that contains all the books published between
# 1900 and 2019 (inclusive) from the table books_dt.
books_dt_2 = books_dt[Year_Of_Publication >= 1900 & Year_Of_Publication <= 2019]

# Section 02 - Data Exploration
# 1. How many different authors are included in the table books_dt?
unique_authors <- uniqueN(books_dt, by="Book_Author")

# 2. How many different authors are included for each year of publication
# between 2000 and 2010 (inclusive) in books_dt?
unique_authors_2 <- books_dt[Year_Of_Publication >= 2000 & Year_Of_Publication <= 2010, uniqueN(Book_Author), by=Year_Of_Publication]

# 3. In how many observations is the age information missing in the ratings table users_dt?
missing_age <- users_dt[is.na(Age), .N]
missing_age

# 4. What is the maximum rating value in the ratings table?
ratings_dt[,max(Book_Rating, na.rm=TRUE)]

# 5. What is the most common rating value larger than 0?
ratings_dt[Book_Rating !=0, .N, by = Book_Rating][N==max(N)]

# 6. Which are the book identifiers (ISBN) with the highest ratings?
ratings_dt[Book_Rating == max(Book_Rating, na.rm=TRUE), "ISBN"] %>% head

# 7. Reorder the ratings table according to the rating value of each book in descending order. Hint: order()
setorder(ratings_dt, -Book_Rating)

# Section 03 - Manipulating data tables
# 1. Add a new column called High_Rating to the data table ratings_dt. The column 
# has an integer 1 for all observations with a rating value higher than 7.
# Hint: ifelse()
ratings_dt[, High_Rating := ifelse(Book_Rating>7, 1, 0)]

# 2. How many observations are considered to be a high ranking?
# What is the proportion of high ranked observations among all observations?
ratings_dt[, sum(High_Rating)]
ratings_dt[, sum(High_Rating)/.N]

# 3. Which users did not give any rating to any book?
# Filter these users out from users_dt. 
# Hint: There’s no need to merge users_dt with ratings_dt,
# we are simply interested in the users that are not in ratings_dt.
users_who_rated <- ratings_dt[,User_ID]
users_dt[! (User_ID %in%users_who_rated)]

# 4. What is the most common age of users who rated at least one book?
users_dt[User_ID %in% users_who_rated & !is.na(Age), .N, by=Age][N==max(N)]

# 5. On average, how many books did a user rate?
ratings_dt[, .N, by=User_ID][, mean(N, na.rm=TRUE)]

# 10. How many ratings has each author from the previous exercise 9?
# What is their max and average ranking?
ratings_dt[, .(Mean=mean(Book_Rating), Max=max(Book_Rating), Ratings=.N), by=Book_Author]
