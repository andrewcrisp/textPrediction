setwd("~/projects/capstone")
source("requirements.R")

lookupTerm <- function (searchTerm, frequencyTable){
  searchTerm <- tolower(searchTerm)
  #searchTerm <- strsplit(searchTerm, " ")[[1]]
  regexTerm <- paste("(^",searchTerm,")($|\\s)",sep="")
  #resultTable <- frequencyTable[grepl(regexTerm, frequencyTable)]
  resultTable <- frequencyTable[grepl(regexTerm,frequencyTable$Term),]
  resultTable[order(resultTable$Freq),]
  
  resultTable
}

buildSearchTerm <- function (phrase,n){
  searchWords <- unlist(unname(qdap::word_split(phrase)))
  searchWords <- searchWords[(length(searchWords)-(n-1)):length(searchWords)]
  searchWords <- paste(searchWords, collapse = " ")
  searchWords <- removePunctuation(searchWords)
  searchWords
}

unigramFrequency <- readRDS(unigramModelFile)
bigramFrequency <- readRDS(bigramModelFile)
trigramFrequency <- readRDS(trigramModelFile)
quadgramFrequency <- readRDS(quadgramModelFile)
pentagramFrequency <- readRDS(pentagramModelFile)
