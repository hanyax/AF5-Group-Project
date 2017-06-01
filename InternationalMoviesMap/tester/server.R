#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
source("../Scripts.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # This puts out a scatter plot based on the inputted Actor/Actress
  output$scatterAndLine <- renderPlotly({ 
    
    # This calls up the function to convert the Actor/Actresses name to an ID
    id <- getActorID(input$text)
      
    # This calls up a function to get a data frame of the 20 most recent movie the Actor/Actress
    # has been credited on
    movies <- getActorMovies(id)
    
    font <- list(family = "Courier New, monospace", size = 20)
    
    y.axis <- list(title = "Average Rating (0-10)", titlefont = font)
    x.axis <- list(title = "Release Date (Hover for Date)", titlefont = font, showticklabels = FALSE)
    
    # This renders the graph
    plot_ly(movies, x= ~movies$release_date, y = ~movies$vote_average, type = 'scatter', mode = 'lines+markers', text = movies$original_title, marker = list(size=15), color = movies$vote_average, colors = "Greens") %>%
        layout(title = paste0(input$text, "'s Career Arc"),
               yaxis = y.axis,
               xaxis = x.axis
      )
  
    
    
    
    })
  
  
})
  

