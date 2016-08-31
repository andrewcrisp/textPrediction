setwd("~/projects/capstone")
source("requirements.R")
source("frequencyBuilder.R")

buildNGrams(myCorpus = myCorpus, prefix = "uni", tokenizer = unigramTokenizer)
buildNGrams(myCorpus = myCorpus, prefix = "bi", tokenizer = bigramTokenizer)
