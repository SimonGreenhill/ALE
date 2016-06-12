#' ---
#' title: "Processing ALE data"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("manualData.R")

# load functions
library(qlcData)
library(qlcMatrix)
source("code/prepareData.R")

# ===============
# error checking based on clusters on original input
reportMissing(1:346)

# make raw profile
all <- sapply(1:346, read.ALE.words)
write.profile(unlist(all), file = "sandbox/ALEprofile.txt", normalize = "NFD", sep = "")

# make graphemic profile
# remove stress, parenthesis, ellipsis...
words <- gsub("['ˌ…\\(\\)†‿]","",unlist(all))
tok <- tokenize(words
				, profile = "data/ALEprofileNFDgraphemes.tsv"
				, file.out = "sandbox/ALEgraphemes"
				, sep = " "
				, silent = TRUE
				, normalize = "NFD"
				, regex = TRUE
				)
write.profile(tok$strings$tokenized, sep = " ", file = "sandbox/ALEgraphemes.txt")

# reduced profile, only minimal reduction in graphemes
# most graphemes arise because of combinations
tok <- tokenize(unlist(all)
				, profile = "data/ALEprofileNFDreduce.tsv"
				, sep = ""
				, silent = TRUE
				, normalize = "NFD"
				, regex = FALSE
				, transliterate = "Reduce"
				)
tok <- tokenize(tok$strings$transliterated
				, profile = "data/ALEprofileNFDgraphemes.tsv"
				, file.out = "sandbox/ALEgraphemes_reduce"
				, sep = " "
				, silent = TRUE
				, normalize = "NFD"
				, regex = TRUE
				)
write.profile(tok$strings$tokenized, sep = " ", file = "sandbox/ALEgraphemes_reduce.txt")


# =======================
# reduce and tokenize input, and simplify to simple IPA, make profile of grapheme clusters
# add quick and dirty cognate clustering and alignment using lingPy
tmp <- prepare(346, cutoff = 0.85)

# to see all intermediate steps, try this
# tmp <- prepare(1, full =  TRUE, cutoff = 0.85)

# many alignments
sapply(c(8,9), prepare)

# show Session Info
# sessionInfo()

