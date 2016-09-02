setwd("~/projects/capstone")
source("requirements.R")

buildNGrams <- function(myCorpus, prefix, tokenizer){
      tdmFile <- paste(dataDir,"/",prefix,"gramTDM.rds",sep = "")
  frequencyFile <- paste(dataDir,"/",prefix,"gramFrequency.rds",sep = "")
    myTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
    saveRDS(myTDM, tdmFile)
      myFrequency <- findTermFrequency(myTDM)
      saveRDS(myFrequency, frequencyFile)
        rm(myTDM)
        rm(myFrequency)
}

ngramTokenizer <- function(x,y=2){
      #options(warn = -1)
      theNgrams <- NLP::ngrams(words(x),n= y)
  #sentences <- qdap::sent_detect_nlp(as.character(x))
  #theNgrams <- qdap::ngrams(sentences,n= y)
  #theNgrams <- qdap::ngrams(x,n= y)
  #theNgrams <- theNgrams$all_n[[paste("n_", y, sep="")]]
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

findTermFrequency <- function(x){
      capture.output(
                         {
                                   temp<-inspect(x)
                               freqs <- data.frame(Term=rownames(temp), Freq=rowSums(temp))
                                   }, file="/dev/null")
  freqs
}

myCorpus <- readRDS(scrubbedCorpusFile)
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

buildNGrams(myCorpus = myCorpus, prefix = "uni", tokenizer = unigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "bi", tokenizer = bigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "tri", tokenizer = trigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "quad", tokenizer = quadgramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "penta", tokenizer = pentagramTokenizer)

