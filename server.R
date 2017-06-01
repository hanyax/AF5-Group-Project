library("shiny")
library("plotly")
library("dplyr")
library("httr")
library("jsonlite")
library("RColorBrewer")

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

# function to retrieve information from the API (genres)
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

# function to retreive select information from discover API
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

function(input, output) {
  # Generate wordcloud with buildWordCloud function
  output$plot <- renderPlot({
    name <- input$textInput
    topN <- input$topN
    buildWordCloud(name, topN)
  })
  
  options = list(height = 1000)
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
  
  # bubble/scatter plot 
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
    data <- getMovieDF(language)
    
    # create a bubble plot that shows whether or not a movie is worth watching based on vote_average, poularity and vote_count
    plot_ly(data, x = ~data$info.vote_average, y = ~data$info.popularity, text = ~data$info.title, type = 'scatter', mode = 'markers', size = "Release Date:" ~data$info.vote_count, color = ~data$info.release_date, colors = 'Paired',
            marker = list(opacity = 0.5, sizemode = 'diameter')) %>%
      layout(title = 'Popular Movies in a Select Language',
             xaxis=x,
             yaxis=y,
             showlegend = FALSE)
  })
  # output table and siplay movies by year and genre
    output$table <- renderTable({
      
      data <- topMoviesByYearGenre(input$year, input$genre)
      
      colnames(data)[1] <- "Title"
      colnames(data)[2] <- "Release Date"
      colnames(data)[3] <- "Overview"
      colnames(data)[4] <- "Popularity Rating"
      
      data <- data[1:10,]
      
      data

    })
  
}

