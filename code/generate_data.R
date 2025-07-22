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

# w2v : (String, Embedding) -> Vector
# This function, given a string and an embedding will return the vector
# associated to that word. In the case where the word cannot be found in the
# embedding, the vector returned is the zero vector. Additionally, the word is
# cleaned before processing it.
w2v <- function(str, emb) {
	clean_str <- txt_clean_word2vec(str)
	if (any(clean_str == rownames(emb))) emb[clean_str,] else numeric(ncol(emb))
}

# w2v_v : ([String], Embedding) -> Matrix
# This function, given a list of strings and an embedding will return the
# vectors associated to each word as a matrix. Each column of the Matrix
# returned corresponds to the vectors associated to that word. Because of this,
# you can access corresponding vectors like:
# > apple <- w2v_v(list("apple", "grape") |> as.characte(), emb)[,"apple"]
# > grape <- w2v_v(list("apple", "grape") |> as.characte(), emb)[,"grape"]
w2v_v <- function(words, emb) Vectorize(function(str) w2v(str, emb))(words)

# sim : (String, String, Embedding) -> Matrix
# sim : (String, String, Embedding, String) -> Matrix
# sim : ([String], [String], Embedding) -> Matrix
# sim : ([String], [String], Embedding, String) -> Matrix
# This function, given two strings or lists of strings and an embedding, will
# return the semantic similarity between those two words or list of words as a
# Floating-point Matrix where each entry is between -1.0 and 1.0. This semantic
# similarity is just the cosine of the angle between the two vectors.
sim <- function(w1, w2, emb, type = "cosine") word2vec_similarity(w2v(w1, emb), w2v(w2, emb), type = type)

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

# rep : (String, Integer) -> [String]
# This function, given a string and an integer, will return a list containing
# the string repeated however many times the integer says it should.
rep <- function(str, count) {
	out <- character(length = count)
	for (i in 1:count) {
		out[i] <- str
	}
	out
}

# These are the tags that are used to categorize the data.
lgbt_tags <- c("lgbt","lgbtq","sex","identity","gender","orientation","nonbinary") |> as.character()
race_ethnicity_tags <- c("race","ethnicity","african","american","black","hispanic","asian","indigenous","native","latino","latina","latine") |> as.character()
women_tags <- c("woman","women","girl","feminine","femeninity","ms","mrs") |> as.character()
men_tags <- c("man", "men", "boy", "male", "masculine", "masculinity", "mr") |> as.character()
disabilities_tags <- c("disabilities","disabled","disability","handicap","handicapped","neurodivergent") |> as.character()

# This variable holds all of the tags. Additionally, tag_categories holds all
# the tags together with their categories.
tags <- c(lgbt_tags, race_ethnicity_tags, women_tags, men_tags, disabilities_tags)
tag_categories <- c(
	rep("lgbt", length(lgbt_tags)),
	rep("race/ethnicity", length(race_ethnicity_tags)),
	rep("women", length(women_tags)),
	rep("men", length(men_tags)),
	rep("disabilities", length(disabilities_tags))
)

# 
similarity_values <- numeric(length = length(tags))
word_category <- function(word, tag_vectors, emb, threshold = 0.3) {
	for (i in seq_along(tags)) {
		similarity_values[i] <- word2vec_similarity(w2v(word, emb), tag_vectors[,i], type = "cosine")
	}

	similarities <- data.frame(
			sim = similarity_values,
			tag = tags,
			tag_category = tag_categories
	)

	similarities <- similarities[similarities |> complete.cases(),]
	m <- max(similarities $ sim, na.rm = TRUE)
	if (m > threshold) similarities[m == similarities,] |> head(1) else data.frame(sim = NA, tag = NA, tag_category = NA)
}

memo <- new.env(hash = TRUE, parent = emptyenv())
word_category_m <- function(x, tag_vectors, emb, threshold = 0.3) {
	if (is.null(memo[[x]])) {
		memo[[x]] <- word_category(x, tag_vectors, emb, threshold)
	}
	return(memo[[x]])
}

word_category_v <- function(words, tag_vectors, emb, threshold = 0.3) {
	res <- Vectorize(function(word) word_category_m(word, tag_vectors, emb))(words) |> t()
	sim <- numeric(length = length(words))
	tags <- character(length = length(words))
	tag_categories <- character(length = length(words))
	for (i in 1:nrow(res)) {
		sim[i] <- res[,"sim"][[i]]
		tags[i] <- res[,"tag"][[i]]
		tag_categories[i] <- res[,"tag_category"][[i]]
	}
	data.frame(
		sim = sim,
		tag = tags,
		tag_category = tag_categories
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

clean_text <- function(raw_text) {
	tmp <- tibble(
			line = seq_along(raw_text),
			text = raw_text
		) |> unnest_tokens(word, text)
	tmp[!grepl("\\d", tmp $ word),] |> anti_join(stop_words)
}

# Word stems analysis

for (row_idx in 1:nrow(data)) {
	title <- data[row_idx,"title"]
	stem_txt <- clean_text(data[row_idx,"variables"][[1]]) |>
		mutate(word_stem = wordStem(word))

	stem_count <- stem_txt |>
		inner_join(count(stem_txt, word_stem)) |>
		filter(n > 5) |>
		distinct(word_stem, .keep_all = TRUE)

	save(stem_count, file = paste("data/stem_", title, ".Rda", sep = ""))
}


# Word semantics analysis

word_semantic_analysis <- function(emb, data, model_name, threshold = 0.3) {
	tag_vectors <- w2v_v(tags, emb)
	for (row_idx in 1:nrow(data)) {
		title <- data[row_idx,"title"]
		clean_txt <- clean_text(data[row_idx, "variables"][[1]])

		memo <- new.env(hash = TRUE, parent = emptyenv())
		word_category_m <- function(x, tag_vectors, emb, threshold = 0.3) {
			if (is.null(memo[[x]])) {
				memo[[x]] <- word_category(x, tag_vectors, emb, threshold)
			}
			return(memo[[x]])
		}

		word_category_v <- function(words, tag_vectors, emb, threshold = 0.3) {
			res <- Vectorize(function(word) word_category_m(word, tag_vectors, emb, threshold))(words) |> t()
			sim <- numeric(length = length(words))
			tags <- character(length = length(words))
			tag_categories <- character(length = length(words))
			for (i in 1:nrow(res)) {
				sim[i] <- res[,"sim"][[i]]
				tags[i] <- res[,"tag"][[i]]
				tag_categories[i] <- res[,"tag_category"][[i]]
			}
			data.frame(
				sim = sim,
				tag = tags,
				tag_category = tag_categories
			)
		}

		word_categories <- word_category_v(clean_txt $ word, tag_vectors, emb, threshold)
		sema_txt <- clean_txt |>
			mutate(tag = word_categories $ tag, word_category = word_categories $ tag_category)

		sema_count <- sema_txt |>
			inner_join(count(sema_txt, tag)) |>
			distinct(tag, .keep_all = TRUE)

		save(sema_count, file = paste("data/", model_name, "_", threshold, "_", title, ".Rda", sep = ""))
	}
}

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

read.wordvectors("google_vecs.bin", type = "bin") |>
	word_semantic_analysis(data = data, model_name = "google_news", threshold = 0.185)

read.wordvectors("glove.6B.300d.txt", type = "txt") |>
	word_semantic_analysis(data = data, model_name = "glove_300d", threshold = 0.134)

read.wordvectors("glove.6B.200d.txt", type = "txt") |>
	word_semantic_analysis(data = data, model_name = "glove_200d", threshold = 0.164)

read.wordvectors("glove.6B.100d.txt", type = "txt") |>
	word_semantic_analysis(data = data, model_name = "glove_100d", threshold = 0.219)

read.wordvectors("glove.6B.50d.txt", type = "txt") |>
	word_semantic_analysis(data = data, model_name = "glove_50d", threshold = 0.273)
