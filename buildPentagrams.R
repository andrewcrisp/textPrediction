setwd("~/projects/capstone")
source("requirements.R")
source("frequencyBuilder.R")

buildNGrams(myCorpus = myCorpus, prefix = "penta", tokenizer = pentagramTokenizer)