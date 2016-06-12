#' ---
#' title: "ALE Concept 346: Nail"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("346_alignment_nail.R")

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

# show corrected data of alignment
# lots of missing data from France, Sweden and Finland, Russia, Yugoslavia
data <- "../manual/346_aligned.tsv"
plot_cognates(data, min = 20)

# ====================================

# N in nail
plot_column(get_column(data, 4, 1))
title("Correspondences of 'N' in 'nail'")

# G in nail
plot_column(get_column(data, 4, 3))
title("Correspondences of 'G' in 'nail'")

# L in nail
plot_column(get_column(data, 4, 5))
title("Correspondences of 'L' in 'nail'")

# ====================================

# G in gvusts
plot_column(get_column(data, 32, 1))
title("Correspondences of 'G' in 'gvusts'")

# V in gvusts
plot_column(get_column(data, 32, 3))
title("Correspondences of 'V' in 'gvusts'")

# S in gvusts
plot_column(get_column(data, 32, 5))
title("Correspondences of 'S' in 'gvusts'")

# show Session Info
sessionInfo()
