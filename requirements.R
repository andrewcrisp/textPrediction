require(tm)
#require(rJava)
#require(NLP)
#require(openNLP)
#require(RWeka)
require(qdap)

rawDataDir <- "rawData/final/en_US"
dataDir <- "data"
corpusFile <- paste(dataDir,"/myCorpus.rds",sep="")

#blogsFile <- "en_US.blogs.txt"
#newsFile <- "en_US.news.txt"
#twitterFile <- "en_US.twitter.txt"

#blogs <- readLines(paste(dataDir, blogsFile, sep="/"))
#news <- readLines(paste(dataDir, newsFile, sep="/"))
#twitter <- readLines(paste(dataDir, twitterFile, sep="/"))
