library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      textInput("textInput", label = h3("Actor/Actress Name"), value = "Johnny Depp"),
      
      sliderInput("topN",
                   "Top Actor/Atress He/She Worked With",
                   min = 1,
                   max = 20,
                   value = 10)
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot")
    )
  )
))
