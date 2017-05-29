library(shiny)
library(plotly)
library(dplyr)
library("httr")
library(jsonlite)
library(dplyr)

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


shinyServer(function(input, output) {
  output$barChart <- renderPlotly({
    
    # set X and Y axis variables
    x <- list(
      title = "Movies"
    )
    y <- list(
      title = "Popularity Rating"
    )
    
    # change graph based on widget of selecting fat amount
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
    
    # display the graph
    plot_ly(data, x = data$info.title, y = data$info.popularity, type = "bar", color = data$info.vote_average) %>% 
      layout(title = 'Movies', xaxis=x, yaxis=y)
  })
  
  
})