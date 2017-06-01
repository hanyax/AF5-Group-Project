# ui.R
library(shiny)
library(plotly)
install.packages("wordcloud")


shinyUI(navbarPage(
  tags$head(
    tags$style(HTML("
                    @import url('//fonts.googleapis.com/css?family=Raleway|Cabin:400,700');
                    
                    body {
                      background-image: url(popcorn.jpg);
                      background-repeat: no-repeat;
                      background-size: 100%;
                    }

                    h1, h2 {
                    font-family: 'Raleway';
                    font-weight: 500;
                    line-height: 1.1;
                    text-align: center;
                    padding-left: 650px;
                    }

                    h2 {
                    font-size:13px;
                    }

                    p {
                    font-family: 'Raleway',
                    font-weight: 400;
                    line-height: 1.0;
                    padding-left: 650px;
                    }

                    img {
                    height: 100px;
                    width: 250px;
                    }
    
                    
                    "))
    ),
  
  
                tabPanel ('Welcome',
                          mainPanel(
                            
                            h1("More About Movies"),
                           
                            h2("Created by: Zhanna Voloshina, Zach Holle, Anushree Shukla, Shawn Xu, Andy Johnson "),
                            br(),
                            p("Our interactive platform allows you to explore information about current actors, top current movies,
                              ratings of movies by time, and more! Click through our interactive visualizations to find out more! 
                              "),
                            br(),
                            img(src='moviedb.png', align = "right")
                            
                            
                            
                          )
                ),
                   
                tabPanel('Co Actor Cloud',
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
                
                tabPanel('Movies By Rating',
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


