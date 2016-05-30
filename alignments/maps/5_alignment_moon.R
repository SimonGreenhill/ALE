#' ---
#' title: "ALE Concept 5: Moon"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("5_alignment_moon.R")

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
plot_cognates("../manual/5_aligned_split.tsv")

# show corrected data of alignment
# with speculative *MVNSVC reconstruction
data <- "../manual/5_aligned_lump.tsv"
plot_cognates(data)

# ====================================

# N in mond
plot_column(get_column(data, 2, 3))
title("Correspondences of 'N' in 'mond'")

# the 'n' in polish should probably be linked to this one, via metathesis
# MONS > MESON
N1 <- get_column(data,2,3)
N2 <- get_column(data,2,8)
N <- merge_columns(N1, N2) 
plot_column(N)
title("Correspondences of 'N' in 'mond'")

# S in mond
plot_column(get_column(data, 2, 5))
title("Correspondences of 'S' in 'mond'")

# T/C in mond
plot_column(get_column(data, 2, 9))
title("Correspondences of T in 'mond'")

# =========

# Vowels
plot_column(get_column(data, 2, 2))
title("Correspondences of first vowel")

plot_column(get_column(data, 2, 4))
title("Correspondences of second vowel")

plot_column(get_column(data, 2, 7))
title("Correspondences of third vowel")

# =========

# L in lune
plot_column(get_column(data, 5, 1))
title("Correspondences of 'L' in 'lune'")

# U in lune
plot_column(get_column(data, 5, 2))
title("Correspondences of 'U' in 'lune'")

# E in lune
plot_column(get_column(data, 5, 4))
title("Correspondences of 'E' in 'lune'")

# =========

# show Session Info
sessionInfo()
