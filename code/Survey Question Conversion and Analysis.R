install.packages("ggplot2")
install.packages("tidyverse")
install.packages("tidytext")
install.packages("ggplot")
install.packages("reticulate")
install.packages("tibble")
install.packages("dplyr")
install.packages("SnowballC")
install.packages("tibble")
install.packages("tidyr")
library(ggplot2)
library(tidyverse)
library(tidytext)
library(reticulate)
library(tibble)
library(dplyr)
library(SnowballC)
library(tibble)
library(tidyr)
py2r <- function(df, rows) {
  for (row in rows) {
    # In this case we use reticulate::py_eval to convert a python string
    # into the R representation.
    df[[row]] <- lapply(df[[row]], reticulate::py_eval)
  }
  return(df)
}
cbmssurveyquestions <-read.csv("questions_w_type.csv")
stop_words <- read.csv("stop_words.csv")

othervariablesandquestiontypes <- read.csv("variables.csv") |> py2r(rows = 4:9)

multiple_choice_cbms <- cbmssurveyquestions |>
  filter(Type == "MC")

multiple_choice_othersurveys <- othervariablesandquestiontypes$multiple.choices

IPEDS_MC <- othervariablesandquestiontypes$multiple.choices[3][[1]]
IPEDSMC_COUNT <- length(IPEDS_MC)
IPEDS_MS <- othervariablesandquestiontypes$multiple.selects[3][[1]]
IPEDS_multipleselect_count <- length(IPEDS_MS)
IPEDS_WR <- othervariablesandquestiontypes$written.responses[3][[1]]
IPEDS_writtenresponse_count <- length(IPEDS_WR)
IPEDS_TI <- othervariablesandquestiontypes$table.inputs[3][[1]]
IPEDS_tableinput_count <- length(IPEDS_TI)
IPEDS_all_questions <- c(IPEDS_MC, IPEDS_MS, IPEDS_TI, IPEDS_WR)



AMS_MC <- othervariablesandquestiontypes$multiple.choices[13][[1]]
AMSMC_COUNT <- length(AMS_MC)
AMS_MS <- othervariablesandquestiontypes$multiple.selects[13][[1]]
AMS_multipleselect_count <- length(AMS_MS)
AMS_WR <- othervariablesandquestiontypes$written.responses[13][[1]]
AMS_writtenresponse_count <- length(AMS_WR)
AMS_TI <- othervariablesandquestiontypes$table.inputs[13][[1]]
AMS_tableinput_count <- length(AMS_TI)
AMS_all_questions <- c(AMS_TI, AMS_MC, AMS_MS, AMS_WR)
AMS_questions_list <- as.data.frame(AMS_all_questions)


CBMSMC_p1 <- othervariablesandquestiontypes$multiple.choices[17][[1]]
CBMSMC_p2 <- multiple_choice_cbms |>
  pull(Question)
CBMSMC_full = c(CBMSMC_p1, CBMSMC_p2)
CBMSMC_COUNT = length(CBMSMC_full)


CBMS_MSp1 <- othervariablesandquestiontypes$multiple.selects[17][[1]]
CBMS_MSp2 <- cbmssurveyquestions |>
  filter(Type == "MS") |>
  pull(Question)
CBMS_all_multipleselect = as.character(c(CBMS_MSp1, CBMS_MSp2))
CBMS_multiselect_count = length(CBMS_all_multipleselect)


CBMS_TIp1 <- othervariablesandquestiontypes$table.inputs[17][[1]]
CBMS_TIp2 <- cbmssurveyquestions |>
  filter(Type == "TI") |>
  pull(Question)
CBMS_all_tableinput = c(CBMS_TIp1, CBMS_TIp2)
CBMS_tableinput_count = length(CBMS_all_tableinput)


CBMS_WRp1 <- othervariablesandquestiontypes$written.responses[17][[1]] ##pulls written responses for cbms from first questionnaire
CBMS_WRp2 <- cbmssurveyquestions |>
  filter(Type == "WR") |>
  pull(Question) ##pulls written response from the cbms survey questions dataframe
CBMS_all_writtenresponse = c(CBMS_WRp2, CBMS_WRp1) ##combines the two former lists
CBMS_writtenresponse_count = length(CBMS_all_writtenresponse) ##outputs total number of cbms written response questions
CBMS_all_questions <- c(CBMS_all_multipleselect, CBMS_all_tableinput, 
                        CBMS_all_writtenresponse, CBMSMC_full)

keywords <- c("lgbtq",
              "lgptq+",
                "sex",
              "Sex",
              "sexual",
              "Sexual",
              "identity",
              "Identity",
              "gender",
              "Gender",
              "orientation",
              "male",
              "Male",
              "\\bmen\\b",
              "women",
              "Women",
              "nonbinary",
              "expression",
              "masculine",
              "feminine",
              "race",
              "ethnicity",
              "African American",
              "black",
              "hispanic",
              "asian",
              "indigenous",
              "\\bnative\\b",
              "latin[xo]",
              "female",
              "Female",
              "feminine",
              "Ms",
              "Mrs",
              "disability",
              "handicap",
              "neurodivergent",
              "disabled",
              "limited ability",
              "citizen",
              "racial",
              "Ethnicity",
              "equity",
              "Equity",
              "Diversity",
              "diversity", 
              "Inclusion",
              "inclusion",
              "Native",
              "indian",
              "Indian")

tagged_AMS <- sapply(AMS_all_questions, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
  
})
tagged_AMS_df <- as.data.frame(tagged_AMS)


tagged_AMS_multiplechoice <- sapply(AMS_MC, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})
ams_mc_tagged <- as.data.frame(tagged_AMS_multiplechoice)

AMS_writtenresponse_tags <- sapply(AMS_WR, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = "|"))
  } else {
    NA
  }
})

ams_wr_tagged <- as.data.frame(AMS_writtenresponse_tags)

AMS_tableinput_tags <- sapply(AMS_TI, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = "|"))
  } else {
    NA
  }
})

ams_ti_tagged <- as.data.frame(AMS_tableinput_tags)

AMS_multipleselect_tags <- sapply(AMS_MS, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = "|"))
  } else {
    NA
  }
})

ams_ms_tagged <- as.data.frame(AMS_multipleselect_tags)

AMS_Question_Tags <- data.frame(
  Questions = AMS_questions_list,
  Tags = tagged_AMS_df
)

colnames(AMS_Question_Tags) <- list("Questions", "Tags")

AMS_MC_Tags <- data.frame(
  Questions = AMS_MC,
  Tags = ams_mc_tagged
)

colnames(AMS_MC_Tags) <- list("Questions", "Tags")

AMS_MS_Tags <- data.frame(
  Questions = AMS_MS,
  Tags = ams_ms_tagged
)

colnames(AMS_MS_Tags) <- list("Questions", "Tags")

AMS_TI_Tags <- data.frame(
  Questions = AMS_TI,
  Tags = ams_ti_tagged
)

colnames(AMS_TI_Tags) <- list("Questions", "Tags")

AMS_WR_Tags <- data.frame (
  Questions = AMS_WR,
  Tags = ams_wr_tagged
)

colnames(AMS_WR_Tags) <- list("Questions", "Tags")

CBMS_all_questions_char <- as.character(CBMS_all_questions)

tagged_CBMS <- sapply(CBMS_all_questions_char, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_CBMS_df <- as.data.frame(tagged_CBMS)

CBMS_mc_tagged <-sapply(CBMSMC_full, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_cbms_mc <- as.data.frame(CBMS_mc_tagged)

CBMS_ms_tagged <- sapply(CBMS_all_multipleselect, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_cbms_ms <- as.data.frame(CBMS_ms_tagged)

CBMS_ti_tagged <-sapply(CBMS_all_tableinput, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_cbms_ti <- as.data.frame(CBMS_ti_tagged)
  
  
CBMS_wr_tagged <- sapply(CBMS_all_writtenresponse, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_cbms_wr <- as.data.frame(CBMS_wr_tagged)

CBMS_all_questions_df <- as.data.frame(CBMS_all_questions_char)

CBMS_Question_Tags <- data.frame(
  questions = CBMS_all_questions_df,
  tags = tagged_CBMS_df
)

colnames(CBMS_Question_Tags) <- list("Questions", "Tags")

CBMS_MC_Tags <- data.frame(
  Questions = CBMSMC_full,
  Tags = CBMS_mc_tagged
)
all_multiselect_CBMS <- as.data.frame(CBMS_all_multipleselect)

class(CBMS_all_multipleselect)

CBMS_MS_Tags <- data.frame(
  Questions = CBMS_all_multipleselect,
  Tags = tagged_cbms_ms$CBMS_ms_tagged
)

rownames(CBMS_MS_Tags) <- NULL

CBMS_TI_Tags <- data.frame(
  Questions = CBMS_all_tableinput,
  Tags = tagged_cbms_ti$CBMS_ti_tagged
)

rownames(CBMS_TI_Tags) <- NULL

CBMS_WR_Tags <- data.frame(
  Questions = CBMS_all_writtenresponse,
  Tags = tagged_cbms_wr$CBMS_wr_tagged
)

rownames(CBMS_WR_Tags) <- NULL

tagged_IPEDS <- sapply(IPEDS_all_questions, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_IPEDS_df <- as.data.frame(tagged_IPEDS)



#there were no tagged questions in the IPEDS survey, so I assigned each question type a value of zero.
IPEDS_multiplechoice_tagged <- sapply(IPEDS_MC, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_IPEDS_MC <- as.data.frame(IPEDS_multiplechoice_tagged)

IPEDS_multipleslect_tagged <- sapply(IPEDS_MS, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_IPEDS_MS <- as.data.frame(IPEDS_multipleslect_tagged)
rownames(tagged_IPEDS_MS) <- NULL


IPEDS_tableinput_tagged <- sapply(IPEDS_TI, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_IPEDS_TI <- as.data.frame(IPEDS_tableinput_tagged)

IPEDS_writtenresponse_tagged <- sapply(IPEDS_WR, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    NA
  }
})

tagged_IPEDS_WR <- as.data.frame(IPEDS_writtenresponse_tagged)

IPEDS_Question_Tags <- data.frame(
  Questions = IPEDS_all_questions,
  Tags = tagged_IPEDS_df$tagged_IPEDS
)

rownames(IPEDS_Question_Tags) <- NULL

IPEDS_MC_Tags <- data.frame(
  Questions = IPEDS_MC,
  Tags = tagged_IPEDS_MC$IPEDS_multiplechoice_tagged
)

rownames(IPEDS_MC_Tags) <- NULL

IPEDS_MS_Tags <- data.frame(
  Questions = IPEDS_MS,
  Tags = tagged_IPEDS_MS$IPEDS_multipleslect_tagged
)

rownames(IPEDS_MS_Tags) <- NULL

IPEDS_TI_Tags <- data.frame(
  Questions = IPEDS_TI,
  Tags = tagged_IPEDS_TI$IPEDS_tableinput_tagged
)

rownames(IPEDS_TI_Tags) <- NULL

IPEDS_WR_Tags <- data.frame(
  Questions = IPEDS_WR,
  Tags = tagged_IPEDS_WR$IPEDS_writtenresponse_tagged
)

rownames(IPEDS_WR_Tags) <- NULL

AMS_Question_Tags$Source <- "AMS"
CBMS_Question_Tags$Source <- "CBMS"
IPEDS_Question_Tags$Source <- "IPEDS"

big_question_tag_df <- rbind(AMS_Question_Tags, CBMS_Question_Tags, IPEDS_Question_Tags)

#Counting number of each question in big_question_tag_df
  #Counting AMS
AMS_Sources_Counts<- big_question_tag_df|>
  filter(Source == "AMS", !is.na(Tags))|>
  nrow()
AMS_Sources_Counts

  #Counting CMS
CBMS_Sources_Counts<- big_question_tag_df|>
  filter(Source == "CBMS", !is.na(Tags)) |>
  nrow() 
CBMS_Sources_Counts

  #Counting IPEDS
IPEDS_Sources_Counts<-big_question_tag_df|>
  filter (Source == "IPEDS", !is.na(Tags)) |>
  nrow()
IPEDS_Sources_Counts   

Counts_of_Tagged_Sources <- data.frame(
  AMS = AMS_Sources_Counts, 
  IPEDS = IPEDS_Sources_Counts, 
  CBMS = CBMS_Sources_Counts)

Counts_of_Tagged_Sources_long <- pivot_longer(
  as_tibble(Counts_of_Tagged_Sources),
  cols = everything(),
  names_to = "Source",
  values_to = "Number Tagged"
)

ggplot(Counts_of_Tagged_Sources_long, aes(x = Source, y = `Number Tagged`)) +
  geom_col() +
  scale_y_continuous(breaks = seq(0, max(Counts_of_Tagged_Sources_long$`Number Tagged`), by = 1))

  


  
  
  

  
