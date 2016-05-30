# read place names

places <- read.delim("data/places.tsv", quote = "")

# ==========================
# read data from web service
# ==========================

read.ALE.words <- function(concept) {
	
	link <- paste0("http://ale.paralleltext.info/q/"
					, concept
					, "/tsv?terse=yes"
					)
					
	table <- try(read.table(link
							, sep="\t"
							, colClasses = "character"
							, quote = ""
							, header = FALSE
							, na.strings = "Not Available"
							), silent = TRUE)

	if (class(table) == "try-error") {
		table <- NULL
	} else {
		table <- na.omit(as.vector(table[,1]))
	}
	
	return(table)
}

read.ALE.full <- function(concept) {
	
	link <- paste0("http://ale.paralleltext.info/q/"
					, concept
					, "/tsv"
					)
					
	table <- try(read.table(link
							, sep = "\t"
							, colClasses = "character"
							, quote = ""
							, header = FALSE
							, na.strings = "Not Available"
							), silent = TRUE)

	if (class(table) == "try-error") {
		table <- NULL
	} else {
		colnames(table)[2] <- "ALEpointcodeOLD"
		table <- merge(places[,c(1,4,3)], table, by = "ALEpointcodeOLD")
		colnames(table) <- c("ID", "Place", "Group", "Word", "Concept", "Form")
	}

	return(table)
}

# =============================
# report errors on initial scan
# =============================

reportMissing <- function(concept, ... ) {
	
	for (i in concept) {
		
		words <- read.ALE.words(i)
		if (is.null(words)) { next }
		
		tokenize(words
				, profile = "data/ALEprofileNFDcheck.tsv"
				, file.out = paste0( "sandbox/", as.character(i) )
				, sep = ""
				, silent = TRUE
				, normalize = "NFD"
				, regex = TRUE
				, ...
				)
				
		file.remove(paste0("sandbox/", i, "_profile.tsv"))
		file.remove(paste0("sandbox/", i, "_strings.tsv"))
		
		if (!file.exists(paste0("sandbox/", i, "_missing.tsv"))) {
			cat("no problems with concept", i, "\n")
		} else {
			cat("missing characters in concept", i, "\n")
		}
	}
	
}

# =========================
# reduce and tokenize input
# =========================

prepare <- function(concept, full = FALSE, cutoff = 0.85) {
	
	words <- read.ALE.full(concept)
	
	# reduce possible errors in data
	reduced <- tokenize(words$Word
						, profile = "data/ALEprofileNFDreduce.tsv"
						, transliterate = "Reduce"
						, sep = ""
						, normalize = "NFD"
						)$strings$transliterated
	
	# tokenize in clusters					
	tokenized <- tokenize(reduced
						, profile = "data/ALEprofileNFDreducedclusters.tsv"
						, sep = " "
						, normalize = "NFD"
						, regex = TRUE
						)$strings$tokenized

	# reduce clusters to simple IPA		
	simple <- tokenize(tokenized
						, profile = "data/ALEprofileNFDsimpleIPA.tsv"
						, transliterate = "SimpleIPA"
						, normalize = "NFD"
						, sep = ""
						, 
						)$strings$transliterated
	
	# reduce clusters to SCA				
	soundclasses <- tokenize(tokenized
						, profile = "data/ALEprofileNFDtoSCA.tsv"
						, transliterate = "SCA"
						, normalize = "NFD"
						, sep = ""
						, 
						)$strings$transliterated
						
	# and remove complex segments in SCA
	soundclasses <- gsub("([^ ])[^ ]+", "\\1", soundclasses)
	
	# quick and dirty clustering
	sim.word <- qlcMatrix::sim.strings(simple, sep = " ", boundary = TRUE)
	sim.family <- crossprod(ttMatrix(words$Group,simplify=T))
	cognates <- cutree(hclust(as.dist(2-sim.word-sim.family)), h = cutoff)

	# alignment
	align <- simple
	for (i in 1:max(cognates)) {
		tmp <- system2("code/align"
						, input = as.character(simple[cognates == i])
						, stdout = TRUE
						, stderr = FALSE
						)
	#	align[cognates == i] <- tmp
		align[cognates == i] <- tmp[!grepl("[0-9]", tmp)] # bug in LingPy?
	}
	
	transfer <- pass_align(tokenized, align)
	
	# report results
	if (full) {
		report <- cbind(ID = as.character(words$ID)
						, Place = as.character(words$Place)
						, Group = as.character(words$Group)
						, Originals = words$Word
						, Reduced = reduced
						, Tokenized = tokenized
						, SimpleIPA = simple
						, SCA = soundclasses
						, COGID = cognates
						, Alignment = align
						, Transferred = transfer
						)
	} else {
		report <- cbind(ID = as.character(words$ID)
						, Place = as.character(words$Place)
						, Group = as.character(words$Group)
						, Originals = words$Word
						, Simplified = reduced
						, COGID = cognates
						, Alignment = transfer
						)
	}
	rownames(report) <- NULL
						
	write.table(report
				, quote = FALSE
				, sep = "\t"
				, row.names = FALSE
				, file = paste0("sandbox/", concept, "_aligned.tsv")
				)
				
	return(invisible(as.data.frame(report)))
}

# =======================
# use LingPy "multialign"
# through some stupid hacks
# different approach now used
# with script "align"
# =======================

align <- function(strings) {
	
	write(strings, file = "strings.txt", sep = "\n")
	system("code/align.py strings.txt")
	result <- scan("out.txt", sep = "\n", what = "character")
	file.remove("out.txt", "strings.txt")
	return(result)
	
}


# unfortunately this goes wrong with Unicode!!!
#library(rPython)
#python.exec("from lingpy import *")
#python.load("code/lingpy tests/align.py")
#python.call("align",c("aŋdfg","asdfrg"))





