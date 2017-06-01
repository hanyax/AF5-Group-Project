#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      fluidPage(
        
        # Copy the line below to make a text input box
        textInput("text", label = h3("Actor/Actress FullName"), value = "Emma Stone"),
        
        hr(),
        fluidRow(column(3, verbatimTextOutput("value")))
        
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("scatter")
    )
  )
))
