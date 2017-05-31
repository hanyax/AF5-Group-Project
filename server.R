library(shiny)
source("../AF5-Group-Project/ActorCloud/buildWordCloud.R")
source("../AF5-Group-Project/ActorCloud/findCoActor.R")

function(input, output) {
  # Generate wordcloud with buildWordCloud function
  output$plot <- renderPlot({
    name <- input$textInput
    topN <- input$topN
    buildWordCloud(name, topN)
  })
}