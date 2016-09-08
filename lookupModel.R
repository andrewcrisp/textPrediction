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

stripUnicode <- function (frequencyTable){
  temp <- frequencyTable[!grepl("[^a-z\\s]",frequencyTable$Term,perl = TRUE),]
  #temp <- frequencyTable[!grepl("[^[:alnum::space:]]",frequencyTable$Term),]
  temp <- droplevels(temp)
  temp
}

unigramFrequency <- readRDS(unigramFrequencyFile)
bigramFrequency <- readRDS(bigramFrequencyFile)
trigramFrequency <- readRDS(trigramFrequencyFile)
quadgramFrequency <- readRDS(quadgramFrequencyFile)
pentagramFrequency <- readRDS(pentagramFrequencyFile)

uniSize <- object.size(unigramFrequency)
biSize <- object.size(bigramFrequency)
triSize <- object.size(trigramFrequency)
quadSize <- object.size(quadgramFrequency)
pentaSize <- object.size(pentagramFrequency)
sizes <- c("Uni"=uniSize, "Bi" = biSize, "tri"=triSize, "quad"=quadSize, "penta"=pentaSize) / (1024*1024)

newUnis <- stripSparseEntries(unigramFrequency, .95)
newBis <- stripSparseEntries(bigramFrequency, .70)
newTris <- stripSparseEntries(trigramFrequency, .50)
newQuads <- stripSparseEntries(quadgramFrequency, .15)
newPentas <- stripSparseEntries(pentagramFrequency, .50)

newuniSize <- object.size(newUnis)
newbiSize <- object.size(newBis)
newtriSize <- object.size(newTris)
newquadSize <- object.size(newQuads)
newpentaSize <- object.size(newPentas)
newsizes <- c("Uni"=newuniSize,
              "Bi" = newbiSize,
              "tri"=newtriSize,
              "quad"=newquadSize,
              "penta"=newpentaSize) / (1024*1024)
