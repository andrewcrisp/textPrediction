setwd("~/projects/capstone")
source("requirements.R")
source("lookupModel.R")

q1 <- "When you breathe, I want to be the air for you. I'll be there for you, I'd live and I'd"
q2 <- "Guy at my table's wife got up to go to the bathroom and I asked about dessert and he started telling me about his"
q3 <- "I'd give anything to see arctic monkeys this"
q4 <- "Talking to your mom has the same effect as a hug and helps reduce your"
q5 <- "When you were in Holland you were like 1 inch away from me but you hadn't time to take a"
q6 <- "I'd just like all of these questions answered, a presentation of evidence, and a jury to settle the"
q7 <- "I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each"
q8 <- "Every inch of you is perfect from the bottom to the"
q9 <- "I’m thankful my childhood was filled with imagination and bruises from playing"
q10 <- "I like how the same people are in almost all of Adam Sandler's"


answersQ1 <- lookupTerm(q1)
#W 'give' - 9 hits in trigrams, 283 in bis
#C 'die' - 59 in bis
# 'eat' - 36 in bis
# die/eat/give/sleep - no answers show up in the results
answersQ2 <- lookupTerm(q2)
#W 'financial' - 68 in bis
#Q 'spiritual' - 32 in bis
# financial/horticultural/marital/spiritual - no answers show up in the results
answersQ3 <- lookupTerm(q3)
# 'month' - 4821 bis
#C 'weekend' - 10537 in bis
# 'decade' - 106 in bis
#W morning = 11850 in bis
# decade/month/weekend/morning -
answersQ4 <- lookupTerm(q4)
#C stress - 5 in quads
answersQ5 <- lookupTerm(q5)
#W look - 246 in quads, 1429 in tris
#C picture - 212 in quads, 507 in tris
# picture/walk/minute/look
answersQ6 <- lookupTerm(q6)
#W case - 19 quads, 21 tris
#C matter - 5 quads, 7 tries
# account/matter/incident/case
answersQ7 <- lookupTerm(q7)
#C 'hand' - 21 in tris
# finger/toe/hand/arm - no answers show up in the results
answersQ8 <- lookupTerm(q8)
#C top  - 10 in pentagram
answersQ9 <- lookupTerm(q9)
#C 'outside' - 62 in bis
# weekly/daily/inside/outside - no answers show up in the results
answersQ10 <- lookupTerm(q10)
#C Movies - just guessed... can't think of a way to do the prediction
# movies/pictures/novels/stories - ZERO RETURNED RESULTS
#mySizes <-sort(sapply(ls(),function(x){object.size(get(x))}))
# sum(round(mySizes/(1024*1024)))