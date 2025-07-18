# install.packages("tidyverse")
library(tibble) # tibble (comes from tidyverse)
# install.packages("word2vec")
library(word2vec) # read.wordvectors
# install.packages("reticulate")
library(reticulate) # reticulate::py_eval
# install.packages("tidytext")
library(tidytext) # data("stop_words")
# install.packages("dplyr")
library(dplyr) # anti_join
# install.packages("SnowballC")
library(SnowballC) # wordStem
# install.packages("gglot2")
library(ggplot2) # ggplot

# This will load the data set needed for stop words
data("stop_words")

# emb (short for embedding) is a matrix with 3,000,000 rows and 300 columns.
# Each row represents a point in 300-dimensional space. Since this is a
# two-dimensional matrix, you can access a specific coordinate using:
# > emb["your_word_here",number_of_coordinate_here]
# However, what we want to do is associate an english word with a point in 300
# dimensions. The way in which we will be using emb is:
# > grape <- emb["apple",]
# > apple <- emb["grape",]
# After this, we can calculate how "close" grape and apple are semantically:
# > word2vec_similarity(grape, apple, type = "cosine")
# This returns a number between 0.0 and 1.0, where 0.0 represents completely
# different words and 1.0 represents the same word.
# For more information on how this works check out:
# - https://code.google.com/archive/p/word2vec/
emb <- read.wordvectors("google_vecs.bin", type = "bin")


w2v <- function(x) {
	y <- txt_clean_word2vec(x)
	if (any(y == rownames(emb))) emb[y,] else numeric(ncol(emb))
}
w2v_v <- Vectorize(w2v)

sim <- function(x, y) word2vec_similarity(w2v(x), w2v(y), type = "cosine")
sim_v <- Vectorize(sim)

# When Python writes a pandas.DataFrame into a CSV, it will run each cell in the
# DataFrame through repr and write that into the CSV. This means that when R
# reads the csv, R will interpret each cell in the CSV as a string, instead of
# the correct type that is supposed to actually be there.
py2r <- function(df, rows) {
	for (row in rows) {
		# In this case we use reticulate::py_eval to convert a python string
		# into the R representation.
		df[[row]] <- lapply(df[[row]], reticulate::py_eval)
	}
	return(df)
}

word_category <- function(x) {
	lgbt <- list("lgbt","lgbtq","sex","identity","gender","orientation","nonbinary") |>
		sim_v(x) |>
		mean(na.rm = TRUE)
	race_ethnicity <- list("race","ethnicity","african","american","black","hispanic","asian","indigenous","native","latino","latina","latine") |>
		sim_v(x) |>
		mean(na.rm = TRUE)
	women <- list("woman","women","girl","female","feminine","femeninity","ms","mrs") |>
		sim_v(x) |>
		mean(na.rm = TRUE)
	men <- list("man", "men", "boy", "male", "masculine", "masculinity", "mr") |>
		sim_v(x) |>
		mean(na.rm = TRUE)
	disabilities <- list("disabilities","disabled","disability","handicap","handicapped","neurodivergent") |>
		sim_v(x) |>
		mean(na.rm = TRUE)
	m <- max(lgbt,race_ethnicity,women,men,disabilities, na.rm = TRUE)
	if (m < 0.25) {
		return("none")
	} else if (m == lgbt) {
		return("lgbt")
	} else if (m == race_ethnicity) {
		return("race/ethnicity")
	} else if (m == women) {
		return("women")
	} else if (m == disabilities) {
		return("disabilities")
	} else {
		return("men")
	}
}

# Read data from CSV and convert it into its R representation
data <- read.csv("data/variables.csv") |> py2r(rows = 4:9)
ams_selection <- data[,"title"] == "American Mathematical Society"
data[ams_selection,"title"] <- "AMS"
cbms_selection <- data[,"title"] == "Conference Board of the Mathematical Sciences 2021 Survey"
data[cbms_selection,"title"] <- "CBMS"
ipeds_selection <- data[,"title"] == "Integrated Postsecondary Education Data System (IPEDS) Institution Lookup"
data[ipeds_selection,"title"] <- "IPEDS"
selection <- ams_selection | cbms_selection | ipeds_selection

data <- data[selection,]

for (row_idx in 1:nrow(data)) {
	raw_txt <- data[row_idx,"variables"]
	title <- data[row_idx,"title"]
	tib_txt <- tibble(line = seq_along(raw_txt[[1]]), text = raw_txt[[1]])
	tmp <- unnest_tokens(tib_txt, word, text)
	clean_txt <- anti_join(tmp[!grepl("\\d", tmp $ word),], stop_words)

	stem_txt <- mutate(clean_txt, word_stem = wordStem(word))
	sema_txt <- mutate(clean_txt, word_category = word_category(word))

	stem_count <- stem_txt |>
		inner_join(count(stem_txt, word_stem)) |>
		filter(n > 5) |>
		distinct(word_stem, .keep_all = TRUE)

	sema_count <- sema_txt |>
		inner_join(count(sema_txt, word_category)) |>
		filter(n > 5) |>
		distinct(word_category, .keep_all = TRUE)
	title <- data[row_idx,"title"]
	save(stem_count, file = paste("data/stem_", title, ".Rda", sep = ""))
	save(sema_count, file = paste("data/google_sema_", title, ".Rda", sep = ""))
}
