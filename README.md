# Sentiment Analysis of European Comission Country Report

In our project, we analyze the country reports of all European countries, published by the European Commission. Our goal is to identify the sentiment of the European Commission about the economic and political state of each European country for the years of 2012, 2015 and 2018. In our case, we focus on the Executive Summary, a short passage of text in the beginning of each report. We use three different dictionaries with different mapping complexities, to gain a broader look on the possibilities of sentiment analysis.


We display the results on an interactive map, allowing the user to switch between the analyses of the Country Reports of the different publishing years and the dictionary used, resulting in a total of nine views. In addition, we provide a word cloud for each country for all three analyzed years, displaying the most frequent words used in the executive summaries.


The most important files are the following:


SentMap.R: Main code

ui.R: Specifies the general structure of the shinydashboard (it is saved in the Data folder)

server.R: Plots the element of the shinydashboard (it is saved in the Data folder)


Data: Folder containing the i) Executive Summaries for every country and year (it is required to run the SentMap.R code), ii) The results form the Sentiment Analysis (dictionary_year.Rda), iii) List of positive and negative words for the Minqing dictionary and iV) ui.R and server.R files required to run the Shinyapp.


Metainfo.txt: General Information about authors and project


All analyses were conducted using RStudio.


Authors: Anna Bothe, Ivan Perez, Robert Sitner

