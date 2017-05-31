library(shiny)
library(plotly)
library(dplyr)
library("httr")
library(jsonlite)
library(RColorBrewer)

source("../AF5-Group-Project/ActorCloud/buildWordCloud.R")
source("../AF5-Group-Project/ActorCloud/findCoActor.R")

# function to retrieve information from the API  
topRatedMovies <- function(rating) {
  key <- "7a6c78ba5a3085b57bf936f116cd1259"
  base <- paste0("https://api.themoviedb.org/3/discover/movie/?certification_country=US&certification=",rating,"&sort_by=popularity.desc")
  query.params <- list(api_key = key)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  info <- results$results
  df <- data.frame(info$title, info$popularity, stringsAsFactors = FALSE)
  return (df)
}

function(input, output) {
  # Generate wordcloud with buildWordCloud function
  output$plot <- renderPlot({
    name <- input$textInput
    topN <- input$topN
    buildWordCloud(name, topN)
  })
  
  # Generate bar chart based on movie ratings
  output$barChart <- renderPlotly({
    
    # set X and Y axis variables
    y <- list(
      title = "Popularity Rating"
    )
    ax <- list(
      title = "Movies (hover to see names)",
      zeroline = FALSE,
      showline = FALSE,
      showticklabels = FALSE,
      showgrid = FALSE
    )
    
    # change graph based on widget of selecting rating amount
    if(input$select == 'G') {
      option <- "G"
    }
    if(input$select == 'PG') {
      option <- "PG"
    }
    if(input$select == 'PG13') {
      option <- "PG13"
    }
    if(input$select == 'R') {
      option <- "R"
    }
    data <- topRatedMovies(option)
    data$info.title <- factor(data$info.title, levels = unique(data$info.title)[order(data$info.popularity, decreasing = TRUE)])
    
    # display the bar graph based on ratings
    plot_ly(data, x = data$info.title, y = data$info.popularity, type = "bar", 
            marker = list(color = colorRampPalette(brewer.pal(11,"Spectral"))(20))) %>% 
      layout(title = 'Top 20 Current Most Popular Movies By Rating', xaxis= ax, yaxis=y)
    
  })
}