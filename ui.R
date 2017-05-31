# ui.R
library(shiny)
library(plotly)
install.packages("wordcloud")

shinyUI(navbarPage('More About Movies',
                   
                tabPanel('plot',
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
                ),
                
                tabPanel('barChart',
                         # title of page
                         titlePanel("Movies By Rating"),
                         
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
                         
                         )
                   
))


