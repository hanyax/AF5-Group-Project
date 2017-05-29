library(shiny)
library(plotly)

  
shinyUI(fluidPage(
  
  # title of page
  titlePanel("Applet"),

  # create side panel which contains two widgets 
  sidebarPanel(
    
    # drop down bar widget
    selectInput("select", label = h3("Select Rating"),
                choices = list("G" = "G","PG" = "PG", "PG13" = "PG13", "R" = "R"),
                selected = "PG")
  ),
  
  # panel for scatterplot
  mainPanel(
    plotlyOutput('barChart')
  )
))


