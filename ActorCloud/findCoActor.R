library("httr")
library(jsonlite)
library(dplyr)

toDataframe <- function(name, topN){
  actorList = list()
  movies = findActorMovieID(name)
  for (i in 1:length(movies)) {
    actorList <- findCast(movies[i], actorList)
  }
  row <- length(actorList)
  actorIDs <- names(actorList)
  count <- numeric(row)
  for (i in 1:row) {
    count[[i]] <- actorList[[i]]
  }
  df <- data.frame(actorIDs, count, stringsAsFactors = FALSE)
  selected <- df %>% arrange(-count)
  selected <- selected[-c(1), ]
  selected <- selected %>% slice(1:topN) 
  actorNames <- character(topN)
  for (i in 1:topN) {
    actorNames[i] <- toActorName(selected[i,"actorIDs"])
  }
  selected <- data.frame(selected, actorNames)
  return(selected)
}

toActorName <- function(id) {
  key <- "7a6c78ba5a3085b57bf936f116cd1259"
  base <- paste("https://api.themoviedb.org/3/person/",id,sep = "")
  query.params <- list(api_key = key)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  return(results[["name"]])
}

findCast <- function(movieID, actorList) {
  key <- "7a6c78ba5a3085b57bf936f116cd1259"
  base <- paste("https://api.themoviedb.org/3/movie/", movieID, "/credits",sep = "")
  query.params <- list(api_key = key)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  results <- flatten(results$cast)
  actor.id <- results$id

  for (i in 1:length(actor.id)) { 
    if (is.null(actorList[[toString(actor.id[i])]])) {
      actorList[[toString(actor.id[i])]] <- 1;
    } else {
      new.val <- actorList[[toString(actor.id[i])]] + 1;
      actorList[[toString(actor.id[i])]] <- new.val
    }
  }
  return (actorList)
}

# find all the movie id that the actor is in 
findActorMovieID <- function(name) {
  key <- "7a6c78ba5a3085b57bf936f116cd1259"
  base <- "https://api.themoviedb.org/3/discover/movie?"
  people <- findActorID(name)
  sort <- "popularity.desc"
  query.params <- list(with_cast = people, sort_by = sort, api_key = key)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  results <- flatten(results$results)
  movies <- results$id
  return (movies)
}

findActorID <- function(name) {
  key <- "7a6c78ba5a3085b57bf936f116cd1259"
  base <- "https://api.themoviedb.org/3/search/person?"
  query.params <- list(api_key = key, query=name)
  response <- GET(base, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  results <- flatten(results$results)
  return (toString(results$id[1]))
}