library(shiny)
source("../AF5-Group-Project/ActorCloud/buildWordCloud.R")
source("../AF5-Group-Project/ActorCloud/findCoActor.R")

function(input, output) {
  topN <- eventReactive(input$go, {input$topN})
  name <- eventReactive(input$go, {input$textInput})
  
  # Generate wordcloud with buildWordCloud function
  output$plot <- renderPlot({
    buildWordCloud(name(), topN())
  })
}