# ui.R
library("shiny")
library("plotly")
library("wordcloud")
library("dplyr")
library("httr")
library("jsonlite")



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
                    font-family: 'Raleway';
                    font-weight: 500;
                    line-height: 1.0;
                    font-size: 16px;
                    padding-left: 650px;
                    }

                    movie {
                    height: 100px;
                    width: 200px;
                    }
    
                    
                    "))
  ),
  
  
  tabPanel ('Welcome',
            mainPanel(
              img(src='smalllogo.png', align = "right"),
              h1("More About Movies"),
              
              h2("Created by: Zhanna Voloshina, Zach Holle, Anushree Shukla, Shawn Xu, Andy Johnson "),
              br(),
              p("Our interactive platform allows you to explore information about current actors, top current movies,
                              ratings of movies by time, and more! Click through our interactive visualizations to find out more! 
                              ")
              
              
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
                           "Top Actor/Actress He/She Worked With",
                           min = 1,
                           max = 16,
                           value = 10)
             ),
             
             # Show a plot of the generated wordcloud
             mainPanel(
               div(
                 plotOutput("plot")
               )
             )
           )
  ),
  
  tabPanel('Movies By Rating',
           # title of page
           titlePanel("Movies By Rating"),
           
           # create side panel which contains one widgets 
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
  ),
  
  tabPanel('Movies By Language',
           
           # title of the page
           titlePanel("Movies by Language"),
           
           sidebarPanel(
             # drop down widget to selec language
             selectInput(inputId = "lang",
                         label = "Select a Language",
                         choices = c("English", "Hindi", "Italian", "Japanese", "Greek", "French"), selected = "English")
           ),
           
           # Show a scatter plot of the generated distribution
           mainPanel(
             plotlyOutput("scatter")
           )
           
  )
))





