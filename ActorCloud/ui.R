library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("CoActors Cloud"),
  
  # Sidebar with a slider input for number of co-actor displayed
  sidebarLayout(
    sidebarPanel(
      
      textInput("textInput", label = h3("Actor/Actress Name"), value = "Johnny Depp"),
      
      # Since the API limits the number of call made in short period of time, the program will crash becuase the api call 
      # is rejected if the slidebar is moved too often. Please allow about 5 second bewteen each move of the slide bar.
      sliderInput("topN",
                   "Top Actor/Atress He/She Worked With",
                   min = 1,
                   max = 16,
                   value = 10),
      
      actionButton("go", "Go")
      ),
    
    # Show a plot of the generated wordcloud
    mainPanel(
       plotOutput("plot")
    )
  )
))
