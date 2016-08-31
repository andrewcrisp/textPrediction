require(tm)
require(rJava)
require(NLP)
require(openNLP)
require(RWeka)
require(qdap)

setwd("~/projects/capstone")

dataDir <- "rawData/final/en_US"
blogsFile <- "en_US.blogs.txt"
newsFile <- "en_US.news.txt"
twitterFile <- "en_US.twitter.txt"

wordAnnotator <- Maxent_Word_Token_Annotator()
sentenceAnnotator <- Maxent_Sent_Token_Annotator()

love <- 0
hate <- 0
biggestCount <- 0

blogs <- readLines(paste(dataDir, blogsFile, sep="/"))
news <- readLines(paste(dataDir, newsFile, sep="/"))
twitter <- readLines(paste(dataDir, twitterFile, sep="/"))

twitterCounts <- lapply(twitter, FUN=function(x) {
  count <- nchar(x)
  count
})
twitterLength <- length(twitterCounts)
twitterBiggest <- sort(as.numeric(twitterCounts))[twitterLength]

newsCounts <- lapply(news, FUN=function(x) {
  count <- nchar(x)
  count
})
newsLength <- length(newsCounts)
newsBiggest <- sort(as.numeric(newsCounts))[newsLength]

blogsCounts <- lapply(blogs, FUN=function(x) {
  count <- nchar(x)
  count
})
blogsLength <- length(blogsCounts)
blogsBiggest <- sort(as.numeric(blogsCounts))[blogsLength]

twitterBiggest
newsBiggest
blogsBiggest

loves <- lapply(twitter, function (x){ grepl("love", x)})
hates <- lapply(twitter, function (x){ grepl("hate", x)})
love <- sum(loves==TRUE)
hate <- sum(hates==TRUE)
love/hate

kickboxers <- lapply(twitter, function(x){grepl("A computer once beat me at chess, but it was no match for me at kickboxing", x)})
sum(kickboxers==TRUE)