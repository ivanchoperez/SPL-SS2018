# The main results of this code are two outputs:
# 1.The output$map element
# 2.The output$wordcloud element


shinyServer(function(input, output){

  # 1.The output$map element:
  # this element is a ggplot map that varies depending on the conditionals
  # In every conditional 3 objects change:
  # a. the global$oc2 column which is the link to the Country Report when clicking
  # b. The sentiment (which is stored in the global data frame)
  # c. The ggplot map (changes depending on the sentiments)
  # At the end the final ggplot is used in the ggiraph function to turn it interactive
  
  output$map <- renderggiraph({

    if(input$year == "2012" & input$dictionary == "NRC"){
      
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/file_import/swd2012_", 
        as.character(global$region),"_en_0.pdf"
      )      
    
      Sentiment <- factor(global$NRC_2012, levels = c("trust", "anticipation"))  
              
    gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
      geom_polygon_interactive(aes(fill = Sentiment,
                                   group = group,
                                   tooltip = region, data_id = region,
                                   onclick = oc2), colour = "black") +
      coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
      labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
      theme_bw() +
      theme(panel.grid = element_blank()) +
      theme(strip.text = element_blank()) +
      #theme(legend.title=element_text("Sentiment")) +
      theme(title = element_text(face = "bold")) +
      scale_fill_discrete(na.value="grey") 

    }
    
    else if(input$year == "2015" & input$dictionary == "NRC"){
      
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/file_import/cr2015_", 
        as.character(global$region),"_en_0.pdf"
      )
      
      Sentiment <- factor(global$NRC_2015, levels = c("trust","anticipation"))
      
      gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
        geom_polygon_interactive(aes(fill = Sentiment, group = group,
                                     tooltip = region, data_id = region, onclick = oc2), colour = "black") +
        coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
        labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
        theme_bw() +
        theme(panel.grid = element_blank()) +
        theme(strip.text = element_blank()) +
        #theme(legend.title=element_blank()) +
        theme(title = element_text(face = "bold")) +
        scale_fill_discrete(na.value="grey")
      
    }
    
    else if(input$year == "2018" & input$dictionary == "NRC"){
      
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/2018-european-semester-country-report-",
        as.character(global$region),"-en.pdf" 
      )
      
      Sentiment <- factor(global$NRC_2018, levels = c("trust", "anticipation"))
      
      gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
        geom_polygon_interactive(aes(fill = Sentiment, group = group,
                                     tooltip = region, data_id = region, onclick = oc2), colour = "black") +
        coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
        labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
        theme_bw() +
        theme(panel.grid = element_blank()) +
        theme(strip.text = element_blank()) +
        #theme(legend.title=element_blank()) +
        theme(title = element_text(face = "bold")) +
        scale_fill_discrete(na.value="grey")
      
    }
    
    else if(input$year == "2012" & input$dictionary == "Minqing"){
      
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/file_import/swd2012_", 
        as.character(global$region),"_en_0.pdf"
      )
      
      Positivity <- global$minqing_2012
      
      gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
        geom_polygon_interactive(aes(fill = Positivity, 
                                     group = group, 
                                     tooltip = region, 
                                     data_id = region, 
                                     onclick = oc2), colour = "black") +
        coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
        labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
        theme_bw() +
        theme(panel.grid = element_blank()) + 
        theme(strip.text = element_blank()) +
        #theme(legend.title=element_blank()) +
        theme(title = element_text(face = "bold")) +
        scale_fill_continuous(na.value="grey") +
        scale_fill_gradient2(low = "yellow", mid = "red", high = "green")
            
    }
    
    else if(input$year == "2015" & input$dictionary == "Minqing"){
      
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/file_import/cr2015_", 
        as.character(global$region),"_en_0.pdf"
      )
      
      Positivity <- global$minqing_2015
      
      gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
        geom_polygon_interactive(aes(fill = Positivity, 
                                     group = group, 
                                     tooltip = region, 
                                     data_id = region, 
                                     onclick = oc2), colour = "black") +
        coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
        labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
        theme_bw() +
        theme(panel.grid = element_blank()) + 
        theme(strip.text = element_blank()) +
        #theme(legend.title=element_blank()) +
        theme(title = element_text(face = "bold")) +
        scale_fill_continuous(na.value="grey") +
        scale_fill_gradient2(low = "yellow", mid = "red", high = "green")       
    }
    
    
    else if(input$year == "2018" & input$dictionary == "Minqing"){
      
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/2018-european-semester-country-report-",
        as.character(global$region),"-en.pdf" 
      )
      
      Positivity <- global$minqing_2018
      
      gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
        geom_polygon_interactive(aes(fill = Positivity, 
                                     group = group, 
                                     tooltip = region, 
                                     data_id = region, 
                                     onclick = oc2), colour = "black") +
        coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
        labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
        theme_bw() +
        theme(panel.grid = element_blank()) + 
        theme(strip.text = element_blank()) +
        #theme(legend.title=element_blank()) +
        theme(title = element_text(face = "bold")) +
        scale_fill_continuous(na.value="grey") + 
        scale_fill_gradient2(low = "yellow", mid = "red", high = "green") 
      
    }
    
    else if(input$year == "2012" & input$dictionary == "Sentimentr"){
      
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/file_import/swd2012_", 
        as.character(global$region),"_en_0.pdf"
      )
    
      Positivity <- global$sentimentr_2012
      
      gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
        geom_polygon_interactive(aes(fill = Positivity, group = group, 
                                     tooltip = region, data_id = region, onclick = oc2), colour = "black") +
        coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
        labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
        theme_bw() +
        theme(panel.grid = element_blank()) + 
        theme(strip.text = element_blank()) +
        #theme(legend.title=element_blank()) +
        theme(title = element_text(face = "bold")) +
        scale_fill_continuous(na.value="grey") +
        scale_fill_gradient2(low = "yellow", mid = "red", high = "green")
    }
    
    else if(input$year == "2015" & input$dictionary == "Sentimentr"){
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/file_import/cr2015_", 
        as.character(global$region),"_en_0.pdf"
      )
      
      Positivity <- global$sentimentr_2015
      
      gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
        geom_polygon_interactive(aes(fill = Positivity, group = group, 
                                     tooltip = region, data_id = region, onclick = oc2), colour = "black") +
        coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
        labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
        theme_bw() +
        theme(panel.grid = element_blank()) + 
        theme(strip.text = element_blank()) +
        #theme(legend.title=element_blank()) +
        theme(title = element_text(face = "bold")) +
        scale_fill_continuous(na.value="grey") +
        scale_fill_gradient2(low = "yellow", mid = "red", high = "green")
    }
    
    
    else {
      global$oc2 <- sprintf(
        "window.open(\"%s%s%s\")",
        "https://ec.europa.eu/info/sites/info/files/2018-european-semester-country-report-",
        as.character(global$region),"-en.pdf"
      )

      Positivity <- global$sentimentr_2018

      gg2 <- ggplot(data = global, aes(x=long, y = lat)) +
        geom_polygon_interactive(aes(fill = Positivity, group = group,
                                     tooltip = region, data_id = region, onclick = oc2), colour = "black") +
        coord_fixed(1.3) + xlim(-12,42) + ylim(35,73) +
        labs(x = "", y = "", title = "Europe Sentiment Analysis", subtitle = "Sentiment Analysis on European Comission Annual Report") +
        theme_bw() +
        theme(panel.grid = element_blank()) +
        theme(strip.text = element_blank()) +
        #theme(legend.title=element_blank()) +
        theme(title = element_text(face = "bold")) +
        scale_fill_continuous(na.value="grey") +
        scale_fill_gradient2(low = "yellow", mid = "red", high = "green")
    }
    
    ggiraph(ggobj = gg2, selection_type = "none")
    
  })
  
  # 2.The output$wordcloud element:
  # Takes the year and the country as inputs and makes a Wordclud
  # Before doing the wordcloud, a dataframe by country is created with 
  # the frequency of each word
  
  output$wordcloud <- renderWordcloud2({
      
    # Bigger size wordcloud 2012
      if (input$year == "2012" & input$country %in% c("czech republic",
                                                      "france",
                                                      "germany",
                                                      "italy",
                                                      "netherland",
                                                      "portugal", 
                                                      "slovakia",
                                                      "uk")) {    
      country_df <- data.frame(unlist(list_2012_cleaned[[input$country]]))
      colnames(country_df) <- c("words")
      words_df <- plyr::count(country_df, "words")
      words_df <- words_df[order(words_df$freq, decreasing = T),]
      words_df <- words_df[words_df$freq >= 1,]
      wordcloud2::wordcloud2(words_df, size = 0.3)
    
  }
    
    # Normal size wordcloud 2012
    else if(input$year == "2012" & !(input$country %in% c("czech republic",
                                                          "france",
                                                          "germany",
                                                          "italy",
                                                          "netherland",
                                                          "portugal", 
                                                          "slovakia",
                                                          "uk"))){
      
      country_df <- data.frame(unlist(list_2015_cleaned[[input$country]]))
      colnames(country_df) <- c("words")
      words_df <- plyr::count(country_df, "words")
      words_df <- words_df[order(words_df$freq, decreasing = T),]
      words_df <- words_df[words_df$freq >= 2,]
      wordcloud2::wordcloud2(words_df, size = 0.22)
    }
      
    # Bigger size wordcloud 2015
  else if(input$year == "2015" & input$country %in% c("belgium",
                                                      "france",
                                                      "germany",
                                                      "ireland",
                                                      "italy",
                                                      "netherlands",
                                                      "poland",
                                                      "slovakia",
                                                      "slovenia")){
    
      country_df <- data.frame(unlist(list_2015_cleaned[[input$country]]))
      colnames(country_df) <- c("words")
      words_df <- plyr::count(country_df, "words")
      words_df <- words_df[order(words_df$freq, decreasing = T),]
      words_df <- words_df[words_df$freq >= 2,]
      wordcloud2::wordcloud2(words_df, size = 0.32)
    }
  
    # Normal size wordcloud 2015
    else if(input$year == "2015" & !(input$country %in% c("belgium",
                                                          "france",
                                                          "germany",
                                                          "ireland",
                                                          "italy",
                                                          "netherlands",
                                                          "poland",
                                                          "slovakia",
                                                          "slovenia"))){
      
      country_df <- data.frame(unlist(list_2015_cleaned[[input$country]]))
      colnames(country_df) <- c("words")
      words_df <- plyr::count(country_df, "words")
      words_df <- words_df[order(words_df$freq, decreasing = T),]
      words_df <- words_df[words_df$freq >= 2,]
      wordcloud2::wordcloud2(words_df, size = 0.22)
    }  
    
  # Bigger size wordcloud 2018  
  else if(input$year == "2018" & input$country %in% c("estonia",
                                                      "germany")){
    
    country_df <- data.frame(unlist(list_2018_cleaned[[input$country]]))
    colnames(country_df) <- c("words")
    words_df <- plyr::count(country_df, "words")
    words_df <- words_df[order(words_df$freq, decreasing = T),]
    words_df <- words_df[words_df$freq >= 3,]
    wordcloud2::wordcloud2(words_df, size = 0.32)
  }
    # Normal size wordcloud 2018
    else if(input$year == "2018" & !(input$country %in% c("estonia",
                                                        "germany"))){
      
      country_df <- data.frame(unlist(list_2018_cleaned[[input$country]]))
      colnames(country_df) <- c("words")
      words_df <- plyr::count(country_df, "words")
      words_df <- words_df[order(words_df$freq, decreasing = T),]
      words_df <- words_df[words_df$freq >= 3,]
      wordcloud2::wordcloud2(words_df, size = 0.25)
    }
      
  })
    
})

