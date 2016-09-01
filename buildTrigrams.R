setwd("~/projects/capstone")
source("requirements.R")
source("frequencyBuilderWithSentenceDetect.R")

buildNGrams(myCorpus = myCorpus, prefix = "tri", tokenizer = trigramTokenizer)