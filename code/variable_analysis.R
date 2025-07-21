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
library(viridis) # scale_viridis_d
library(tidyverse) # ????


load("data/stem_AMS.Rda")
stem_count_ams <- stem_count
load("data/stem_CBMS.Rda")
stem_count_cbms <- stem_count
load("data/stem_IPEDS.Rda")
stem_count_ipeds <- stem_count

data_sources <- list(stem_count_ams,stem_count_cbms,stem_count_ipeds)
names <- list("AMS", "CBMS", "IPEDS")
i <- 1
pdf("plots_stem.pdf", onefile = TRUE)
for (data in data_sources) {
	data <- data[complete.cases(data),]
	print(
		ggplot(data, aes(x = reorder(word, n), y = n)) +
		geom_col() +
		coord_flip() +
		labs(
			title = paste("Most frequent words in", names[[i]], "surveys"),
			x = "Occurrences",
			y = "Words"
		) +
		theme_minimal() +
		theme(aspect.ratio = 1)
	)
	i <- i + 1
}
dev.off()

load("data/glove_100d_AMS.Rda")
sema_count_glove_100d_ams <- sema_count
load("data/glove_100d_CBMS.Rda")
sema_count_glove_100d_cbms <- sema_count
load("data/glove_100d_IPEDS.Rda")
sema_count_glove_100d_ipeds <- sema_count
load("data/glove_200d_AMS.Rda")
sema_count_glove_200d_ams <- sema_count
load("data/glove_200d_CBMS.Rda")
sema_count_glove_200d_cbms <- sema_count
load("data/glove_200d_IPEDS.Rda")
sema_count_glove_200d_ipeds <- sema_count
load("data/glove_300d_AMS.Rda")
sema_count_glove_300d_ams <- sema_count
load("data/glove_300d_CBMS.Rda")
sema_count_glove_300d_cbms <- sema_count
load("data/glove_300d_IPEDS.Rda")
sema_count_glove_300d_ipeds <- sema_count
load("data/glove_50d_AMS.Rda")
sema_count_glove_50d_ams <- sema_count
load("data/glove_50d_CBMS.Rda")
sema_count_glove_50d_cbms <- sema_count
load("data/glove_50d_IPEDS.Rda")
sema_count_glove_50d_ipeds <- sema_count
load("data/google_sema_AMS.Rda")
sema_count_google_ams <- sema_count
load("data/google_sema_CBMS.Rda")
sema_count_google_cbms <- sema_count
load("data/google_sema_IPEDS.Rda")
sema_count_google_ipeds <- sema_count

get_df <- function(str) {
	data.frame(
		model = list("GloVe 50D", "GloVe 100D", "GloVe 200D", "GloVe 300D", "Google News", "GloVe 50D", "GloVe 100D", "GloVe 200D", "GloVe 300D", "Google News", "GloVe 50D", "GloVe 100D", "GloVe 200D", "GloVe 300D", "Google News") |> as.character(),
		title = list("IPEDS", "IPEDS", "IPEDS", "IPEDS", "IPEDS", "CBMS", "CBMS", "CBMS", "CBMS", "CBMS", "AMS", "AMS", "AMS", "AMS", "AMS") |> as.character(),
		n = list(
			sema_count_glove_50d_ipeds[sema_count_glove_50d_ipeds $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_300d_ipeds[sema_count_glove_300d_ipeds $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_200d_ipeds[sema_count_glove_200d_ipeds $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_100d_ipeds[sema_count_glove_100d_ipeds $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_google_ipeds[sema_count_google_ipeds $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_50d_cbms[sema_count_glove_50d_cbms $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_300d_cbms[sema_count_glove_300d_cbms $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_200d_cbms[sema_count_glove_200d_cbms $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_100d_cbms[sema_count_glove_100d_cbms $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_google_cbms[sema_count_google_cbms $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_50d_ams[sema_count_glove_50d_ams $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_300d_ams[sema_count_glove_300d_ams $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_200d_ams[sema_count_glove_200d_ams $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_100d_ams[sema_count_glove_100d_ams $ word_category == str,] $ n |> sum(na.rm = TRUE),
			sema_count_google_ams[sema_count_google_ams $ word_category == str,] $ n |> sum(na.rm = TRUE)
		) |> as.numeric()
	)
}

# ------------------------------ lgbt ------------------------------

lgbt_df <- get_df("lgbt")

race_ethn_df <- get_df("race/ethnicity")

women_df <- get_df("women")

disabilities_df <- get_df("disabilities")

i <- 1
tags <- list("LGBT", "Race/Ethnicity", "Women", "Disabilities") |> as.character()
pdf("tags.pdf")
for (df in list(lgbt_df, race_ethn_df, women_df, disabilities_df)) {
	tag_name <- tags[i]
	print(
		ggplot(df, aes(fill = model, x = title, y = n)) +
			geom_bar(position = "dodge", stat = "identity") +
			scale_fill_viridis_d() +
			labs(
				x = "Data Source",
				y = "Occurrences"
			) +
			theme_light() +
			theme(aspect.ratio = 1)
	)
	i <- i + 1
}
dev.off()

# women
# race/ethnicity
# disabilities

data_sources <- list(sema_count_glove_100d_ams,sema_count_glove_100d_cbms,sema_count_glove_100d_ipeds,sema_count_glove_200d_ams,sema_count_glove_200d_cbms,sema_count_glove_200d_ipeds,sema_count_glove_300d_ams,sema_count_glove_300d_cbms,sema_count_glove_300d_ipeds,sema_count_glove_50d_ams,sema_count_glove_50d_cbms,sema_count_glove_50d_ipeds,sema_count_google_ams,sema_count_google_cbms,sema_count_google_ipeds)
names <- list(
	"AMS surveys w/ 100-D GloVe model",
	"CBMS surveys w/ 100-D GloVe model",
	"IPEDS surveys w/ 100-D GloVe model",
	"AMS surveys w/ 200-D GloVe model",
	"CBMS surveys w/ 200-D GloVe model",
	"IPEDS surveys w/ 200-D GloVe model",
	"AMS surveys w/ 300-D GloVe model",
	"CBMS surveys w/ 300-D GloVe model",
	"IPEDS surveys w/ 300-D GloVe model",
	"AMS surveys w/ 50-D GloVe model",
	"CBMS surveys w/ 50-D GloVe model",
	"IPEDS surveys w/ 50-D GloVe model",
	"AMS surveys w/ Google News model",
	"CBMS surveys w/ Google News model",
	"IPEDS surveys w/ Google News model"
)

i <- 1
pdf("plots_sema.pdf", onefile = TRUE)
for (data in data_sources) {
	data <- data[complete.cases(data),]
	print(
		ggplot(data) +
		geom_bar(aes(y = word_category, fill = word_category)) +
		labs(
			 title = paste("Most frequent tags in", names[[i]]),
			 x = "Occurrences",
			 y = "Tags"
		) +
		theme_minimal() +
		theme(aspect.ratio = 1)
	)
	i <- i + 1
}
dev.off()
