setwd("~/projects/capstone")
source("requirements.R")

countColumnFrequency <- function (frequencyTable){
  frequencyCount <- colSums(as.data.frame(frequencyTable$Freq))
  as.numeric(frequencyCount)
}

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


unigramTDMFile <- paste(dataDir, "unigramTDM.rds", sep="/")
unigramFrequencyFile <- paste(dataDir, "unigramFrequency.rds", sep="/")
bigramTDMFile <- paste(dataDir, "bigramTDM.rds", sep="/")
bigramFrequencyFile <- paste(dataDir, "bigramFrequency.rds", sep="/")
trigramTDMFile <- paste(dataDir, "trigramTDM.rds", sep="/")
trigramFrequencyFile <- paste(dataDir, "trigramFrequency.rds", sep="/")

quadgramFrequencyFile <- paste(dataDir, "quadgramFrequency.rds", sep="/")
pentagramFrequencyFile <- paste(dataDir, "pentagramFrequency.rds", sep="/")

unigramFrequency <- readRDS(unigramFrequencyFile)
bigramFrequency <- readRDS(bigramFrequencyFile)
trigramFrequency <- readRDS(trigramFrequencyFile)
quadgramFrequency <- readRDS(quadgramFrequencyFile)
pentagramFrequency <- readRDS(pentagramFrequencyFile)

q1 <- "The guy in front of me just bought a pound of bacon, a bouquet, and a case of"
q2 <- "You're the reason why I smile everyday. Can you follow me please? It would mean the"
q3 <- "Hey sunshine, can you follow me and make me the"
q4 <- "Very early observations on the Bills game: Offense still struggling but the"
q5 <- "Go on a romantic date at the"
q6 <- "Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my"
q7 <- "Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some"
q8 <- "After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little"
q9 <- "Be grateful for the good times and keep the faith during the"
q10 <- "If this isn't the cutest thing you've ever seen, then you must be"

lookupTerm(buildSearchTerm(q1,4),pentagramFrequency)
# beer
lookupTerm(buildSearchTerm(q2,4),pentagramFrequency)
lookupTerm(buildSearchTerm(q3,4),pentagramFrequency)
lookupTerm(buildSearchTerm(q4,4),pentagramFrequency)
lookupTerm(buildSearchTerm(q5,4),pentagramFrequency)
lookupTerm(buildSearchTerm(q6,4),pentagramFrequency)
lookupTerm(buildSearchTerm(q7,4),pentagramFrequency)
lookupTerm(buildSearchTerm(q8,4),pentagramFrequency)
lookupTerm(buildSearchTerm(q9,4),pentagramFrequency)
lookupTerm(buildSearchTerm(q10,4),pentagramFrequency)



lookupTerm(buildSearchTerm(q1,4),pentagramFrequency)
# beer
lookupTerm(buildSearchTerm(q2,4),pentagramFrequency)
# world - 187
lookupTerm(buildSearchTerm(q3,4),pentagramFrequency)
# happiest - 2
lookupTerm(buildSearchTerm(q4,2),trigramFrequency)
# defense - 18 - Is the third best answer *
lookupTerm(buildSearchTerm(q5,2),trigramFrequency)
# beach - 531 - skipped quadgrams as only one hit on grocery appeared *
lookupTerm(buildSearchTerm(q6,3),quadgramFrequency)
# way - 35 - skipped pentagrams as it had two results at one hit each
lookupTerm(buildSearchTerm(q7,3),quadgramFrequency)
# time - 43
lookupTerm(buildSearchTerm(q8,1),bigramFrequency)
# fingers - 35 - Could be the indicator for a backoff algorithm idea
lookupTerm(buildSearchTerm(q9,1),bigramFrequency)
# bad - 2301 - Doesn't show up in the top 10...
lookupTerm(buildSearchTerm(q10,4),pentagramFrequency)
# insane - 8 - Doesn't show up in results in a good spot *

#resultTable <- resultTable[order(resultTable$Freq),]; resultTable
