require(tm)
#require(rJava)
#require(NLP)
#require(openNLP)
#require(RWeka)
require(qdap)

countColumnFrequency <- function (frequencyTable){
  frequencyCount <- colSums(as.data.frame(frequencyTable$Freq))
  as.numeric(frequencyCount)
}

lookupTerm <- function (searchTerm, frequencyTable){
  searchTerm <- tolower(searchTerm)
  #searchTerm <- strsplit(searchTerm, " ")[[1]]
  regexTerm <- paste("(^",searchTerm,")($|\\s)",sep="")
  resultTable <- frequencyTable[grepl(regexTerm,frequencyTable$Term),]
  resultTable[order(resultTable$Freq),]
  
  resultTable
}

stripSparseEntries <- function (frequencyTable, minimumFrequency){
  temp <- frequencyTable[frequencyTable$Freq >= minimumFrequency,]
  temp <- droplevels(temp)
  temp
}

stripUnicode <- function (frequencyTable){
  temp <- frequencyTable[!grepl("[^a-z\\s]",frequencyTable$Term,perl = TRUE),]
  #temp <- frequencyTable[!grepl("[^[:alnum::space:]]",frequencyTable$Term),]
  temp <- droplevels(temp)
  temp
}

setwd("~/projects/capstone")

unigramTDMFile <- "unigramTDM.rds"
unigramFrequencyFile <- "unigramFrequency.rds"
bigramTDMFile <- "bigramTDM.rds"
bigramFrequencyFile <- "bigramFrequency.rds"
trigramTDMFile <- "trigramTDM.rds"
trigramFrequencyFile <- "trigramFrequency.rds"

unigramFrequency <- readRDS(unigramFrequencyFile)
bigramFrequency <- readRDS(bigramFrequencyFile)
trigramFrequency <- readRDS(trigramFrequencyFile)

strippedUnigramFrequency <- stripSparseEntries(unigramFrequency,3)
strippedBiGramFrequency <- stripSparseEntries(bigramFrequency, 3)
strippedTrigramFrequecy <- stripSparseEntries(trigramFrequency, 3)

strippedUnigramFrequency <- stripUnicode(strippedUnigramFrequency)
strippedBiGramFrequency <- stripUnicode(strippedBiGramFrequency)
strippedTrigramFrequecy <- stripUnicode(strippedTrigramFrequecy)

#fullCount <- countColumnFrequency(unigramFrequency)
#strippedCount <- countColumnFrequency(strippedUnigramFrequency)