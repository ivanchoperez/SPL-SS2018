# Change the following path to the desired one in your computer
setwd("~/Ivan/MSc Statistics/SPL/Project/Code 16-07-2018/Data")


# The code is divided in the following sections:
#   Section 0: Packages installation (codeline 14)
#   Section 1: Data loading (codeline 32)
#   Section 2: Text cleaning (codeline 83)
#   Section 3: Sentiment Analysis (codeline 218)
#   Section 4: Interactive Map (codeline 401)
#   Section 5: Shiny app (codeline 490)

# -------------------------------
# Section 0: Package Installation
# -------------------------------

# List of librries to be used
lib <- list("NLP", "tm", "syuzhet", "sentimentr", "ggplot2", "dplyr",
          "shiny", "shinydashboard", "ggiraph", "wordcloud2", "plyr")

# Installing or calling the libraries
invisible(lapply(lib, function(x){
  result <- library(x, logical.return=T, character.only =T)
  if(result == F) install.packages(x)
  library(x, character.only =T)
  print(paste0(x, " loaded"))
}))

rm(lib)

# -----------------------
# Section 1: Data loading
# -----------------------

# You can run the whole section (it takes less than a second)

countries_2012 <- c("austria", "belgium", "bulgaria", "cyprus",
                    "czech republic", "denmark", "estonia", "finland", "france",
                    "germany", "hungary", "ireland", "italy", "latvia", "lithuania",
                    "luxembourg", "malta", "netherlands", "poland", "portugal",
                    "romania", "slovakia", "slovenia", "spain", "sweden", "uk")

countries_2015 <- c("austria", "belgium", "bulgaria", "cyprus",
                    "czech republic", "denmark", "estonia", "finland", "france",
                    "germany", "hungary", "ireland", "italy", "latvia", "lithuania",
                    "luxembourg", "malta", "netherlands", "poland", "portugal",
                    "romania", "slovakia", "slovenia", "spain", "sweden", "uk")

countries_2018 <- c("austria", "belgium", "bulgaria", "cyprus",
                "czech republic", "denmark", "estonia", "finland", "france",
                "germany", "hungary", "ireland", "italy", "latvia", "lithuania",
                "luxembourg", "malta", "netherlands", "poland", "portugal",
                "romania", "slovakia", "slovenia", "spain", "sweden", "uk")

list_2012 = list()
for (i in 1:length(countries_2012)){
  # Read executive summaries from 2012
  list_2012[[countries_2012[i]]] <- paste(
    readLines(paste0(countries_2012[i],"_","2012",".txt")), 
                                          collapse = " ")
}

list_2015 = list()
for (i in 1:length(countries_2015)){
  # Read executive summaries from 2015
  list_2015[[countries_2015[i]]] <- paste(
    readLines(paste0(countries_2015[i],"_","2015",".txt")),
                                           collapse = " ")
}

list_2018 = list()
for (i in 1:length(countries_2018)){
  # Read executive summaries from 2018
  list_2018[[countries_2018[i]]] <- paste(
    readLines(paste0(countries_2018[i],"_","2018",".txt"))
                                          , collapse = " ")
}

# remove temporal objects
rm(countries_2012, countries_2015, countries_2018, i)

# ------------------------
# Section 2: Text Cleaning
# ------------------------

# You can run the whole section (it takes about a second)

# The following loop will create a list with cleaned text for 2012
list_2012_cleaned = list()
for (i in 1:length(list_2012)){
  # Remove symbols (commas, dots, etc):
  list_2012_cleaned[[i]] <- gsub(pattern = "\\W", replace=" ", list_2012[[i]])
  # Remove numbers:
  list_2012_cleaned[[i]] <- gsub(pattern = "\\d", replace=" ", list_2012_cleaned[[i]])
  # Lower case for every word:
  list_2012_cleaned[[i]] <- tolower(list_2012_cleaned[[i]])
  # Remove stopwords:
  list_2012_cleaned[[i]] <- removeWords(list_2012_cleaned[[i]], stopwords())
  # Remove country Name:
  list_2012_cleaned[[i]] <- removeWords(list_2012_cleaned[[i]], names(list_2012)[i])
  # Remove word "also":
  list_2012_cleaned[[i]] <- removeWords(list_2012_cleaned[[i]], "also")
  # Remove single letter words:
  list_2012_cleaned[[i]] <- gsub(pattern = "\\b[a-z]\\b{1}", replace=" ", list_2012_cleaned[[i]])
  # Remove empty spaces between words:
  list_2012_cleaned[[i]] <- stripWhitespace(list_2012_cleaned[[i]])
  # Separate text into separate words, each word is an observation:
  list_2012_cleaned[[i]] <- strsplit(list_2012_cleaned[[i]], "\\s+")[[1]]
  # Name the contries of the cleaned list according to initial raw data:
  names(list_2012_cleaned)[i] <- names(list_2012)[i] 
}

# The following loop is the same as previous but text is not divided
# into separate words, instead it is treated as a single observation
# as some disctionaries require the whole text
list_2012_cleaned_full = list()
for (i in 1:length(list_2012)){
  list_2012_cleaned_full[[i]] <- gsub(pattern = "\\d", replace=" ", list_2012[[i]])
  list_2012_cleaned_full[[i]] <- tolower(list_2012_cleaned_full[[i]])
  list_2012_cleaned_full[[i]] <- removeWords(list_2012_cleaned_full[[i]], stopwords())
  list_2012_cleaned_full[[i]] <- removeWords(list_2012_cleaned_full[[i]], names(list_2012)[i])
  list_2012_cleaned_full[[i]] <- removeWords(list_2012_cleaned_full[[i]], "also")
  list_2012_cleaned_full[[i]] <- gsub(pattern = "\\b[a-z]\\b{1}", replace=" ", list_2012_cleaned_full[[i]])
  list_2012_cleaned_full[[i]] <- stripWhitespace(list_2012_cleaned_full[[i]])
  #list_2012_cleaned_full[[i]] <- strsplit(list_2012_cleaned_full[[i]], "\\s+")[[1]]
  names(list_2012_cleaned_full)[i] <- names(list_2012)[i] 
}


# The following loop will create a list with cleaned text for 2015
list_2015_cleaned = list()
for (i in 1:length(list_2015)){
  # Remove symbols (commas, dots, etc):
  list_2015_cleaned[[i]] <- gsub(pattern = "\\W", replace=" ", list_2015[[i]])
  # Remove numbers:
  list_2015_cleaned[[i]] <- gsub(pattern = "\\d", replace=" ", list_2015_cleaned[[i]])
  # Lower case for every word:
  list_2015_cleaned[[i]] <- tolower(list_2015_cleaned[[i]])
  # Remove stopwords:
  list_2015_cleaned[[i]] <- removeWords(list_2015_cleaned[[i]], stopwords())
  # Remove country Name:
  list_2015_cleaned[[i]] <- removeWords(list_2015_cleaned[[i]], names(list_2015)[i])
  # Remove word "also":
  list_2015_cleaned[[i]] <- removeWords(list_2015_cleaned[[i]], "also")
  # Remove single letter words:
  list_2015_cleaned[[i]] <- gsub(pattern = "\\b[a-z]\\b{1}", replace=" ", list_2015_cleaned[[i]])
  # Remove empty spaces between words:
  list_2015_cleaned[[i]] <- stripWhitespace(list_2015_cleaned[[i]])
  # Separate text into separate words, each word is an observation:
  list_2015_cleaned[[i]] <- strsplit(list_2015_cleaned[[i]], "\\s+")[[1]]
  # Name the contries of the cleaned list according to initial raw data:
  names(list_2015_cleaned)[i] <- names(list_2015)[i] 
}

# The following loop is the same as previous but text is not divided
# into separate words, instead it is treated as a single observation
# as some disctionaries require the whole text
list_2015_cleaned_full = list()
for (i in 1:length(list_2015)){
  list_2015_cleaned_full[[i]] <- gsub(pattern = "\\d", replace=" ", list_2015[[i]])
  list_2015_cleaned_full[[i]] <- tolower(list_2015_cleaned_full[[i]])
  list_2015_cleaned_full[[i]] <- removeWords(list_2015_cleaned_full[[i]], stopwords())
  list_2015_cleaned_full[[i]] <- removeWords(list_2015_cleaned_full[[i]], names(list_2015)[i])
  list_2015_cleaned_full[[i]] <- removeWords(list_2015_cleaned_full[[i]], "also")
  list_2015_cleaned_full[[i]] <- gsub(pattern = "\\b[a-z]\\b{1}", replace=" ", list_2015_cleaned_full[[i]])
  list_2015_cleaned_full[[i]] <- stripWhitespace(list_2015_cleaned_full[[i]])
  #list_2015_cleaned_full[[i]] <- strsplit(list_2015_cleaned_full[[i]], "\\s+")[[1]]
  names(list_2015_cleaned_full)[i] <- names(list_2015)[i] 
}


# The following loop will create a list with cleaned text for 2018
list_2018_cleaned = list()
for (i in 1:length(list_2018)){
  # Remove symbols (commas, dots, etc):
  list_2018_cleaned[[i]] <- gsub(pattern = "\\W", replace=" ", list_2018[[i]])
  # Remove numbers:
  list_2018_cleaned[[i]] <- gsub(pattern = "\\d", replace=" ", list_2018_cleaned[[i]])
  # Lower case for every word:
  list_2018_cleaned[[i]] <- tolower(list_2018_cleaned[[i]])
  # Remove stopwords:
  list_2018_cleaned[[i]] <- removeWords(list_2018_cleaned[[i]], stopwords())
  # Remove country Name:
  list_2018_cleaned[[i]] <- removeWords(list_2018_cleaned[[i]], names(list_2018)[i])
  # Remove word "also":
  list_2018_cleaned[[i]] <- removeWords(list_2018_cleaned[[i]], "also")  
  # Remove single letter words:
  list_2018_cleaned[[i]] <- gsub(pattern = "\\b[a-z]\\b{1}", replace=" ", list_2018_cleaned[[i]])
  # Remove empty spaces between words:
  list_2018_cleaned[[i]] <- stripWhitespace(list_2018_cleaned[[i]])
  # Separate text into separate words, each word is an observation:
  list_2018_cleaned[[i]] <- strsplit(list_2018_cleaned[[i]], "\\s+")[[1]]
  # Name the contries of the cleaned list according to initial raw data:
  names(list_2018_cleaned)[i] <- names(list_2018)[i] 
}


# The following loop is the same as previous but text is not divided
# into separate words, instead it is treated as a single observation
# as some disctionaries require the whole text
list_2018_cleaned_full = list()
for (i in 1:length(list_2018)){
  list_2018_cleaned_full[[i]] <- gsub(pattern = "\\d", replace=" ", list_2018[[i]])
  list_2018_cleaned_full[[i]] <- tolower(list_2018_cleaned_full[[i]])
  list_2018_cleaned_full[[i]] <- removeWords(list_2018_cleaned_full[[i]], stopwords())
  list_2018_cleaned_full[[i]] <- removeWords(list_2018_cleaned_full[[i]], names(list_2018)[i])
  list_2018_cleaned_full[[i]] <- removeWords(list_2018_cleaned_full[[i]], "also")  
  list_2018_cleaned_full[[i]] <- gsub(pattern = "\\b[a-z]\\b{1}", replace=" ", list_2018_cleaned_full[[i]])
  list_2018_cleaned_full[[i]] <- stripWhitespace(list_2018_cleaned_full[[i]])
  #list_2018_cleaned_full[[i]] <- strsplit(list_2018_cleaned_full[[i]], "\\s+")[[1]]
  names(list_2018_cleaned_full)[i] <- names(list_2018)[i] 
}

# remove temporal objects
rm(i)

# -----------------------------
# Section 3: Sentiment Analysis
# -----------------------------

# Running the Whole section will take about 20 mins (8GB Ram).
# You can skip the process and upload the data directly by going to line 374 instead

# 1) NRC dictionary 
# for more details: http://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm)

NRC_2012 = list()
for (i in 1:length(list_2012_cleaned)){
  # find the NRC sentiments of every country (creates a data frame):
  NRC <- get_nrc_sentiment(list_2012_cleaned[[i]])
  # sum every column of NRC, excluding columns 9 and 10 (positive and negative),
  # and then compute the maximum of the columnsums, then look for the name of that column,
  # in other words: return the sentiment with the highest colSums:
  NRC_2012[[i]] <- colnames(NRC[,c(-9,-10)])[which.max(colSums(NRC[,c(-9,-10)]))]
  # Use the corresponding country name: 
  names(NRC_2012)[i] <- names(list_2012)[i]
  # Print sentiment just to verify the loop is working:
  print(NRC_2012[[i]])
  }

NRC_2015 = list()
for (i in 1:length(list_2015_cleaned)){
  # find the NRC sentiments of every country (creates a data frame):
  NRC <- get_nrc_sentiment(list_2015_cleaned[[i]])
  # sum every column of NRC, excluding columns 9 and 10 (positive and negative),
  # and then compute the maximum of the columnsums, then look for the name of that column,
  # in other words: return the sentiment with the highest colSums:
  NRC_2015[[i]] <- colnames(NRC[,c(-9,-10)])[which.max(colSums(NRC[,c(-9,-10)]))]
  # Use the corresponding country name: 
  names(NRC_2015)[i] <- names(list_2015)[i]
  # Print sentiment just to verify the loop is working:
  print(NRC_2015[[i]])
  }


# # The following loop takes about 10 mins
NRC_2018 = list()
for (i in 1:length(list_2018_cleaned)){
  # find the NRC sentiments of every country (creates a data frame):
  NRC <- get_nrc_sentiment(list_2018_cleaned[[i]])
  # sum every column of NRC, excluding columns 9 and 10 (positive and negative),
  # and then compute the maximum of the columnsums, then look for the name of that column,
  # in other words: return the sentiment with the highest colSums:
  NRC_2018[[i]] <- colnames(NRC[,c(-9,-10)])[which.max(colSums(NRC[,c(-9,-10)]))]
  # Use the corresponding country name: 
  names(NRC_2018)[i] <- names(list_2018)[i]
  # Print sentiment just to verify the loop is working:
  print(NRC_2018[[i]])
  }

# Save NRC results in case one requires them later 
#save(NRC_2012,file="NRC_2012.Rda")
#save(NRC_2015,file="NRC_2015.Rda")
#save(NRC_2018,file="NRC_2018.Rda")


# 2) Minqing-Bing dictionary

# read positive words downloaded from http://ptrckprry.com/course/ssd/data/positive-words.txt
poswords <- paste(readLines("poswords.txt"), collapse = " ")
# Divide poswords text into separate words:
poswords <- strsplit(poswords, "\\s+")[[1]]
 
# read negative words downloaded from http://ptrckprry.com/course/ssd/data/negative-words.txt
negwords <- paste(readLines("negwords.txt"), collapse = " ")
# Divide negwords text into separate words:
negwords <- strsplit(negwords, "\\s+")[[1]]

minqing_2012 = list()
for (i in 1:length(list_2012_cleaned)){
  # 1. create a match between country words and poswords (it gives a TRUE or FALSE vector),
  # 2. create a match between country words and negwords (it gives a TRUE or FALSE vector), 
  # 3. sum 1. and substract it from 2.,
  # In that way score = number of positive matches minus negative matches:
  score <- sum(!is.na(match(list_2012_cleaned[[i]], poswords)))
  -sum(!is.na(match(list_2012_cleaned[[i]], negwords)))
  # Assign the score value to the new list:
  minqing_2012[[i]] <- score
  # Use the corresponding country name:
  names(minqing_2012)[i] <- names(list_2012)[i]
  # Print sentiment just to verify the loop is working:
  print(minqing_2012[[i]])
  }


minqing_2015 = list()
for (i in 1:length(list_2015_cleaned)){
  # 1. create a match between country words and poswords (it gives a TRUE or FALSE vector),
  # 2. create a match between country words and negwords (it gives a TRUE or FALSE vector), 
  # 3. sum 1. and substract it from 2.,
  # In that way score = number of positive matches minus negative matches:
  score <- sum(!is.na(match(list_2015_cleaned[[i]], poswords)))
  -sum(!is.na(match(list_2015_cleaned[[i]], negwords)))
  # Assign the score value to the new list:
  minqing_2015[[i]] <- score
  # Use the corresponding country name:
  names(minqing_2015)[i] <- names(list_2015)[i]
  # Print sentiment just to verify the loop is working:
  print(minqing_2015[[i]])
  }

minqing_2018 = list()
for (i in 1:length(list_2018_cleaned)){
  # 1. create a match between country words and poswords (it gives a TRUE or FALSE vector),
  # 2. create a match between country words and negwords (it gives a TRUE or FALSE vector), 
  # 3. sum 1. and substract it from 2.,
  # In that way score = number of positive matches minus negative matches:
  score <- sum(!is.na(match(list_2018_cleaned[[i]], poswords)))
  -sum(!is.na(match(list_2018_cleaned[[i]], negwords)))
  # Assign the score value to the new list:
  minqing_2018[[i]] <- score
  # Use the corresponding country name:
  names(minqing_2018)[i] <- names(list_2018)[i]
  # Print sentiment just to verify the loop is working:
  print(minqing_2018[[i]])
  }

# Save Minqing results in case one requires them later 
#save(minqing_2012,file="minqing_2012.Rda")
#save(minqing_2015,file="minqing_2015.Rda")
#save(minqing_2018,file="minqing_2018.Rda")

 
# 3) Sentimentr dictionary
 
sentimentr_2012 = list()
for (i in 1:length(list_2012_cleaned_full)){
  # Apply sentimentr to every sentence of the executive summary:
  sent <- sentimentr::sentiment(get_sentences(list_2012_cleaned_full[[i]]))$sentiment
  # Compute the mean of the polarity and assing it to the new list:
  sentimentr_2012[[i]] <- mean(sent)
  # Use the corresponding country name:
  names(sentimentr_2012)[i] <- names(list_2012)[i]
  # Print sentiment just to verify the loop is working:
  print(sentimentr_2012[[i]])
  }

sentimentr_2015 = list()
for (i in 1:length(list_2015_cleaned_full)){
  # Apply sentimentr to every sentence of the executive summary:
  sent <- sentimentr::sentiment(get_sentences(list_2015_cleaned_full[[i]]))$sentiment
  # Compute the mean of the polarity and assing it to the new list:
  sentimentr_2015[[i]] <- mean(sent)
  # Use the corresponding country name:
  names(sentimentr_2015)[i] <- names(list_2015)[i]
  # Print sentiment just to verify the loop is working:
  print(sentimentr_2015[[i]])
  }

sentimentr_2018 = list()
for (i in 1:length(list_2018_cleaned_full)){
  # Apply sentimentr to every sentence of the executive summary:
  sent <- sentimentr::sentiment(get_sentences(list_2018_cleaned_full[[i]]))$sentiment
  # Compute the mean of the polarity and assing it to the new list:
  sentimentr_2018[[i]] <- mean(sent)
  # Use the corresponding country name:
  names(sentimentr_2018)[i] <- names(list_2018)[i]
  # Print sentiment just to verify the loop is working:
  print(sentimentr_2018[[i]])
  }

# Save Sentimentr results in case one requires them later 
# save(sentimentr_2012,file="sentimentr_2012.Rda")
# save(sentimentr_2015,file="sentimentr_2015.Rda")
# save(sentimentr_2018,file="sentimentr_2018.Rda")
 
# remove temporal objects
rm(NRC, i, negwords, poswords, score, sent)

load("NRC_2012.Rda")
load("NRC_2015.Rda")
load("NRC_2018.Rda")
load("minqing_2012.Rda")
load("minqing_2015.Rda")
load("minqing_2018.Rda")
load("sentimentr_2012.Rda")
load("sentimentr_2015.Rda")
load("sentimentr_2018.Rda")

# --------------------------
# Section 4: Interactive Map
# --------------------------

# This section only presents the assignation of the Sentiment Analysis data
# to the Map data. Details on how the map is graphed will be discussed in next
# section

# Convert dictionary lists into data frames
NRC_2012_df <- data.frame(unlist(NRC_2012))
NRC_2012_df <- data.frame(names = row.names(NRC_2012_df), NRC_2012_df)   
rownames(NRC_2012_df) <- c()
colnames(NRC_2012_df) <- c("region", "NRC_2012")

NRC_2015_df <- data.frame(unlist(NRC_2015))
NRC_2015_df <- data.frame(names = row.names(NRC_2015_df), NRC_2015_df)   
rownames(NRC_2015_df) <- c()
colnames(NRC_2015_df) <- c("region", "NRC_2015")

NRC_2018_df <- data.frame(unlist(NRC_2018))
NRC_2018_df <- data.frame(names = row.names(NRC_2018_df), NRC_2018_df)   
rownames(NRC_2018_df) <- c()
colnames(NRC_2018_df) <- c("region", "NRC_2018")

minqing_2012_df <- data.frame(unlist(minqing_2012))
minqing_2012_df <- data.frame(names = row.names(minqing_2012_df), minqing_2012_df)   
rownames(minqing_2012_df) <- c()
colnames(minqing_2012_df) <- c("region", "minqing_2012")

minqing_2015_df <- data.frame(unlist(minqing_2015))
minqing_2015_df <- data.frame(names = row.names(minqing_2015_df), minqing_2015_df)   
rownames(minqing_2015_df) <- c()
colnames(minqing_2015_df) <- c("region", "minqing_2015")

minqing_2018_df <- data.frame(unlist(minqing_2018))
minqing_2018_df <- data.frame(names = row.names(minqing_2018_df), minqing_2018_df)   
rownames(minqing_2018_df) <- c()
colnames(minqing_2018_df) <- c("region", "minqing_2018")

sentimentr_2012_df <- data.frame(unlist(sentimentr_2012))
sentimentr_2012_df <- data.frame(names = row.names(sentimentr_2012_df), sentimentr_2012_df)   
rownames(sentimentr_2012_df) <- c()
colnames(sentimentr_2012_df) <- c("region", "sentimentr_2012")

sentimentr_2015_df <- data.frame(unlist(sentimentr_2015))
sentimentr_2015_df <- data.frame(names = row.names(sentimentr_2015_df), sentimentr_2015_df)   
rownames(sentimentr_2015_df) <- c()
colnames(sentimentr_2015_df) <- c("region", "sentimentr_2015")

sentimentr_2018_df <- data.frame(unlist(sentimentr_2018))
sentimentr_2018_df <- data.frame(names = row.names(sentimentr_2018_df), sentimentr_2018_df)   
rownames(sentimentr_2018_df) <- c()
colnames(sentimentr_2018_df) <- c("region", "sentimentr_2018")

# Load data for Europe Map
global <- map_data("world")
european_countries <- c("Albania", "Andorra", "Austria", "Belarus",
                 "Belgium", "Bosnia and Herzegovina", "Bulgaria","Croatia","Cyprus",
                 "Czech Republic","Denmark","Estonia","Finland","France",
                 "Germany","Greece","Hungary","Iceland", "Ireland","Italy", 
                 "Kosovo", "Latvia", "Liechtenstein", "Lithuania","Luxembourg", "Macedonia",
                 "Malta","Moldova", "Monaco", "Montenegro","Netherlands","Norway","Poland",
                 "Portugal","Romania","San Marino", "Serbia", "Slovakia","Slovenia","Spain",
                 "Sweden", "Switzerland", "Ukraine", "UK", "Vatican")

# Exclude countries outside Europe
ind_eur <- which(global$region %in% european_countries)
global <- global[ind_eur,]

# Lower cases for all the countries
global$region <- tolower(global$region)

# Merge Sentiment Analysis dataframes with Europe map dataframe

# It will give some warning messages but not important for our purpouses
global <- left_join(global, NRC_2012_df, by = "region")
global <- left_join(global, NRC_2015_df, by = "region")
global <- left_join(global, NRC_2018_df, by = "region")
global <- left_join(global, minqing_2012_df, by = "region")
global <- left_join(global, minqing_2015_df, by = "region")
global <- left_join(global, minqing_2018_df, by = "region")
global <- left_join(global, sentimentr_2012_df, by = "region")
global <- left_join(global, sentimentr_2015_df, by = "region")
global <- left_join(global, sentimentr_2018_df, by = "region")


# remove temporal objects
rm(european_countries, ind_eur)

# --------------------
# Section 5: Shiny App
# --------------------

# Reconmendations before runing the App:

# The code for the Shiny App is on the files named ui.R and server.R
# ui.R contains the general structure
# server.R contains the functionality
# Those files need to be saved in the current directory (codeline 2)

# To better visualize the App it is reconmended to select the option
# "Run External" next to the button called "Run App"

# Run App in the default browser (it could be too small)
shiny::runApp()

# change the following line to your desired browser (in this case chrome)
chrome <- "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe"
options(browser = chrome)
shiny::runApp("./", launch.browser = TRUE)
