library("httr")
library("jsonlite")


# Bring in the API key and method for the movie database

findMovieGenre <- function(genres) {
  key <- "cc04f8a15efff3b286a9eb5a51308304"
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

getGenre <- function() {
  key <- "cc04f8a15efff3b286a9eb5a51308304"
  base <- "https://api.themoviedb.org/3/genre/movie/list?"
}
