#' ---
#' title: "ALE base map"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("manualMap.R")

# load libraries
library(qlcVisualize)
library(maptools)
source("code/mappingAlignments.R")

# load doculects
places <- read.delim("data/places.tsv", quote = "")

# load manually prepared window
border <- maptools::readShapePoly("gis/boundary.shp"
				, proj4string = CRS("+proj=longlat +datum=WGS84")
				)
plot(border)

# make voronoi map
v <- voronoi(places[,6:5], spatstat::as.owin(border))
plot(v)

# colour families
cols <- sample(rainbow(nlevels(places$LanguageGroup)))
vmap(v, col = cols[places$LanguageGroup], border = NA)
legend("bottomright", legend = levels(places$LanguageGroup), fill = cols, cex = .5)

# load corrected data
# higly speculative *SOLN reconstruction

data <- "alignments/1_aligned2.tsv"
plot_cognates(data)

# S in sun
plot_column(get_column(data, 2, 1))
title("Correspondences of 'S' in 'sun'")

# L in sun
L1 <- get_column(data,2,3)
L2 <- get_column(data,2,5)
L <- merge_columns(L1, L2) 
plot_column(L)
title("Correspondences of 'L' in 'sun'")

# N in sun
plot_column(get_column(data, 2, 7))
title("Correspondences of 'N' in 'sun'")

# TS in sun
plot_column(get_column(data, 2, 4))
title("Correspondences of 'U' in 'sun'")


### TODO
# add "asp" option in vmap
# add possibility to add "outer" points in window

# show Session Info
sessionInfo()
