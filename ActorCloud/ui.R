library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("CoActors Cloud"),
  
  # Sidebar with a slider input for number of co-actor displayed
  sidebarLayout(
    sidebarPanel(
      
      textInput("textInput", label = h3("Actor/Actress Name"), value = "Johnny Depp"),
      
      sliderInput("topN",
                   "Top Actor/Atress He/She Worked With",
                   min = 1,
                   max = 16,
                   value = 10)
      ),
    
    # Show a plot of the generated wordcloud
    mainPanel(
       plotOutput("plot")
    )
  )
))
