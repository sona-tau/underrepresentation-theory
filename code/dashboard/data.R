load("../data/glove_100d_AMS.Rda")
sema_count_glove_100d_ams <- sema_count
load("../data/glove_100d_CBMS.Rda")
sema_count_glove_100d_cbms <- sema_count
load("../data/glove_100d_IPEDS.Rda")
sema_count_glove_100d_ipeds <- sema_count
load("../data/glove_200d_AMS.Rda")
sema_count_glove_200d_ams <- sema_count
load("../data/glove_200d_CBMS.Rda")
sema_count_glove_200d_cbms <- sema_count
load("../data/glove_200d_IPEDS.Rda")
sema_count_glove_200d_ipeds <- sema_count
load("../data/glove_300d_AMS.Rda")
sema_count_glove_300d_ams <- sema_count
load("../data/glove_300d_CBMS.Rda")
sema_count_glove_300d_cbms <- sema_count
load("../data/glove_300d_IPEDS.Rda")
sema_count_glove_300d_ipeds <- sema_count
load("../data/glove_50d_AMS.Rda")
sema_count_glove_50d_ams <- sema_count
load("../data/glove_50d_CBMS.Rda")
sema_count_glove_50d_cbms <- sema_count
load("../data/glove_50d_IPEDS.Rda")
sema_count_glove_50d_ipeds <- sema_count
load("../data/google_sema_AMS.Rda")
sema_count_google_ams <- sema_count
load("../data/google_sema_CBMS.Rda")
sema_count_google_cbms <- sema_count
load("../data/google_sema_IPEDS.Rda")
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

get_df_tag <- function(str) {
	data.frame(
		model = list("GloVe 50D", "GloVe 100D", "GloVe 200D", "GloVe 300D", "Google News", "GloVe 50D", "GloVe 100D", "GloVe 200D", "GloVe 300D", "Google News", "GloVe 50D", "GloVe 100D", "GloVe 200D", "GloVe 300D", "Google News") |> as.character(),
		title = list("IPEDS", "IPEDS", "IPEDS", "IPEDS", "IPEDS", "CBMS", "CBMS", "CBMS", "CBMS", "CBMS", "AMS", "AMS", "AMS", "AMS", "AMS") |> as.character(),
		n = list(
			sema_count_glove_50d_ipeds[sema_count_glove_50d_ipeds $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_300d_ipeds[sema_count_glove_300d_ipeds $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_200d_ipeds[sema_count_glove_200d_ipeds $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_100d_ipeds[sema_count_glove_100d_ipeds $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_google_ipeds[sema_count_google_ipeds $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_50d_cbms[sema_count_glove_50d_cbms $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_300d_cbms[sema_count_glove_300d_cbms $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_200d_cbms[sema_count_glove_200d_cbms $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_100d_cbms[sema_count_glove_100d_cbms $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_google_cbms[sema_count_google_cbms $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_50d_ams[sema_count_glove_50d_ams $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_300d_ams[sema_count_glove_300d_ams $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_200d_ams[sema_count_glove_200d_ams $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_glove_100d_ams[sema_count_glove_100d_ams $ tag == str,] $ n |> sum(na.rm = TRUE),
			sema_count_google_ams[sema_count_google_ams $ tag == str,] $ n |> sum(na.rm = TRUE)
		) |> as.numeric()
	)
}

# ------------------------------ lgbt ------------------------------

lgbt_df <- get_df("lgbt")

race_ethn_df <- get_df("race/ethnicity")

women_df <- get_df("women")

disabilities_df <- get_df("disabilities")



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

