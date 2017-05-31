# Anushree Shukla

library("shiny")
library("plotly")

# Define UI for application that draws a pie chart
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Movies "),
  
  sidebarPanel(
    # drop down protein amount
    selectInput(inputId = "lang",
                label = "Select a Language",
                choices = c("English", "Hindi", "Italian", "Japanese", "Greek", "French"), selected = "English"),
    
    # radio button of serving size           
    checkboxGroupInput(inputId = "genres", label = h3("Select Genre"), choices = list
                       ("Action" = 28, "Comedy" = 35, "Romance" = 10749, "Thriller" = 53, "Science Fiction" = 878, "Drama" = 18, "Animation" = 16, "Adventure" = 12), selected = 28)
  ),
  
  # Show a scatter plot of the generated distribution
  mainPanel(
    plotlyOutput("scatter")
  )
  
))

