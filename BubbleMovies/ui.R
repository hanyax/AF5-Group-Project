
library("shiny")
library("plotly")

# Define UI for application that draws a pie chart
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Movies "),
  
  sidebarPanel(
    # drop down widget to selec language
    selectInput(inputId = "lang",
                label = "Select a Language",
                choices = c("English", "Hindi", "Italian", "Japanese", "Greek", "French"), selected = "English")
  ),
  
  # Show a scatter plot of the generated distribution
  mainPanel(
    plotlyOutput("scatter")
  )
  
))

