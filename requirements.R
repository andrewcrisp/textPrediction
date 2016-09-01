require(tm)
#require(rJava)
require(NLP)
#require(openNLP)
#require(RWeka)
require(qdap)

rawDataDir <- "rawData/final/en_US"
dataDir <- "data"
corpusFile <- paste(dataDir,"/myCorpus.rds",sep="")
scrubbedCorpusFile <- paste(dataDir, "scrubbedCorpus.rd", sep="/")


blogsFile <- paste(rawDataDir,"en_US.blogs.txt",sep="/")
newsFile <- paste(rawDataDir,"en_US.news.txt",sep="/")
twitterFile <- paste(rawDataDir,"en_US.twitter.txt",sep="/")

scrubbedTextLinesFile <- paste(dataDir, "scrubbedLines.txt", sep="/")

#blogs <- readLines(paste(dataDir, blogsFile, sep="/"))
#news <- readLines(paste(dataDir, newsFile, sep="/"))
#twitter <- readLines(paste(dataDir, twitterFile, sep="/"))
