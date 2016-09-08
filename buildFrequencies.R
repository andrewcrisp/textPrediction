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

stripSparseEntries <- function (frequencyTable, percentageToRetain=1){
  if (percentageToRetain < 0){
    return(frequencyTable)
  }
  if (percentageToRetain >= 1){
    return(frequencyTable)
  }
  
  totalCount <- sum(frequencyTable$Freq)
  countToRetain <- totalCount * (percentageToRetain)
  countToRemove <- totalCount - countToRetain
  
  currentCount <- totalCount
  i <- 1
  while(currentCount > countToRetain){
    frequencyTable  <- frequencyTable[frequencyTable$Freq >i,]  
    currentCount <- sum(frequencyTable$Freq)
    i <- i + 1
  }
  frequencyTable<-droplevels(frequencyTable)
  frequencyTable
  
}

myCorpus <- readRDS(scrubbedCorpusFile)

buildNGrams(myCorpus = myCorpus, prefix = "uni", tokenizer = unigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "bi", tokenizer = bigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "tri", tokenizer = trigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "quad", tokenizer = quadgramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "penta", tokenizer = pentagramTokenizer)


unigramFrequency <- readRDS(unigramFrequencyFile)
bigramFrequency <- readRDS(bigramFrequencyFile)
trigramFrequency <- readRDS(trigramFrequencyFile)
quadgramFrequency <- readRDS(quadgramFrequencyFile)
pentagramFrequency <- readRDS(pentagramFrequencyFile)

newUnis <- stripSparseEntries(unigramFrequency, .95)
newBis <- stripSparseEntries(bigramFrequency, .70)
newTris <- stripSparseEntries(trigramFrequency, .50)
newQuads <- stripSparseEntries(quadgramFrequency, .15)
newPentas <- stripSparseEntries(pentagramFrequency, .50)

saveRDS(newUnis, unigramModelFile)
saveRDS(newBis, bigramModelFile)
saveRDS(newTris, trigramModelFile)
saveRDS(newQuads, quadgramModelFile)
saveRDS(newPentas, pentagramModelFile)

#buildFrequencies("uni")
#buildFrequencies("bi")
#buildFrequencies("tri")
#buildFrequencies("quad")
#buildFrequencies("penta")
