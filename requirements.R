#options(java.parameters = "-Xmx40g")

require(tm)
#require(rJava)
require(NLP)
require(openNLP)
#require(RWeka)
#require(qdap)

require(slam)


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

unigramTDMFile <- paste(dataDir, "unigramTDM.rds", sep="/")
unigramFrequencyFile <- paste(dataDir, "unigramFrequency.rds", sep="/")
bigramTDMFile <- paste(dataDir, "bigramTDM.rds", sep="/")
bigramFrequencyFile <- paste(dataDir, "bigramFrequency.rds", sep="/")
trigramTDMFile <- paste(dataDir, "trigramTDM.rds", sep="/")
trigramFrequencyFile <- paste(dataDir, "trigramFrequency.rds", sep="/")

quadgramFrequencyFile <- paste(dataDir, "quadgramFrequency.rds", sep="/")
pentagramFrequencyFile <- paste(dataDir, "pentagramFrequency.rds", sep="/")

unigramModelFile <- paste(dataDir, "unigramModel.rds", sep="/")
bigramModelFile <- paste(dataDir, "bigramModel.rds", sep="/")
trigramModelFile <- paste(dataDir, "trigramModel.rds", sep="/")
quadgramModelFile <- paste(dataDir, "quadgramModel.rds", sep="/")
pentagramModelFile <- paste(dataDir, "pentagramModel.rds", sep="/")

#blogs <- readLines(paste(dataDir, blogsFile, sep="/"))
#news <- readLines(paste(dataDir, newsFile, sep="/"))
#twitter <- readLines(paste(dataDir, twitterFile, sep="/"))
