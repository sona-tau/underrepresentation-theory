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

rep <- function(str, count) {
	out <- character(length = count)
	for (i in 1:count) {
		out[i] <- str
	}
	out
}

word_category <- function(x, threshold = 0.3) {
	lgbt <- list("lgbt","lgbtq","sex","identity","gender","orientation","nonbinary")
	race_ethnicity <- list("race","ethnicity","african","american","black","hispanic","asian","indigenous","native","latino","latina","latine")
	women <- list("woman","women","girl","feminine","femeninity","ms","mrs")
	men <- list("man", "men", "boy", "male", "masculine", "masculinity", "mr")
	disabilities <- list("disabilities","disabled","disability","handicap","handicapped","neurodivergent")
	all <- c(lgbt, race_ethnicity, women, men, disabilities)

	similarities <- data.frame(
			sim = sim_v(x, all),
			word = as.character(all),
			word_category = c(
				rep("lgbt", length(lgbt)),
				rep("race/ethnicity", length(race_ethnicity)),
				rep("women", length(women)),
				rep("men", length(men)),
				rep("disabilities", length(disabilities))
			)
	)
	similarities <- similarities[similarities |> complete.cases(),]
	m <- max(similarities $ sim, na.rm = TRUE)
	if (m > threshold) similarities[m == similarities,] |> head(1) else data.frame(sim = NA, word = NA, word_category = NA)
}

word_category_v <- function(x) {
	res <- Vectorize(word_category)(x) |> t()
	sim <- numeric(length = length(x))
	word <- character(length = length(x))
	word_category <- character(length = length(x))
	for (i in 1:nrow(res)) {
		sim[i] <- res[,"sim"][[i]]
		word[i] <- res[,"word"][[i]]
		word_category[i] <- res[,"word_category"][[i]]
	}
	data.frame(
		sim = sim,
		word = word,
		word_category = word_category
	)
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
	word_categories <- word_category_v(clean_txt $ word)
	sema_txt <- mutate(clean_txt, tag = word_categories $ word, word_category = word_categories $ word_category)

	stem_count <- stem_txt |>
		inner_join(count(stem_txt, word_stem)) |>
		filter(n > 5) |>
		distinct(word_stem, .keep_all = TRUE)

	sema_count <- sema_txt |>
		inner_join(count(sema_txt, tag)) |>
		distinct(tag, .keep_all = TRUE)

	title <- data[row_idx,"title"]
	save(stem_count, file = paste("data/stem_", title, ".Rda", sep = ""))
	save(sema_count, file = paste("data/google_sema_", title, ".Rda", sep = ""))
}
