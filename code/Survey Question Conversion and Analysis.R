install.packages("ggplot2")
install.packages("tidyverse")
install.packages("tidytext")
install.packages("ggplot")
install.packages("reticulate")
install.packages("tibble")
install.packages("dplyr")
install.packages("SnowballC")
install.packages("tibble")
library(ggplot2)
library(tidyverse)
library(tidytext)
library(reticulate)
library(tibble)
library(dplyr)
library(SnowballC)
library(tibble)
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
  questions = AMS_questions_list,
  tags = tagged_AMS_df
)

AMS_MC_Tags <- data.frame(
  questions = AMS_MC,
  tags = ams_mc_tagged
)

AMS_MS_Tags <- data.frame(
  questions = AMS_MS,
  tags = ams_ms_tagged
)

AMS_TI_Tags <- data.frame(
  questions = AMS_TI,
  tags = ams_ti_tagged
)

AMS_WR_Tags <- data.frame (
  questions = AMS_WR,
  tags = ams_wr_tagged
)


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

CBMS_MC_Tags <- data.frame(
  questions = CBMSMC_full,
  tags = CBMS_mc_tagged
)
all_multiselect_CBMS <- as.data.frame(CBMS_all_multipleselect)

class(CBMS_all_multipleselect)

CBMS_MS_Tags <- data.frame(
  questions = CBMS_all_multipleselect,
  tags = tagged_cbms_ms$CBMS_ms_tagged
)

rownames(CBMS_MS_Tags) <- NULL

CBMS_TI_Tags <- data.frame(
  questions = CBMS_all_tableinput,
  tags = tagged_cbms_ti$CBMS_ti_tagged
)

rownames(CBMS_TI_Tags) <- NULL

CBMS_WR_Tags <- data.frame(
  questions = CBMS_all_writtenresponse,
  tags = tagged_cbms_wr$CBMS_wr_tagged
)

rownames(CBMS_TI_Tags) <- NULL

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
IPEDS_multiplechoice_tagged = 0 
IPEDS_multipleslect_tagged = 0
IPEDS_tableinput_tagged = 0
IPEDS_writtenresponse_tagged = 0 

tagged_AMS_count <- tagged_AMS_df[complete.cases(tagged_AMS_df),] |> length()
tagged_ams_mc_count <- ams_mc_tagged[complete.cases(ams_mc_tagged),] |> length()
tagged_ams_ms_count <- ams_ms_tagged[complete.cases(ams_ms_tagged),] |> length()
tagged_ams_ti_count <- ams_ti_tagged[complete.cases(ams_ti_tagged),] |> length()
tagged_ams_wr_count <- ams_wr_tagged[complete.cases(ams_wr_tagged),] |> length()

tagged_CBMS_count <- tagged_CBMS_df[complete.cases(tagged_CBMS_df),] |> length()
tagged_cbms_mc_count <- tagged_cbms_mc[complete.cases(tagged_cbms_mc),] |> length()
tagged_cbms_ms_count <- tagged_cbms_ms[complete.cases(tagged_cbms_ms),] |> length()
tagged_cbms_wr_count <-tagged_cbms_wr[complete.cases(tagged_cbms_wr),] |> length()
tagged_cbms_ti <- tagged_cbms_ti[complete.cases(tagged_cbms_ti),] |> length()


tagged_IPEDS_count <- tagged_IPEDS_df[complete.cases(tagged_IPEDS_df),] |> length()

ggplot




  
  
  

  


  
  
  

  
