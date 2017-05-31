source("../AF5-Group-Project/ActorCloud/findCoActor.R")
library(wordcloud)

buildWordCloud <- function(name, topN) {
  # get the co-actors names and co-start times dataframe
  names <- toDataframe(name, topN)
  # Display the name and use count as the scale of name display size
  p <- wordcloud(names$actorNames, scale=c(3,0.3),
            freq = names$count, min.freq = 1, max.words=topN,
            colors=brewer.pal(8, "Dark2"))
  return(p)
}
