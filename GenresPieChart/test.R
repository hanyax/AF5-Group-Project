library("httr")
library("jsonlite")


# Bring in the API key and method for the movie database

response <- GET(")
body <- content(response,"text")
years <- fromJSON(body)
years

base.uri <- "https://api.themoviedb.org/3/discover/movie"
genre <- ""

# creates the whole district uri and returns the district number 
discover_key <- "&api-key=cc04f8a15efff3b286a9eb5a51308304"
DiscoverMovies <- function(genre) {
  sub.uri <- 'districts/locate/'
  uri <- paste0(base.uri, sub.uri)
  query.params <- list(zip = zipcode)
  response <- GET(uri, query = query.params)
  body <- content(response, "text")
  district.data <- fromJSON(body)
  return (district.data$results$district)
}


bestseller_key <- "&api-key=5e260a86a6301f55546c83a47d139b0d:3:68700045"
url <- "http://api.nytimes.com/svc/books/v2/lists/overview.json?published_date=2013-01-01"
req <- fromJSON(paste0(url, bestseller_key))
bestsellers <- req$results$list
category1 <- bestsellers[[1, "books"]]
subset(category1, select = c("author", "title", "publisher"))



def showHindiMovieREST(baseurl = 'https://api.themoviedb.org/3/discover/movie',
                       api_key = 'cc04f8a15efff3b286a9eb5a51308304',
                       format = 'json',
                       params={},
                       printurl = False
):
  params['api_key'] = api_key
params['format'] = format
if format == "json": params["nojsoncallback"]=True
url = baseurl + "?" + urllib.urlencode(params)
if printurl:
  print url
else:
  print url
return safeGet(url)