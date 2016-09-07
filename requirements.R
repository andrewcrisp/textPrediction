#options(java.parameters = "-Xmx40g")

require(tm)
#require(rJava)
require(NLP)
require(openNLP)
#require(RWeka)
require(qdap)
require(parallel)

cores <- detectCores()-1
#cluster <- makeCluster(cores)
#stopCluster(cluster)
rawDataDir <- "rawData/final/en_US"
dataDir <- "data"
fallbackDataDir <- "fallbackDataDir"

corpusFile <- paste(dataDir,"/myCorpus.rds",sep="")
scrubbedCorpusFile <- paste(dataDir, "scrubbedCorpus.rds", sep="/")
fallbackCorpusFile <- paste(fallbackDataDir, "fallbackCorpus.rds", sep="/")
blogsFile <- paste(rawDataDir,"en_US.blogs.txt",sep="/")
newsFile <- paste(rawDataDir,"en_US.news.txt",sep="/")
twitterFile <- paste(rawDataDir,"en_US.twitter.txt",sep="/")

scrubbedTextLinesFile <- paste(dataDir, "scrubbedLines.txt", sep="/")

#blogs <- readLines(paste(dataDir, blogsFile, sep="/"))
#news <- readLines(paste(dataDir, newsFile, sep="/"))
#twitter <- readLines(paste(dataDir, twitterFile, sep="/"))
