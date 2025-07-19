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
	print(ggplot(data, aes(x = reorder(word, n), y = n)) +
		geom_col() +
		coord_flip() +
		labs(title = paste("Most frequent words in", names[[i]], "surveys")))
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

data_sources <- list(sema_count_glove_100d_ams,sema_count_glove_100d_cbms,sema_count_glove_100d_ipeds,sema_count_glove_200d_ams,sema_count_glove_200d_cbms,sema_count_glove_200d_ipeds,sema_count_glove_300d_ams,sema_count_glove_300d_cbms,sema_count_glove_300d_ipeds,sema_count_glove_50d_ams,sema_count_glove_50d_cbms,sema_count_glove_50d_ipeds,sema_count_google_ams,sema_count_google_cbms,sema_count_google_ipeds)
names <- list(
	"AMS surveys w/ 100-D Glove model",
	"CBMS surveys w/ 100-D Glove model",
	"IPEDS surveys w/ 100-D Glove model",
	"AMS surveys w/ 200-D Glove model",
	"CBMS surveys w/ 200-D Glove model",
	"IPEDS surveys w/ 200-D Glove model",
	"AMS surveys w/ 300-D Glove model",
	"CBMS surveys w/ 300-D Glove model",
	"IPEDS surveys w/ 300-D Glove model",
	"AMS surveys w/ 50-D Glove model",
	"CBMS surveys w/ 50-D Glove model",
	"IPEDS surveys w/ 50-D Glove model",
	"AMS surveys w/ Google News model",
	"CBMS surveys w/ Google News model",
	"IPEDS surveys w/ Google News model"
)

i <- 1
pdf("plots_sema.pdf", onefile = TRUE)
for (data in data_sources) {
	data <- data[complete.cases(data),]
	print(ggplot(data, aes(x = reorder(tag, n), y = n)) +
		geom_col() +
		coord_flip() +
		labs(title = paste("Most frequent tags in", names[[i]])))
	i <- i + 1
}
dev.off()
