#setwd("~/projects/capstone/product/TextPrediction/")
source("requirements.R")

lookupTerm <- function (searchTerm){
  searchTerm <- buildSearchTerm(searchTerm)
  
  theNgrams <- strsplit(searchTerm, " ")[[1]]
  if(length(theNgrams)>3){
    theNgrams <- theNgrams[(length(theNgrams)-2):length(theNgrams)]
    searchTerm <- paste(theNgrams, collapse=" ")
  }
  regexTerm <- paste("(",searchTerm," )",sep="")
  ngramCount <- length(theNgrams)
  while(ngramCount < 3){
    regexTerm <- paste("(\\w+ )", regexTerm, sep="")
    ngramCount = ngramCount + 1
  }
  regexTerm <- paste("(^",searchTerm,")($|\\s)",sep="")
  
  if(grepl("^[a-l]", strsplit(searchTerm, "")[[1]][1])){
    quadgramFrequency <- aToLQuadgramFrequency
  } else {
    quadgramFrequency <- mToZQuadgramFrequency
  }
  
  frequencyTable <- switch(
   length(theNgrams),
   bigramFrequency,
   trigramFrequency,
   quadgramFrequency
   #pentagramFrequency
  )

  resultTable <- droplevels(data.frame(frequencyTable[grepl(regexTerm,frequencyTable$Term),], stringsAsFactors = FALSE))
  resultTable <- resultTable[order(resultTable$Freq, decreasing = TRUE),]
  resultTable$Percentage <- resultTable$Freq / sum(resultTable$Freq)*100
  resultTable <- head(resultTable, 3)
  if(length(theNgrams)>1){
    resultTable <- rbind(resultTable, lookupTerm(shrinkSearchTerm(searchTerm)))
  }
  rownames(resultTable) <- NULL
  droplevels(resultTable)
}

predictMostLikely <- function(resultsTable){
  mostLikely = resultsTable[resultsTable$Percentage ==max(resultsTable$Percentage),1]
  as.character(mostLikely)
}

shrinkSearchTerm <- function(searchTerm){
  theNgrams <- strsplit(searchTerm, " ")[[1]]
  if(length(theNgrams) <=1 ){ return("")}
  theNgrams <- theNgrams[2:length(theNgrams)]
  searchTerm <- paste(theNgrams, collapse=" ")
  searchTerm
}

buildSearchTerm <- function (searchTerm){
  searchTerm <- gsub(pattern = "\\s$", replacement = "", x = searchTerm)
  searchTerm <- tolower(searchTerm)
  searchTerm <- tm::removePunctuation(searchTerm)
  searchTerm <- tm::removeNumbers(searchTerm)
  searchTerm
}

unigramFrequency <- readRDS(unigramModelFile)
bigramFrequency <- readRDS(bigramModelFile)
trigramFrequency <- readRDS(trigramModelFile)
#quadgramFrequency <- readRDS(quadgramModelFile)

aToLQuadgramFrequency <- readRDS(aToLQuadgramModelFile)
mToZQuadgramFrequency <- readRDS(mToZQuadgramModelFile)

#pentagramFrequency <- readRDS(pentagramModelFile)
