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

load("google_sema_AMS.Rda")
load("google_sema_CBMS.Rda")
load("google_sema_IPEDS.Rda")
load("stem_AMS.Rda")
load("stem_CBMS.Rda")
load("stem_IPEDS.Rda")


data <- cbind(ams,cbms,ipeds)

pdf("plots2.pdf", onefile = TRUE)
for (row_idx in 1:nrow(data)) {
	print(ggplot(stem_count, aes(x = reorder(word, n), y = n)) +
		geom_col() +
		coord_flip() +
		labs(title = title))
	print(ggplot(sema_count, aes(x = reorder(word_category, n), y = n)) +
		geom_col() +
		coord_flip() +
		labs(title = paste("Most Frequent Categories in", data[row_idx,"title"], "surveys")))
	print(title)
}
dev.off()
