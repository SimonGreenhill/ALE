# assumes voronoi-map 'v' and geographical data 'places'

plot_cognates <- function(file
					, min.freq = 30
					, voronoi = v
					, locations = places
					, font = "Linux Libertine O"
					) {
	
	# read file and map to places
	data <- read.delim(file)
	# remove multiple forms at random
	data <- data[sample(1:nrow(data)),]
	data <- data[!duplicated(data[,1]),]
	rownames(data) <- data[,1]
	data <- data[as.character(locations[,1]),]
	
	# select only frequent cognate sets
	cog <- data$COGID
	freq <- as.numeric(names(table(cog)[table(cog) < min.freq]))
	cog[cog %in% freq] <- max(cog, na.rm=T) + 1
	cog <- as.numeric(as.factor(cog))
	
	# plot map
	cols <- c(sample(rainbow(max(cog, na.rm = T) - 1)), "grey")
	vmap(v, col = cols[cog], border = NA)
	
	# make legend
	n <- paste0(data$Simplified, " (", data$COGID, ")")
	n [ duplicated(cog) | is.na (cog) | cog == max(cog) ] <- NA
	nums <- unique(cog[!is.na(n)])
	names <- na.omit(n)
	names <- as.character(names[order(nums)])
	names[max(nums)] <- "other"
	
	# plot legend
	par(family = font)
	legend("bottomright", legend = names, fill = cols, cex = .7)
	par(family = "")
	
}


get_column <- function(file
					, COGID
					, column
					, locations = places
					) {
	
	# read file
	data <- read.delim(file)

	# select COGID, remove duplicates
	cog <- data[which(data$COGID==COGID),]		
	cog <- cog[!duplicated(cog[,1]),]
	rownames(cog) <- cog[,1]
#	cog <- cog[as.character(locations[,1]),]
		
	# parse alignment
	align <- as.character(cog$Alignment)
	present <- which(!is.na(align))
	chars <- sapply( align[present], function(x) { strsplit(x," ")[[1]] } )
	
	# selelect column and map to places
	char <- chars[column, ]
	names(char) <- rownames(cog[present,])
	char <- char[as.character(locations[,1])]
	
	return(as.factor(char))
	
}

merge_columns <- function(col1, col2) {
	
	col1 <- as.character(col1)
	col2 <- as.character(col2)
	col1[col1=="-"|is.na(col1)] <- col2[col1=="-"|is.na(col1)]
	
	return(as.factor(col1))

}

plot_column <- function(column
						, voronoi = v
						, font ="Linux Libertine O"
						, size = .7
						) {
	
	cols <- sample(rainbow(nlevels(column)))
	chars <- levels(column)
	cols[chars == "-"] <- "grey"
	
	vmap(v, col = cols[as.numeric(column)], border = NA)
	
	par(family = font)
	
	nc <- 1
	if (length(chars) > 15) { nc <-  2 }
	legend("bottomright", legend = chars, fill = cols, cex = size, ncol = nc)
	par(family = "")

}