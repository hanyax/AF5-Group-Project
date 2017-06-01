library("plotly")
library("shiny")
library("httr")
library("dplyr")
library("rjson")
library("jsonlite")

# fuction returns a dataset of top 20 movies depending on language
getMovieDF <- function(lang) {
  key <- "cc04f8a15efff3b286a9eb5a51308304"
  base <- paste0("https://api.themoviedb.org/3/discover/movie?")
  query.params <- list(with_original_language = lang, api_key = key)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  info <- results$results
  info$genre_ids <- as.character(info$genre_ids)
  data <- data.frame(info$title, info$release_date, info$vote_average, info$popularity, info$vote_count, info$original_language, stringsAsFactors = FALSE)
  View(data)
  return(data)
}

shinyServer(function(input, output) {
  output$scatter <- renderPlotly({
    
    # set X and Y axis variables
    y <- list(
      title = "Popularity Rating"
    )
    x <- list(
      title = "Vote Average"
    )
    
    # change language depending on input
    if(input$lang == 'English') {
      language <- "en"
    } else if(input$lang == 'Hindi') {
      language <- "hi"
    } else if(input$lang == 'Italian') {
      language <- "it"
    } else if(input$lang == 'Japanese') {
      language <- "ja"
    } else if(input$lang == 'Greek') {
      language <- 'el'
    } else if(input$lang == 'French') {
      language <- 'fr'
    }
    
    # set data to the language selected
    data <- getMovies(language)
    
    # create a bubble plot that shows whether or not a movie is worth watching based on vote_average, poularity and vote_count
    plot_ly(data, x = ~data$info.vote_average, y = ~data$info.popularity, text = ~data$info.title, type = 'scatter', mode = 'markers', size = "Release Date:" ~data$info.vote_count, color = ~data$info.release_date, colors = 'Paired',
            marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
      layout(title = 'Popular Movies in a Select Language',
             xaxis=x,
             yaxis=y,
             showlegend = FALSE)
  })
  
})

