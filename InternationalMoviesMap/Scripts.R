library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(jsonlite)
library("httr")

# api key is 07c7b544cd225d44012fadeac87086aa


base.api <- "https://api.themoviedb.org/3/person/"
list <- api_key = key, query=""
ryan.g <- GET()

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

getActorMovies <- function(id) {
  key <- "07c7b544cd225d44012fadeac87086aa"
  base <- paste0("https://api.themoviedb.org/3/discover/movie?")
  query.params <- list(api_key = key, with_cast = id)
  response <- GET(base, query = query.params)
  text <- content(response, "text")
  results <- fromJSON(text)
  results <- flatten(results$results)

  return(results)
}




getActorTVShows <- function(id) {
  key <- "07c7b544cd225d44012fadeac87086aa"
  base <- paste0("https://api.themoviedb.org/3/discover/tv?")
  query.params <- list(api_key = key, with_cast = id)
  response <- GET(base, query = query.params)
  text <- content(response, "text")
  results <- fromJSON(text)
  results <- flatten(results$results)
  
  return(results)
}






