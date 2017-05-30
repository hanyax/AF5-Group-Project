source("../ActorCloud/findCoActor.R")
library(wordcloud)

buildWordCloud <- function(name, topN) {
  names <- toDataframe(name, topN)
  p <- wordcloud(names$actorNames, scale=c(3,1),
            freq = names$count, min.freq = 1, max.words=topN,
            colors=brewer.pal(8, "Dark2"))
  return(p)
}
