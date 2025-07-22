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
CBMS_all_multipleselect = c(CBMS_MSp1, CBMS_MSp2)
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
    "Tags: None"
  }
})
tagged_AMS_list <- as.list(tagged_AMS)

CBMS_all_questions_char <- as.character(CBMS_all_questions)

tagged_CBMS <- sapply(CBMS_all_questions_char, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    "Tags: None"
  }
})

tagged_CBMS_list <- as.list(tagged_CBMS)

number_tagged_CBMS <- tagged_CBMS_list |>




tagged_IPEDS <- sapply(IPEDS_all_questions, function(text) {
  matches <- str_extract_all(text, paste(keywords, collapse = "|"))[[1]]
  if (length(matches) > 0) {
    paste("Tags:", paste(unique(matches), collapse = ", "))
  } else {
    "Tags: None"
  }
})

tagged_IPEDS_list <- as.list(tagged_IPEDS)







  
  
  

  
