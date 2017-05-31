library(shiny)
source("../ActorCloud/buildWordCloud.R")
source("../ActorCloud/findCoActor.R")

function(input, output) {
  # Generate wordcloud with buildWordCloud function
  output$plot <- renderPlot({
    name <- input$textInput
    topN <- input$topN
    buildWordCloud(name, topN)
  })
}