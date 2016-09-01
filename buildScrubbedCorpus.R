setwd("~/projects/capstone")
source("requirements.R")

scrubLines <- function(myLines){
  scrubbedLines <- lapply(myLines, qdap::sent_detect)
  scrubbedLines <- unlist(scrubbedLines)
  
  scrubbedLines
}

blogs <- readLines(blogsFile)
news <- readLines(newsFile)
twitter <- readLines(twitterFile)

blogs <- scrubLines(blogs)
news <- scrubLines(news)
twitter <- scrubLines(twitter)

myCorpus <- VCorpus(VectorSource(c(blogs,news,twitter)))

removeHashtags <- function (x){
  gsub("#\\S+", "", x)
}

removeUnicode <- function (x){
  gsub("([^a-z\\s])", "", x, perl = TRUE)
}

replaceWWWs <- function (x){
  gsub("www\\S+", "website", x)
}

funs <- list(stripWhitespace,
             removePunctuation,
             removeNumbers,
             content_transformer(tolower))
myCorpus <- tm_map(myCorpus, content_transformer(removeHashtags))
myCorpus <- tm_map(myCorpus, content_transformer(replaceWWWs))
myCorpus <- tm_map(myCorpus, FUN=tm_reduce, tmFuns=funs)
myCorpus <- tm_map(myCorpus, content_transformer(removeUnicode))

saveRDS(myCorpus,"data/myScrubbedCorpus.rds")
