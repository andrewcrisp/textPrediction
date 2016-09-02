setwd("~/projects/capstone")
source("requirements.R")

require(microbenchmark)
require(parallel)
myLines<-readLines("rawData/final/en_US/en_US.twitter.txt", n=50)

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
buildNGramsCompiled <- compiler::cmpfun(buildNGrams)

NLPngramTokenizer <- function(x,y=2){
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
QDAPngramTokenizer <- function(x,y=2){
  #options(warn = -1)
  #theNgrams <- NLP::ngrams(words(x),n= y)
  #sentences <- qdap::sent_detect_nlp(as.character(x))
  theNgrams <- qdap::ngrams(x,n= y)
  #theNgrams <- qdap::ngrams(x,n= y)
  theNgrams <- theNgrams$all_n[[paste("n_", y, sep="")]]
  theNgrams <- lapply(theNgrams, paste, collapse=" ")
  #options(warn = 0)
  unlist(theNgrams, use.names=FALSE)
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
  unlist(theNgrams)
}

compiledNgramTokenizer <- compiler::cmpfun(ngramTokenizer)

NLPunigramTokenizer <- function(x, y=1){
  NLPngramTokenizer(x,y)
}
NLPbigramTokenizer <- function(x, y=2){
  NLPngramTokenizer(x,y)
}
NLPtrigramTokenizer <- function(x, y=3){
  NLPngramTokenizer(x,y)
}
NLPquadgramTokenizer <- function(x, y=4){
  NLPngramTokenizer(x,y)
}
NLPpentagramTokenizer <- function(x, y=5){
  NLPngramTokenizer(x,y)
}

compiledunigramTokenizer <- compiler::cmpfun(function(x, y=1){
  compiledNgramTokenizer(x,y)
})
compiledbigramTokenizer <- compiler::cmpfun(function(x, y=2){
  compiledNgramTokenizer(x,y)
})
compiledtrigramTokenizer <- compiler::cmpfun(function(x, y=3){
  compiledNgramTokenizer(x,y)
})
compiledquadgramTokenizer <- compiler::cmpfun(function(x, y=4){
  compiledNgramTokenizer(x,y)
})
compiledpentagramTokenizer <- compiler::cmpfun(function(x, y=5){
  compiledNgramTokenizer(x,y)
})

QDAPunigramTokenizer <- function(x, y=1){
  QDAPngramTokenizer(x,y)
}
QDAPbigramTokenizer <- function(x, y=2){
  QDAPngramTokenizer(x,y)
}
QDAPtrigramTokenizer <- function(x, y=3){
  QDAPngramTokenizer(x,y)
}
QDAPquadgramTokenizer <- function(x, y=4){
  QDAPngramTokenizer(x,y)
}
QDAPpentagramTokenizer <- function(x, y=5){
  QDAPngramTokenizer(x,y)
}


findTermFrequency <- function(x){
  capture.output(
    {
      temp<-inspect(x)
      freqs <- data.frame(Term=rownames(temp), Freq=rowSums(temp))
    }, file="/dev/null")
  freqs
}

data("crude")
myCorpus <- crude

testQDAP <- function(){
  tokenizer <- QDAPunigramTokenizer
  QDAPuniTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  QDAPuniFrequency <- findTermFrequency(QDAPuniTDM)
  
  tokenizer <- QDAPbigramTokenizer
  QDAPbiTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  QDAPbiFrequency <- findTermFrequency(QDAPbiTDM)
  
  tokenizer <- QDAPtrigramTokenizer
  QDAPtriTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  QDAPtriFrequency <- findTermFrequency(QDAPtriTDM)
  
  tokenizer <- QDAPquadgramTokenizer
  QDAPquadTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  QDAPquadFrequency <- findTermFrequency(QDAPquadTDM)
  
  tokenizer <- QDAPpentagramTokenizer
  QDAPpentaTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  QDAPpentaFrequency <- findTermFrequency(QDAPpentaTDM)
}

testNLP <- function(){
  tokenizer <- NLPunigramTokenizer
  NLPuniTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  NLPuniFrequency <- findTermFrequency(NLPuniTDM)
  
  tokenizer <- NLPbigramTokenizer
  NLPbiTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  NLPbiFrequency <- findTermFrequency(NLPbiTDM)
  
  tokenizer <- NLPtrigramTokenizer
  NLPtriTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  NLPtriFrequency <- findTermFrequency(NLPtriTDM)
  
  tokenizer <- NLPquadgramTokenizer
  NLPquadTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  NLPquadFrequency <- findTermFrequency(NLPquadTDM)
  
  tokenizer <- NLPpentagramTokenizer
  NLPpentaTDM <- TermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  NLPpentaFrequency <- findTermFrequency(NLPpentaTDM)
}

compiledTermDocumentMatrix <- compiler::cmpfun(TermDocumentMatrix)
testCompiled <- function(){
  tokenizer <- compiledunigramTokenizer
  compileduniTDM <- compiledTermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  compileduniFrequency <- findTermFrequency(compileduniTDM)
  
  tokenizer <- compiledbigramTokenizer
  compiledbiTDM <- compiledTermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  compiledbiFrequency <- findTermFrequency(compiledbiTDM)
  
  tokenizer <- compiledtrigramTokenizer
  compiledtriTDM <- compiledTermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  compiledtriFrequency <- findTermFrequency(compiledtriTDM)
  
  tokenizer <- compiledquadgramTokenizer
  compiledquadTDM <- compiledTermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  compiledquadFrequency <- findTermFrequency(compiledquadTDM)
  
  tokenizer <- compiledpentagramTokenizer
  compiledpentaTDM <- compiledTermDocumentMatrix(myCorpus, control = list(tokenize = tokenizer))
  compiledpentaFrequency <- findTermFrequency(compiledpentaTDM)
}


reshape_corpusNames <- function(current.corpus, FUN, ...) {
  # Extract the text from each document in the corpus and put into a list
  text <- lapply(current.corpus, content)
  
  # Basically convert the text
  docs <- lapply(text, FUN, ...)
  docs <- as.vector(unlist(docs))
  
  # Create a new corpus structure and return it
  new.corpus <- Corpus(VectorSource(docs))
  return(new.corpus)
}

convert_text_to_sentencesNames <- function(text, lang = "en") {
  # Function to compute sentence annotations using the Apache OpenNLP Maxent sentence detector employing the default model for language 'en'. 
  sentence_token_annotator <- Maxent_Sent_Token_Annotator(language = lang)
  
  # Convert text to class String from package NLP
  text <- as.String(text)
  
  # Sentence boundaries in text
  sentence.boundaries <- annotate(text, sentence_token_annotator)
  
  # Extract sentences
  sentences <- text[sentence.boundaries]
  
  # return sentences
  return(sentences)
}
reshape_corpusNoNames <- function(current.corpus, FUN, ...) {
  # Extract the text from each document in the corpus and put into a list
  text <- lapply(current.corpus, content)
  
  # Basically convert the text
  docs <- lapply(text, FUN, ...)
  docs <- as.vector(unlist(docs, use.names=FALSE))
  
  # Create a new corpus structure and return it
  new.corpus <- Corpus(VectorSource(docs))
  return(new.corpus)
}

convert_text_to_sentencesNoNames <- function(text, lang = "en") {
  # Function to compute sentence annotations using the Apache OpenNLP Maxent sentence detector employing the default model for language 'en'. 
  sentence_token_annotator <- Maxent_Sent_Token_Annotator(language = lang)
  
  # Convert text to class String from package NLP
  text <- as.String(text)
  
  # Sentence boundaries in text
  sentence.boundaries <- annotate(text, sentence_token_annotator)
  
  # Extract sentences
  sentences <- text[sentence.boundaries]
  
  # return sentences
  return(sentences)
}

compiledConvertToSenteces <- compiler::cmpfun(convert_text_to_sentences)
compiledReshapeCorpus <- compiler::cmpfun(reshape_corpus)

buildCorpusCompiled <- function(){
  testCorpus <- crude
  testCorpus <- compiledReshapeCorpus(testCorpus, compiledConvertToSenteces)
}

buildCorpusNames <- function(){
  testCorpus <- crude
  testCorpus <- reshape_corpusNames(testCorpus, convert_text_to_sentencesNames)
}

buildCorpusNoNames <- function(){
  testCorpus <- crude
  testCorpus <- reshape_corpusNoNames(testCorpus, convert_text_to_sentencesNoNames)
}

testlapply<-function(){
  text <- lapply(myCorpus, content)
}
testmclapply<-function(){
  text <- mclapply(myCorpus, content, mc.cores = cores)
}

testMCSentences <- function(){
  text <- mclapply(myLines,convert_text_to_sentences)
  newCorpus <- Corpus(VectorSource(text))
}

testSentences <- function(){
  newCorpus <- VCorpus(VectorSource(myLines))
  newCorpus <- reshape_corpus(newCorpus, convert_text_to_sentences)
}

microbenchmark(testlapply(), testmclapply())

microbenchmark(buildCorpusCompiled(),buildCorpusNames(), buildCorpusNoNames())

microbenchmark(
  testQDAP(),
  testNLP(),
  testCompiled()
)
t1 <- function(){
  file1 <- scan(twitterFile, skipNul = TRUE)
}
t2 <- function(){
  file2 <- readLines(twitterFile, skipNul = TRUE)
}
microbenchmark(
 t1(), t2, times = 2 
 
)