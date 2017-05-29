library(shiny)
library(plotly)
library(dplyr)

data <- read.table('./data/cereal.tsv', header = TRUE)



shinyServer(function(input, output) {
  output$scatter <- renderPlotly({
    
    # set X and Y axis variables
    x <- list(
      title = "Calories"
    )
    y <- list(
      title = "Ratings"
    )
    
    # change graph based on widget of selecting fat amount
    if(input$select == '0') {
      data <- filter(data, fat == '0')
    }
    if(input$select == '1') {
      data <- filter(data, fat == '1')
    }
    if(input$select == '2') {
      data <- filter(data, fat == '2')
    }
    if(input$select == '3') {
      data <- filter(data, fat == '3')
    }
    if(input$select == '5') {
      data <- filter(data, fat == '5')
    }
    
    # change graph colors based on radio buttons
    if(input$radio == 'sodium'){
      dataColor = data$sodium
      colorSet = "Set1"
    }
    if(input$radio == 'sugars'){
      dataColor = data$sugars
      colorSet = "Set2"
    }
    if(input$radio == 'fiber'){
      dataColor = data$fiber 
      colorSet = "Set3"
    }
    
    # display the graph
    plot_ly(data, x = data$calories, y = data$rating, mode = "markers", text = ~paste("Cereal Name: ", data$name), color = dataColor, colors= colorSet) %>% 
      layout(title = 'Calories and Ratings of Various Cereals', xaxis=x, yaxis=y)
  })
  
  
})