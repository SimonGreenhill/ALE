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
v <- voronoi(places[,c("Longitude", "Latitude")], spatstat::as.owin(border))
plot(v)
# save(v, file = "data/voronoi.Rdata")


# plotting families
familymap <- function(factor) {
	cols <- sample(rainbow(nlevels(factor)))
	vmap(v, col = cols[factor], border = NA)
	legend("bottomright", legend = levels(factor), fill = cols, cex = .5)
}

# plotting languages per family
languagemap <- function(family) {
	L <- places$Language
	L[places$LanguageGroup != family] <- NA
	L <- as.factor(as.character(L))
	familymap(L)
	title(family)
}

# maps
familymap(places$LanguageGroup)

invisible(sapply(levels(places$LanguageGroup), languagemap))

### TODO
# add "asp" option in vmap
# add possibility to add "outer" points in window

# show Session Info
sessionInfo()
