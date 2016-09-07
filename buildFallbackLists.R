setwd("~/projects/capstone")
require(tm)
require(NLP)

rawDataDir <- "rawData/final/en_US"
fallbackDataDir <- "fallbackData"
rawDataDir <- "rawData/final/en_US"
fallbackCorpusFile <- paste(fallbackDataDir, "fallbackCorpus.rds", sep="/")

blogsFile <- paste(rawDataDir,"en_US.blogs.txt",sep="/")
newsFile <- paste(rawDataDir,"en_US.news.txt",sep="/")
twitterFile <- paste(rawDataDir,"en_US.twitter.txt",sep="/")


buildNGrams <- function(myCorpus, prefix, tokenizer){
  tdmFile <- paste(fallbackDataDir,"/",prefix,"gramTDM.rds",sep = "")
  frequencyFile <- paste(fallbackDataDir,"/",prefix,"gramFrequency.rds",sep = "")
  myTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  saveRDS(myTDM, tdmFile)
  myFrequency <- findTermFrequency(myTDM)
  saveRDS(myFrequency, frequencyFile)
  rm(myTDM)
  rm(myFrequency)
  gc()
}

findTermFrequency <- function(x){
  capture.output(
    {
      temp<-as.matrix(x)
      freqs <- data.frame(Term=rownames(temp), Freq=rowSums(temp))
    }, file="/dev/null")
  freqs
}

ngramTokenizer <- function(x,y=2){
  #options(warn = -1)
  theNgrams <- NLP::ngrams(words(x),n= y)
  theNgrams <- lapply(theNgrams, paste, collapse=" ")
  #options(warn = 0)
  unlist(theNgrams, use.names=FALSE)
}

unigramTokenizer <- function(x, y=1){
  ngramTokenizer(x,y)
}
bigramTokenizer <- function(x, y=2){
  ngramTokenizer(x,y)
}
trigramTokenizer <- function(x, y=3){
  ngramTokenizer(x,y)
}
quadgramTokenizer <- function(x, y=4){
  ngramTokenizer(x,y)
}
pentagramTokenizer <- function(x, y=5){
  ngramTokenizer(x,y)
}


myCorpus <- VCorpus(DirSource(rawDataDir), readerControl = list(
  reader=readPlain, 
  language="en_US" 
  #load=TRUE
))

funs <- list(stripWhitespace,
             removePunctuation,
             removeNumbers,
             content_transformer(tolower))
myCorpus <- tm_map(myCorpus, FUN=tm_reduce, tmFuns=funs)
saveRDS(myCorpus, fallbackCorpusFile)
buildNGrams(myCorpus, "uni", unigramTokenizer)
buildNGrams(myCorpus, "bi", bigramTokenizer)
buildNGrams(myCorpus, "tri", trigramTokenizer)
buildNGrams(myCorpus, "quad", quadgramTokenizer)