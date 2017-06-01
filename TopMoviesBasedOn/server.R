library(shiny)
library(jsonlite)
library(httr)

topMoviesByYearGenre <- function(year, genre) {
  key <- "7a6c78ba5a3085b57bf936f116cd1259"
  base <- paste0("https://api.themoviedb.org/3/discover/movie?with_genres=", genre, "&primary_release_year=", year ,"&sort_by=popularity.desc")
  query.params <- list(api_key = key)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  info <- results$results
  df <- data.frame(info$title,info$release_date, info$overview, info$popularity, stringsAsFactors = FALSE)
}

shinyServer(function(input, output) {
  
  output$table <- renderTable({
    
    data <- topMoviesByYearGenre(input$year, input$genre)
    
    colnames(data)[1] <- "Title"
    colnames(data)[2] <- "Release Date"
    colnames(data)[3] <- "Overview"
    colnames(data)[4] <- "Popularity Rating"
    
    data
    
  })
})