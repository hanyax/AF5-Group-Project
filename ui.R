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
                    font-size: 24px;
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
               
               # Since the API limits the number of call made in short period of time, 
               # the program will crash becuase the api call 
               # is rejected if the slidebar is moved too often. 
               # Please allow about 5 seconds bewteen each move of the slide bar.
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
  
  tabPanel('Actor/Actress Career Arc',
           # title of page
           titlePanel("Timeline of Movie Popularities"),
           
           # create side panel which contains one widgets 
           sidebarLayout(
             sidebarPanel(
               fluidPage(
                 
                 # Copy the line below to make a text input box
                 textInput("text", label = h3("Actor/Actress FullName"), value = "Emma Stone"),
                 
                 hr(),
                 fluidRow(column(3, verbatimTextOutput("value")))
                 
               )
             ),
             
             # Show a plot of the Time vs. popularity of Movies
             mainPanel(
               plotlyOutput("scatterAndLine")
             )
  )),
  
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
           
  ),
  
  tabPanel("Movies By Year and Genre",
           titlePanel("Top 10 Movies By Year and Genre"),
           
           sidebarPanel(
             selectInput("year", label = h3("Select Year"),
                         choices = rev(list("1900" = "1900", "1901" = "1901", "1902" = "1902", "1903" = "1903", "1904" = "1904", 
                                            "1905" = "1905", "1906" = "1906", "1907" = "1907", "1908" = "1908", "1909" = "1909",
                                            "1910" = "1910", "1911" = "1911", "1912" = "1912", "1913" = "1913", "1914" = "1914",
                                            "1915" = "1915", "1916" = "1916", "1917" = "1917", "1918" = "1918", "1919" = "1919",
                                            "1920" = "1920", "1921" = "1921", "1922" = "1922", "1923" = "1923", "1924" = "1924",
                                            "1925" = "1925", "1926" = "1926", "1927" = "1927", "1928" = "1928", "1929" = "1929",
                                            "1930" = "1930", "1931" = "1931", "1932" = "1932", "1933" = "1933", "1934" = "1934", 
                                            "1935" = "1935", "1936" = "1936", "1937" = "1937", "1938" = "1938", "1939" = "1939",
                                            "1940" = "1940", "1941" = "1941", "1942" = "1942", "1943" = "1943", "1944" = "1944", 
                                            "1945" = "1945", "1946" = "1946", "1947" = "1947", "1948" = "1948", "1949" = "1949",
                                            "1950" = "1950", "1951" = "1951", "1952" = "1952", "1953" = "1953", "1954" = "1954", 
                                            "1955" = "1955", "1956" = "1956", "1957" = "1957", "1958" = "1958", "1959" = "1959",
                                            "1960" = "1960", "1961" = "1961", "1962" = "1962", "1963" = "1963", "1964" = "1964", 
                                            "1965" = "1965", "1966" = "1966", "1967" = "1967", "1968" = "1968", "1969" = "1969",
                                            "1970" = "1970", "1971" = "1971", "1972" = "1972", "1973" = "1973", "1974" = "1974", 
                                            "1975" = "1975", "1976" = "1976", "1977" = "1977", "1978" = "1978", "1979" = "1979",
                                            "1980" = "1980", "1981" = "1981", "1982" = "1982", "1983" = "1983", "1984" = "1984", 
                                            "1985" = "1985", "1986" = "1986", "1987" = "1987", "1988" = "1988", "1989" = "1989",
                                            "1990" = "1990", "1991" = "1991", "1992" = "1992", "1993" = "1993", "1994" = "1994", 
                                            "1995" = "1995", "1996" = "1996", "1997" = "1997", "1998" = "1998", "1999" = "1999",
                                            "2000" = "2000", "2001" = "2001", "2002" = "2002", "2003" = "2003", "2004" = "2004",
                                            "2005" = "2005", "2006" = "2006", "2007" = "2007", "2008" = "2008", "2009" = "2009",
                                            "2010" = "2010", "2011" = "2011", "2012" = "2012", "2013" = "2013", "2014" = "2014",
                                            "2015" = "2015", "2016" = "2016", "2017" = "2017")),
                         selected = "2017"),
             
             selectInput("genre", label = h3("Select Genre"),
                         choices = list("Action" = "28", "Adventure" = "12", "Animation" = "16",
                                        "Comedy" = "35", "Crime" = "80", "Documentary" = "99", "Drama" = "18", 
                                        "Family" = "10751", "Fantasy" = "14", "History" = "36", "Horror" = "27", 
                                        "Music" = "10402", "Mystery" = "9648", "Romance" = "10749", 
                                        "Science Fiction" = "878", "TV Movie" = "10770", "Thriller" = "53", 
                                        "War" = "10752", "Western" = "37"),
                         selected = "28")
             
             
           ),
           
           mainPanel(
             tableOutput("table")
           )
  )
  
))





