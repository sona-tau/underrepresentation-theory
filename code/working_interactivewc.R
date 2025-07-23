load("big_question_tag_df.rda")
install.packages("wordcloud2")
install.packages("shiny")
install.packages("DT")
install.packages("stringr")
install.packages("tidyverse")
install.packages("tidytext")
install.packages("SnowballC")
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(shiny)
library(DT)
library(stringr)
library(SnowballC)

#head(big_question_tag_df)
#summary(big_question_tag_df)
#view(big_question_tag_df)

#Remove rows where Tags = NA
only_tag <- big_question_tag_df |>
  filter(Tags != "NA")
#view(only_tag)

tagged_ams <- only_tag |>
  filter(Source == "AMS")

tagged_cbms <- only_tag |>
  filter(Source == "CBMS")

#view(tagged_ams)
#view(tagged_cbms)

#All questions by source
ams_ques <- big_question_tag_df |>
  filter(Source == "AMS")




cbms_ques <- big_question_tag_df |>
  filter(Source == "CBMS")

ipeds_ques <- big_question_tag_df |>
  filter(Source == "IPEDS")

#Tokenization and wordcloud per source
#AMS
library(tibble)  # For as_tibble

# Convert to tibble explicitly
tidy_ams_ques <- as_tibble(ams_ques) |>
  unnest_tokens(word, Questions) |>
  anti_join(stop_words) |>
  filter(!str_detect(word, "^[0-9]+$"))

word_counts_ams <- tidy_ams_ques |>
  count(word, sort = TRUE) |>
  filter(n > 0)

#view(word_counts_ams)

#----CBMS
tidy_cbms_ques <- cbms_ques |>
  unnest_tokens(word, Questions) |>
  anti_join(stop_words) |>
  filter(!str_detect(word, "^[0-9]+$"))

word_counts_cbms <- tidy_cbms_ques |>
  count(word, sort = TRUE) |>
  filter(n > 5) |>
  filter(!str_detect(word, "_|b2|b1|e1|f1|e2|e.g|ii"))

view(word_counts_cbms)

#----IPEDS
tidy_ipeds_ques <- ipeds_ques |>
  unnest_tokens(word, Questions) |>
  anti_join(stop_words) |>
  filter(!str_detect(word, "^[0-9]+$"))

word_counts_ipeds <- tidy_ipeds_ques |>
  count(word, sort = TRUE) |>
  filter(n > 5) |>
  filter(!str_detect(word, "e.g"))

view(word_counts_ipeds)

library(wordcloud2)
library(shiny)
library(DT)
library(stringr)

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
ams_wc
# Interactive Shiny App for AMS Questions
ui = fluidPage(
  titlePanel("Interactive Word Cloud - AMS Survey Questions"),
  tags$script(HTML(
    "$(document).on('click', '#canvas', function() {
      word = $('#wcLabel').text();
      Shiny.onInputChange('clicked_word', word);
    });")),
  wordcloud2Output("wordcloud"),
  br(),
  h3("Questions containing the selected word:"),
  DTOutput("filtered_tbl")
)

server = function(input, output) {
  output$wordcloud = renderWordcloud2(ams_wc)
  
  filtered_questions = reactive({
    if(is.null(input$clicked_word)) {
      # Show empty table initially
      return(ams_ques[0,])
    }
    
    clicked_word = str_remove(input$clicked_word, ":[0-9]+$")
    
    ams_ques %>%
      filter(str_detect(tolower(Questions), tolower(clicked_word))) %>%
      select(Questions, Tags, Source, everything())
  })
  
  output$filtered_tbl = renderDT(
    filtered_questions(),
    options = list(pageLength = 10, scrollX = TRUE),
    rownames = FALSE
  )
}

#shinyApp(ui, server)

# CBMS Interactive App
cbms_wc = wordcloud2(
  word_counts_cbms,
  color = rep_len(my_palette,
                  nrow(word_counts_cbms)))
cbms_wc
ui_cbms = fluidPage(
  titlePanel("Interactive Word Cloud - CBMS Survey Questions"),
  tags$script(HTML(
    "$(document).on('click', '#canvas', function() {
      word = $('#wcLabel').text();
      Shiny.onInputChange('clicked_word', word);
    });")),
  wordcloud2Output("wordcloud"),
  br(),
  h3("Questions containing the selected word:"),
  DTOutput("filtered_tbl")
)

server_cbms = function(input, output) {
  output$wordcloud = renderWordcloud2(cbms_wc)
  
  filtered_questions = reactive({
    if(is.null(input$clicked_word)) {
      return(cbms_ques[0,])
    }
    
    clicked_word = str_remove(input$clicked_word, ":[0-9]+$")
    
    cbms_ques %>%
      filter(str_detect(tolower(Questions), tolower(clicked_word))) %>%
      select(Questions, Tags, Source, everything())
  })
  
  output$filtered_tbl = renderDT(
    filtered_questions(),
    options = list(pageLength = 10, scrollX = TRUE),
    rownames = FALSE
  )
}

# Uncomment to run CBMS app:
# shinyApp(ui_cbms, server_cbms)

# IPEDS Interactive App
ipeds_wc = wordcloud2(
  word_counts_ipeds,
  color = rep_len(my_palette,
                  nrow(word_counts_ipeds)))
ipeds_wc
ui_ipeds = fluidPage(
  titlePanel("Interactive Word Cloud - IPEDS Survey Questions"),
  tags$script(HTML(
    "$(document).on('click', '#canvas', function() {
      word = $('#wcLabel').text();
      Shiny.onInputChange('clicked_word', word);
    });")),
  wordcloud2Output("wordcloud"),
  br(),
  h3("Questions containing the selected word:"),
  DTOutput("filtered_tbl")
)

server_ipeds = function(input, output) {
  output$wordcloud = renderWordcloud2(ipeds_wc)
  
  filtered_questions = reactive({
    if(is.null(input$clicked_word)) {
      return(ipeds_ques[0,])
    }
    
    clicked_word = str_remove(input$clicked_word, ":[0-9]+$")
    
    ipeds_ques %>%
      filter(str_detect(tolower(Questions), tolower(clicked_word))) %>%
      select(Questions, Tags, Source, everything())
  })
  
  output$filtered_tbl = renderDT(
    filtered_questions(),
    options = list(pageLength = 10, scrollX = TRUE),
    rownames = FALSE
  )
}

# Uncomment to run IPEDS app:
# shinyApp(ui_ipeds, server_ipeds)