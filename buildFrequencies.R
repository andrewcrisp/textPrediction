setwd("~/projects/capstone")
source("requirements.R")

buildNGrams <- function(myCorpus, prefix, tokenizer){
  tdmFile <- paste(dataDir,"/",prefix,"gramTDM.rds",sep = "")
  frequencyFile <- paste(dataDir,"/",prefix,"gramFrequency.rds",sep = "")
  myTDM <- tm::TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  saveRDS(myTDM, tdmFile)
  myFrequency <- findTermFrequencies(myTDM)
  saveRDS(myFrequency, frequencyFile)
  rm(myTDM)
  rm(myFrequency)
  gc()
}

buildFrequencies <- function(prefix){
  tdmFile <- paste(dataDir,"/",prefix,"gramTDM.rds",sep = "")
  frequencyFile <- paste(dataDir,"/",prefix,"gramFrequency.rds",sep = "")
  myTDM <- readRDS(tdmFile)
  myFrequency <- slam::row_sums(myTDM)
  myFrequency <- data.frame(Term=names(myFrequency), Freq=myFrequency)
  saveRDS(myFrequency, frequencyFile)
  rm(myFrequency)
  gc()
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

findTermFrequencies <- function(tdm){
  myFrequency <- slam::row_sums(myTDM)
  myFrequency <- data.frame(Term=names(myFrequency), Freq=myFrequency)
  myFrequency
}
findTermFrequency <- function(tdm, term){
  capture.output(
    {
      temp <- tdm[term,]
      temp <- as.matrix(temp)
      freq <- rowSums(temp)
    }, file="/dev/null")
  freq
}

myCorpus <- readRDS(scrubbedCorpusFile)

buildNGrams(myCorpus = myCorpus, prefix = "uni", tokenizer = unigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "bi", tokenizer = bigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "tri", tokenizer = trigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "quad", tokenizer = quadgramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "penta", tokenizer = pentagramTokenizer)

#buildFrequencies("uni")
#buildFrequencies("bi")
#buildFrequencies("tri")
#buildFrequencies("quad")
#buildFrequencies("penta")
