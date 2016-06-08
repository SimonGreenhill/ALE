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

### TODO
# add "asp" option in vmap
# add possibility to add "outer" points in window

# show Session Info
sessionInfo()
