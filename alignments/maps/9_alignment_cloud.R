#' ---
#' title: "ALE Concept 9: cloud"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("9_alignment_cloud.R")

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
data <- "../manual/9_aligned_split.tsv"
plot_cognates(data, min = 20)

# ====================================

# W in wolk
plot_column(get_column(data, 2, 1))
title("Correspondences of 'W' in 'wolk'")

# O in wolk
plot_column(get_column(data, 2, 2))
title("Correspondences of 'O' in 'wolk'")

# schwa in wolek
plot_column(get_column(data, 2, 4))
title("Correspondences of schwa in 'wolEk'")

# K in wolk
plot_column(get_column(data, 2, 5))
title("Correspondences of 'K in 'wolk'")

# E in wolk
plot_column(get_column(data, 2, 6))
title("Correspondences of schwa in 'wolkE'")

# show Session Info
sessionInfo()
