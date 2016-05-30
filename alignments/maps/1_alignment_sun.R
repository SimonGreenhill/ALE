#' ---
#' title: "ALE Concept 1: Sun"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("1_alignment_sun.R")

# ====================================

# load libraries
library(qlcVisualize)
library(qlcData)
library(maptools)

# load ad-hoc functions
source("../../code/mappingAlignments.R")

# load doculects
places <- read.delim("../../data/places.tsv", quote = "")

# load voronoi diagram
load("../../data/voronoi.Rdata")

# ====================================

# show cognate sets of 'split' version
plot_cognates("../manual/1_aligned_split.tsv")

# show corrected data of alignment
# with speculative *SOLN reconstruction
data <- "../manual/1_aligned_lump.tsv"
plot_cognates(data)

# ====================================

# S in sun
plot_column(get_column(data, 2, 1))
title("Correspondences of 'S' in 'sun'")

# L in sun
L1 <- get_column(data,2,3)
L2 <- get_column(data,2,5)
L <- merge_columns(L1, L2) 
plot_column(L)
title("Correspondences of 'L' in 'sun'")

# L metathesis
plot_column(L1)
title("Metathesis of 'L' in 'sun'")

# N in sun
plot_column(get_column(data, 2, 7))
title("Correspondences of 'N' in 'sun'")

# Vowel in sun
plot_column(get_column(data, 2, 4))
title("Correspondences of vowel in 'sun'")

# Recoding Vowel
vowel <- get_column(data, 2, 4)
write.recoding(vowel, file = "../../sandbox/1_vowel_sun.yml")
# manually change recoding file
vowel <- recode(vowel, "1_vowel_sun.yml")
plot_column(vowel)
title("Simplified correspondences of vowel in 'sun'")

# ====================================

# show Session Info
sessionInfo()
