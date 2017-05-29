library(shiny)
library(plotly)

  
shinyUI(fluidPage(
  
  # title of page
  titlePanel("Information On Common Brands of Cereal"),

  # create side panel which contains two widgets 
  sidebarPanel(
    
    # drop down bar widget
    selectInput("select", label = h3("Select Fat Amount"),
                choices = list("0" = "0","1" = "1", "2" = "2", "3" = "3", "5" = "5", "Show All"),
                selected = "Show All"),
    
    # radio button widget to change colors
    radioButtons("radio", label = h3("Show Amounts By Color Of:"),
                 choices = list("Sodium" = 'sodium', "Sugars" = 'sugars', "Fiber" = 'fiber'),
                 selected = "sugars")
  ),
  
  # panel for scatterplot
  mainPanel(
    plotlyOutput('scatter')
  )
))


