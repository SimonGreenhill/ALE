#' ---
#' title: "ALE Concept 8: Fog"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("8_alignment_fog.R")

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
plot_cognates("../manual/8_aligned_split.tsv", min = 20)

# show corrected data of alignment
# with speculative *BUIRUIMA reconstruction
data <- "../manual/8_aligned_lump.tsv"
plot_cognates(data, min = 20)

# ====================================

# B in nebel
plot_column(get_column(data, 2, 4))
title("Correspondences of 'B' in 'nebula'")

# L in nebel
plot_column(get_column(data, 2, 6))
title("Correspondences of 'L' in 'nebula'")

# IN in nebel
plot_column(get_column(data, 2, 9))
title("Correspondences of diminutive in 'nebula'")

# A in nebel
plot_column(get_column(data, 2, 10))
title("Correspondences of 'A' in 'nebula'")

# ====================================

# M in megula
plot_column(get_column(data, 4, 2))
title("Correspondences of 'M' in 'megula'")

# G in megula
g1 <- get_column(data, 4, 1)
g2 <- get_column(data, 4, 4)
g3 <- get_column(data, 4, 7)
G <- merge_columns(g1, merge_columns(g2, g3))
plot_column(G)
title("Correspondences of 'G' in 'megula'")

# L in megula
plot_column(get_column(data, 4, 6))
title("Correspondences of 'L' in 'megula'")

# T in megula
plot_column(get_column(data, 4, 14))
title("Correspondences of 'T' in 'meg-T'")

# show Session Info
sessionInfo()
