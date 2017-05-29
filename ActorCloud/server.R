library(shiny)
source("../ActorCloud/buildWordCloud.R")
source("../ActorCloud/findCoActor.R")

function(input, output) {
  # Make the wordcloud drawing predictable during a session
  
  output$plot <- renderPlot({
    name <- input$textInput
    topN <- input$topN
    buildWordCloud(name, topN)
  })
}