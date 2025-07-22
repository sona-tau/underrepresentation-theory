load("code/big_question_tag_df.rda")

head(big_question_tag_df)
summary(big_question_tag_df)
view(big_question_tag_df)

#Remove rows where Tags = NA
only_tag <- big_question_tag_df |>
  filter(Tags != "NA")
view(only_tag)

tagged_ams <- only_tag |>
  filter(Source == "AMS")

tagged_cbms <- only_tag |>
  filter(Source == "CBMS")

view(tagged_ams)
view(tagged_cbms)

#All questions by source
ams_ques <- big_question_tag_df |>
  filter(Source == "AMS")

cbms_ques <- big_question_tag_df |>
  filter(Source == "CBMS")

ipeds_ques <- big_question_tag_df |>
  filter(Source == "IPEDS")

#Tokenization and wordcloud per source
#AMS
tidy_ams_ques <- ams_ques |>
  unnest_tokens(word, Questions) |>
  anti_join(stop_words) |>
  filter(!str_detect(word, "^[0-9]+$"))

word_counts_ams <- tidy_ams_ques |>
  count(word, sort = TRUE) |>
  filter(n > 0)

view(word_counts_ams)

#CBMS
tidy_cbms_ques <- cbms_ques |>
  unnest_tokens(word, Questions) |>
  anti_join(stop_words) |>
  filter(!str_detect(word, "^[0-9]+$"))

word_counts_cbms <- tidy_cbms_ques |>
  count(word, sort = TRUE) |>
  filter(n > 5) |>
  filter(!str_detect(word, "_|b2|b1|e1|f1|e2|e.g|ii"))

view(word_counts_cbms)

#IPEDS
tidy_ipeds_ques <- ipeds_ques |>
  unnest_tokens(word, Questions) |>
  anti_join(stop_words) |>
  filter(!str_detect(word, "^[0-9]+$"))

word_counts_ipeds <- tidy_ipeds_ques |>
  count(word, sort = TRUE) |>
  filter(n > 5) |>
  filter(!str_detect(word, "e.g"))

view(word_counts_ipeds)

#install.packages("wordcloud2")
library("wordcloud2")
install.packages("httpgd")

#AMS
my_palette = c("#355070",
               "#6d597a",
               "#b56576",
               "#e56b6f",
               "#eaac8b")

ams_wc = wordcloud2(
  word_counts_ams,
  color = rep_len(my_palette,
                  nrow(word_counts_ams)))


