setwd("~/projects/capstone")
source("requirements.R")

buildNGrams <- function(myCorpus, prefix, tokenizer){
  tdmFile <- paste(dataDir,"/",prefix,"gramTDM.rds",sep = "")
  frequencyFile <- paste(dataDir,"/",prefix,"gramFrequency.rds",sep = "")
  myTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
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
  #myFrequency <- findTermFrequencies(myTDM)
  saveRDS(myFrequency, frequencyFile)
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
  myTerms <- Terms(tdm)
  freqs <- data.frame(Term = myTerms, Freq = NA, row.names = myTerms)
  for (i in 1:length(myTerms)){
    freqs[myTerms[i]] <- findTermFrequency(tdm,myTerms[i])
  }
  freqs
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

#myCorpus <- readRDS(scrubbedCorpusFile)
# 
# tokenizer <- unigramTokenizer
# uniTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
# uniFrequency <- findTermFrequency(uniTDM)
# 
# tokenizer <- bigramTokenizer
# biTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
# biFrequency <- findTermFrequency(biTDM)
# 
# tokenizer <- trigramTokenizer
# triTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
# triFrequency <- findTermFrequency(triTDM)
# 
# tokenizer <- quadgramTokenizer
# quadTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
# quadFrequency <- findTermFrequency(quadTDM)
# 
# tokenizer <- pentagramTokenizer
# pentaTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
# pentaFrequency <- findTermFrequency(pentaTDM)

#buildNGrams(myCorpus = myCorpus, prefix = "uni", tokenizer = unigramTokenizer)
#buildNGrams(myCorpus = myCorpus, prefix = "bi", tokenizer = bigramTokenizer)
#buildNGrams(myCorpus = myCorpus, prefix = "tri", tokenizer = trigramTokenizer)
#buildNGrams(myCorpus = myCorpus, prefix = "quad", tokenizer = quadgramTokenizer)
#buildNGrams(myCorpus = myCorpus, prefix = "penta", tokenizer = pentagramTokenizer)


buildFrequencies("uni")
buildFrequencies("bi")
buildFrequencies("tri")
buildFrequencies("quad")
buildFrequencies("penta")
