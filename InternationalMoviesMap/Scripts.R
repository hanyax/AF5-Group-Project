library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(jsonlite)
library("httr")



# This function takes in the name of an Actor/Actress and returns the ID from the API
getActorID <- function(name) {
  key <- "07c7b544cd225d44012fadeac87086aa"
  base <- "https://api.themoviedb.org/3/search/person?"
  query.params <- list(api_key = key, query=name)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  results <- flatten(results$results)
  return (toString(results$id[1]))
  #View(body)
}


# This funciton takes in the ID of an Actor/Actress and returns the 20 most recent
# movies they have been in
getActorMovies <- function(id) {
  key <- "07c7b544cd225d44012fadeac87086aa"
  base <- paste0("https://api.themoviedb.org/3/discover/movie?")
  query.params <- list(api_key = key, with_cast = id, sort_by = "release_date.desc", vote_count.gte = 100)
  response <- GET(base, query = query.params)
  text <- content(response, "text")
  results <- fromJSON(text)
  results <- flatten(results$results)

  return(results)
}








