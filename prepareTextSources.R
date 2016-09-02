setwd("~/projects/capstone")
source("requirements.R")

convert_text_to_sentences <- function(text, lang = "en") {
  # Function to compute sentence annotations using the Apache OpenNLP Maxent sentence detector employing the default model for language 'en'. 
  sentence_token_annotator <- openNLP::Maxent_Sent_Token_Annotator(language = lang)
  
  # Convert text to class String from package NLP
  text <- NLP::as.String(text)
  
  # Sentence boundaries in text
  sentence.boundaries <- NLP::annotate(text, sentence_token_annotator)
  
  # Extract sentences
  sentences <- text[sentence.boundaries]
  
  # return sentences
  return(sentences)
}

removeHashtags <- function (x){
  gsub("#\\S+", "", x)
}

removeNumbers <- function(x){
  gsub("\\d+", "", x, perl = TRUE)
}

removeUnicode <- function (x){
  gsub("([^a-zA-Z\\s])", "", x, perl = TRUE)
}

replaceWWWs <- function (x){
  gsub("www\\S+", "website", x)
}

processTextFile <- function(filename){
  text <- readLines(filename, skipNul = TRUE)
  text <- parLapply(cluster,text, convert_text_to_sentences)
  
  text <- parLapply(cluster,text, tolower)
  text <- parLapply(cluster,text, removeHashtags)
  text <- parLapply(cluster,text, removeUnicode)
  text <- parLapply(cluster,text, replaceWWWs)
  text <- parLapply(cluster,text, removeNumbers)
  
  text <- as.vector(unlist(text))
}

scrubbedTextLinesFileConnection <- file(scrubbedTextLinesFile, "w")

cluster<-makeCluster(cores)

twitter <- processTextFile(twitterFile)
writeLines(twitter, scrubbedTextLinesFileConnection)
rm(twitter)
gc()
news <- processTextFile(newsFile)
writeLines(news, scrubbedTextLinesFileConnection)
rm(news)
gc()
blogs <- processTextFile(blogsFile)
writeLines(blogs, scrubbedTextLinesFileConnection)
rm(blogs)
gc()

stopCluster(cluster)

close.connection(scrubbedTextLinesFileConnection)