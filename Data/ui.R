# This code specifies the general structure of the shinydashboard

shinyUI(
  dashboardPage(
  dashboardHeader(title = "SPL SS2018"),
  dashboardSidebar(
    selectInput("year", "Select Year",
                choices = c("2012", "2015", "2018")),
    selectInput("dictionary", "Select dictionary",
                choices = c("NRC", "Minqing", "Sentimentr")),
    selectInput("country", "Select country for wordcloud",
                choices = c("austria", "belgium", "bulgaria", "cyprus",
                            "czech republic", "denmark", "estonia", "finland", "france",
                            "germany", "hungary", "ireland", "italy", "latvia", "lithuania",
                            "luxembourg", "malta", "netherlands", "poland", "portugal",
                            "romania", "slovakia", "slovenia", "spain", "sweden", "uk"))
  ),
  dashboardBody(
    fluidRow(
      box(title = "Sentiment Map",
          status = "primary",
          solidHeader = TRUE,
        
          ggiraphOutput("map")),
      box(title = "Country Wordcloud",
          status = "primary",
          
          solidHeader = TRUE, 
          wordcloud2Output("wordcloud"))
    )
  )
  )
)