library(dplyr) # tibble
library(tidytext) # read.csv
library(jsonlite) # fromJSON
library(ggplot2) # ggplot
library(SnowballC) # wordStem
library(wordcloud) # wordcloud

data("stop_words")

sources <- fromJSON("data/variables.json")

counts <- vector("list", length(sources))

i <- 1
for (vars in sources[[4]]) {
	# This skip is needed because if length(vars) == 0, then 1:length(vars)
	# produces a 2 element list. Then, when creating a tibble using
	# 1:length(vars) and vars this would crash the program since both columns
	# are different sizes
	if (length(vars) == 0) {
		counts[[i]] <- NULL
		i <- i + 1
		next
	}

	# The line column is needed because in the next part we convert each word in
	# each question into its own row and we want to be able to track what
	# question each word came from.
	raw_text <- tibble(line = 1:length(vars), text = vars)

	tidy_text <- (raw_text
		|> unnest_tokens(word, text)          # Convert each word in each question into a row
		|> anti_join(stop_words)              # Filter out stop words
		|> mutate(word_stem = wordStem(word)) # Add a column with each word's stem
	)

	# The line with the inner_join and count is needed because count produces a
	# tibble with only two columns (word_stem and n) and we want to preserve the
	# word that the word stem came from. This is done using an inner_join.

	word_counts <- (tidy_text
		# WARNING: REMOVE THE NUMBERS HERE
		# WARNING: REMOVE THE NUMBERS HERE
		# WARNING: REMOVE THE NUMBERS HERE
		# WARNING: REMOVE THE NUMBERS HERE
		|> inner_join(count(tidy_text, word_stem, sort = TRUE)) # Count words and match them to their word_stem.
		|> filter(n > 5) # Filter out all the low ranking words
		# Filtering out words that share the same stem lets us pick an
		# (arbitrary) representative for each word's stem that is still human
		# readable (like having "education" instead of "educ").
		|> distinct(word_stem, .keep_all = TRUE) # Filter out words that share the same stem.
	)
	counts[[i]] <- word_counts
	i <- i + 1
}

pdf("data/out.pdf")
wordcloud(words = counts[[14]] $ word, freq = counts[[14]] $ n, max.words = 50)
# ggplot(counts[[14]], aes(x = reorder(word, n), y = n)) +
# 	geom_col() +
# 	coord_flip() +
# 	labs(title = "Most Frequent Words in 'CBMS' surveys")
dev.off()
