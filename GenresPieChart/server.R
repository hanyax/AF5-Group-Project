library("plotly")
library("shiny")

# find most genres based on the language selectted.
  
# find movies where the original_lang is en/hi/'
# popular movies of different langugages 
# display the pictures in the background?
# calculate the genre ids

getMovies <- function(lang) {
  key <- "7a6c78ba5a3085b57bf936f116cd1259"
  base <- paste0("https://api.themoviedb.org/3/discover/movie?")
  query.params <- list(with_original_language = lang, api_key = key)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  info <- results$results
  info$genre_ids <- as.character(info$genre_ids)
  print(info$genre_ids)
  data <- data.frame(info$title, info$release_date, info$vote_average, info$popularity, info$genre_ids, info$vote_count, info$original_language, stringsAsFactors = FALSE)
  View(data)
  return (data)
}

findMovieGenre <- function(genres) {
  key <- "7a6c78ba5a3085b57bf936f116cd1259"
  base <- "https://api.themoviedb.org/3/genre/movie/list?"
  # people <- findActorID(name)
  # sort <- "popularity.desc"
  query.params <- list(api_key = key)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  # results <- flatten(genres$id)
  print(results)
  return (results)
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

#info$genre_ids <- strsplit(nums)

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
    
data <- getMovies(language)

# change the color to the range of last 5 years

plot_ly(data, x = ~data$info.vote_average, y = ~data$info.popularity, text = ~data$info.title, type = 'scatter', mode = 'markers', size = ~data$info.vote_count, color = ~data$info.release_date, colors = 'Paired',
             marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
  layout(title = 'Popular Movies in a particular language and genres',
         xaxis=x,
         yaxis=y,
         showlegend = FALSE)


  })
  
  
})


#for i in 1:length(genres) {
#  list[[i]] <- 
#}


