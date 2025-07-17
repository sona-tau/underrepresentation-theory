# install.packages("tidyverse")
library(tibble) # tibble (comes from tidyverse)
# install.packages("word2vec")
library(word2vec) # read.wordvectors
# install.packages("reticulate")
library(reticulate) # reticulate::py_eval
# install.packages("tidytext")
library(tidytext) # data("stop_words")

# This will load the data set needed for stop words
data("stop_words")


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

# Read data from CSV and convert it into its R representation
data <- read.csv("data/variables.csv") |> py2r(rows = 4:9)

stem_counts <- vector("list", nrow(data))

for (row_idx in 1:nrow(data)) {
	raw_txt <- data[row_idx,"variables"]
	tib_txt <- tibble(line = 1:length(raw_txt), text = raw_txt)
	clean_txt <- tib_txt |>
		unnest_tokens(word, text) |>
		anti_join(stop_words) |>
		mutate(word_stem = wordStem(word))

	word_counts <- clean_txt |>
		inner_join(count(clean_txt), word_stem, sort = TRUE) |>
		filter(n > 5) |>
		distinct(word_stem, .keep_all = TRUE)

	stem_counts[[row_idx]] <- word_counts
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
emb_g <- read.wordvectors("../google_vecs.bin", type = "bin")

for (row_idx in 1:nrow(data)) {
	raw_txt <- data[row_idx, "variables"]
	tib_txt <- tibble(line = 1:length(raw_txt), text = raw_txt)
	clean_txt <- tib_txt |>
		unnest_tokens(word, text) |>
		anti_join(stop_words)
}
