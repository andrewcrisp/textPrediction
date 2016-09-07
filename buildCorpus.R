setwd("~/projects/capstone")
source("requirements.R")

removeHashtags <- function (x){
  gsub("#\\S+", "", x)
}

removeUnicode <- function (x){
  gsub("([^a-z\\s])", "", x, perl = TRUE)
}

replaceWWWs <- function (x){
  gsub("www\\S+", "website", x)
}

myLines <- readLines(scrubbedTextLinesFile)

myCorpus <- VCorpus(VectorSource(myLines), readerControl = list(
  reader=readPlain, 
  language="en_US" 
  #load=TRUE
))

#funs <- list(stripWhitespace,
#             removePunctuation,
#             removeNumbers,
#             content_transformer(tolower))
#funs <- list(stripWhitespace)
#myCorpus <- tm_map(myCorpus, content_transformer(removeHashtags))
#myCorpus <- tm_map(myCorpus, content_transformer(replaceWWWs))
#myCorpus <- tm_map(myCorpus, FUN=tm_reduce, tmFuns=funs)
#myCorpus <- tm_map(myCorpus, content_transformer(removeUnicode))
#myCorpus <- tm_map(myCorpus, tm::stripWhitespace)
#myCorpus <- tm_map(myCorpus, removeWords, myStopwords)

saveRDS(myCorpus,scrubbedCorpusFile)