setwd("~/projects/capstone")
source("requirements.R")

buildNGrams <- function(myCorpus, n=1){
  switch (n,
    1 = buildUnigrams(myCorpus = myCorpus),
    2 = buildBigrams(myCorpus = myCorpus),
    3 = buildTrigrams(myCorpus = myCorpus),
    4 = buildQuadgrams(myCorpus = myCorpus),
    5 = buildPentagrams(myCorpus = myCorpus)
  )
}

buildUnigrams <- function(myCorpus){
  unigramTDM <- TermDocumentMatrix(myCorpus, control = list())
  saveRDS(unigramTDM, "data/unigramTDM.rds")
  unigramFrequency <- findTermFrequency(unigramTDM)
  saveRDS(unigramFrequency, "data/unigramFrequency.rds")
  rm(unigramFrequency)
  rm(unigramTDM)
}

buildBigrams <- function(myCorpus){
  bigramTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = bigramTokenizer))
  saveRDS(bigramTDM, "data/bigramTDM.rds")
  bigramFrequency <- findTermFrequency(bigramTDM)
  saveRDS(bigramFrequency, "data/bigramFrequency.rds")
  rm(bigramFrequency)
  rm(bigramTDM)
}

buildTrigrams <- function(myCorpus){
  trigramTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = trigramTokenizer))
  saveRDS(trigramTDM, "data/trigramTDM.rds")
  trigramFrequency <- findTermFrequency(trigramTDM)
  saveRDS(trigramFrequency, "data/trigramFrequency.rds")
  rm(trigramFrequency)
  rm(trigramTDM)
}

buildQuadgrams <- function(myCorpus){
  quadgramTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = quadgramTokenizer))
  saveRDS(quadgramTDM, "data/quadgramTDM.rds")
  quadgramFrequency <- findTermFrequency(quadgramTDM)
  saveRDS(quadgramFrequency, "data/quadgramFrequency.rds")
  rm(quadgramFrequency)
  rm(quadgramTDM)
}

buildPentagrams <- function(myCorpus){
  pentagramTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = pentagramTokenizer))
  saveRDS(pentagramTDM, "data/pentagramTDM")
  pentagramFrequency <- findTermFrequency(pentagramTDM)
  saveRDS(pentagramFrequency, "data/pentagramFrequency")
  rm(pentagramFrequency)
  rm(pentagramTDM)
}

ngramTokenizer <- function(x,y=2){
  options(warn = -1)
  #theNgrams <- NLP::ngrams(x,n= y)
  sentences <- qdap::sent_detect_nlp(as.character(x))
  theNgrams <- qdap::ngrams(sentences,n= y)
  theNgrams <- theNgrams$all_n[[paste("n_", y, sep="")]]
  theNgrams <- lapply(theNgrams, paste, collapse=" ")
  options(warn = 0)
  unlist(theNgrams)
}

trigramTokenizer <- function(x, y=3){
  ngramTokenizer(x,y)
}
bigramTokenizer <- function(x, y=2){
  ngramTokenizer(x,y)
}
quadgramTokenizer <- function(x, y=4){
  ngramTokenizer(x,y)
}
pentagramTokenizer <- function(x, y=5){
  ngramTokenizer(x,y)
}

findTermFrequency <- function(x){
  capture.output(
    {
      temp<-inspect(x)
      freqs <- data.frame(Term=rownames(temp), Freq=rowSums(temp))
    }, file="/dev/null")
  freqs
}

myCorpus <- readRDS("data/myCorpus.rds")

#buildNGrams(myCorpus = myCorpus, n = 1)
#buildNGrams(myCorpus = myCorpus, n = 2)
#buildNGrams(myCorpus = myCorpus, n = 3)
#buildNGrams(myCorpus = myCorpus, n = 4)
#buildNGrams(myCorpus = myCorpus, n = 5)

