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

syn <-  read.csv("syn.csv")

# --- google vectors ---

emb <- read.wordvectors("google_vecs.bin", type = "bin")
w2v <- function(x) {
	y <- txt_clean_word2vec(x)
	if (any(y == rownames(emb))) emb[y,] else numeric(ncol(emb))
}
w2v_v <- Vectorize(w2v)

sim <- function(x, y) word2vec_similarity(w2v(x), w2v(y), type = "cosine")
sim_v <- Vectorize(sim)

data <- sim_v(syn $ word, syn $ synonym)
save(data, file = "data/google_vecs_syn.Rda")

# --- glove 300d ---

emb <- read.wordvectors("glove.6B.300d.txt", type = "txt")
w2v <- function(x) {
	y <- txt_clean_word2vec(x)
	if (any(y == rownames(emb))) emb[y,] else numeric(ncol(emb))
}
w2v_v <- Vectorize(w2v)

sim <- function(x, y) word2vec_similarity(w2v(x), w2v(y), type = "cosine")
sim_v <- Vectorize(sim)

data <- sim_v(syn $ word, syn $ synonym)
save(data, file = "data/glove_300d_syn.Rda")

# --- glove 200d ---

emb <- read.wordvectors("glove.6B.200d.txt", type = "txt")
w2v <- function(x) {
	y <- txt_clean_word2vec(x)
	if (any(y == rownames(emb))) emb[y,] else numeric(ncol(emb))
}
w2v_v <- Vectorize(w2v)

sim <- function(x, y) word2vec_similarity(w2v(x), w2v(y), type = "cosine")
sim_v <- Vectorize(sim)

data <- sim_v(syn $ word, syn $ synonym)
save(data, file = "data/glove_200d_syn.Rda")

# --- glove 100d ---

emb <- read.wordvectors("glove.6B.100d.txt", type = "txt")
w2v <- function(x) {
	y <- txt_clean_word2vec(x)
	if (any(y == rownames(emb))) emb[y,] else numeric(ncol(emb))
}
w2v_v <- Vectorize(w2v)

sim <- function(x, y) word2vec_similarity(w2v(x), w2v(y), type = "cosine")
sim_v <- Vectorize(sim)

data <- sim_v(syn $ word, syn $ synonym)
save(data, file = "data/glove_100d_syn.Rda")

# --- glove 50d ---

emb <- read.wordvectors("glove.6B.50d.txt", type = "txt")
w2v <- function(x) {
	y <- txt_clean_word2vec(x)
	if (any(y == rownames(emb))) emb[y,] else numeric(ncol(emb))
}
w2v_v <- Vectorize(w2v)

sim <- function(x, y) word2vec_similarity(w2v(x), w2v(y), type = "cosine")
sim_v <- Vectorize(sim)

data <- sim_v(syn $ word, syn $ synonym)
save(data, file = "data/glove_50d_syn.Rda")
