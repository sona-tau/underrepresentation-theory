library(shiny)
library(shinydashboard)
library(ggplot2)
library(viridis)
library(SnowballC)
library(bslib)

load("data/glove_100d_0.219_AMS.Rda")
sema_count_glove_100d_ams <- sema_count
load("data/glove_100d_0.219_CBMS.Rda")
sema_count_glove_100d_cbms <- sema_count
load("data/glove_100d_0.219_IPEDS.Rda")
sema_count_glove_100d_ipeds <- sema_count
load("data/glove_200d_0.164_AMS.Rda")
sema_count_glove_200d_ams <- sema_count
load("data/glove_200d_0.164_CBMS.Rda")
sema_count_glove_200d_cbms <- sema_count
load("data/glove_200d_0.164_IPEDS.Rda")
sema_count_glove_200d_ipeds <- sema_count
load("data/glove_300d_0.134_AMS.Rda")
sema_count_glove_300d_ams <- sema_count
load("data/glove_300d_0.134_CBMS.Rda")
sema_count_glove_300d_cbms <- sema_count
load("data/glove_300d_0.134_IPEDS.Rda")
sema_count_glove_300d_ipeds <- sema_count
load("data/glove_50d_0.273_AMS.Rda")
sema_count_glove_50d_ams <- sema_count
load("data/glove_50d_0.273_CBMS.Rda")
sema_count_glove_50d_cbms <- sema_count
load("data/glove_50d_0.273_IPEDS.Rda")
sema_count_glove_50d_ipeds <- sema_count
load("data/google_news_0.185_AMS.Rda")
sema_count_google_ams <- sema_count
load("data/google_news_0.185_CBMS.Rda")
sema_count_google_cbms <- sema_count
load("data/google_news_0.185_IPEDS.Rda")
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



# These are the tags that are used to categorize the data.
lgbt_tags <- c("lgbt","lgbtq","sex","identity","gender","orientation","nonbinary") |> as.character()
race_ethnicity_tags <- c("race","ethnicity","african","american","black","hispanic","asian","indigenous","native","latino","latina","latine") |> as.character()
women_tags <- c("woman","women","girl","feminine","femeninity","ms","mrs") |> as.character()
men_tags <- c("man", "men", "boy", "male", "masculine", "masculinity", "mr") |> as.character()
disabilities_tags <- c("disabilities","disabled","disability","handicap","handicapped","neurodivergent") |> as.character()

# This variable holds all of the tags. Additionally, tag_categories holds all
# the tags together with their categories.
tags <- c(lgbt_tags, race_ethnicity_tags, women_tags, men_tags, disabilities_tags)
tag_categories <- list(
	"lgbt",
	"race/ethnicity",
	"women",
	"disabilities"
) |> as.character()

ui <- dashboardPage(
	dashboardHeader(),
	sidebarMenu(
		menuItem(
			"Home",
			tabName = "home",
			icon = icon("house")
		),
		menuItem(
			"Dashboard",
			tabName = "dashboard",
			icon = icon("dashboard")
		),
		menuItem(
			"About",
			tabName = "about",
			icon = icon("info")
		)
	) |> dashboardSidebar(),
	tabItems(
		tabItem(
			tabName = "home",
			h2("Home information.")
		),
		tabItem(
			tabName = "dashboard",
			fluidRow(
				box(
					h3("Options:"),
					radioButtons(
						inputId = "selected_tag",
						label = "Select a tag category below:",
						choices = tag_categories |> as.list()
					),
					selectizeInput(
						inputId = "selected_sources",
						label = "Select a data source below:",
						choices = list("AMS", "CBMS", "IPEDS") |> as.character(),
						multiple = TRUE
					),
					selectizeInput(
						"selected_models",
						label = "Select models to show:",
						choices = list(
							"Google News" = "Google News",
							"GloVe 300D" = "GloVe 300D",
							"GloVe 200D" = "GloVe 200D",
							"GloVe 100D" = "GloVe 100D",
							"GloVe 50D" = "GloVe 50D"
						),
						multiple = TRUE
					)
				),
				plotOutput("occurrences_v_tags")
			)
		),
		tabItem(
			tabName = "about",
			h2("About information.")
		)
	) |> dashboardBody()
)

get_rows <- function(tag_category, data_sources, models) {
	df <- get_df(tag_category)

	mask1 <- logical(length = nrow(df))
	mask2 <- logical(length = nrow(df))
	for (data_source in data_sources) {
		mask1 <- mask1 | (df $ title == data_source)
	}
	for (model in models) {
		mask2 <- mask2 | (df $ model == model)
	}
	df <- df[mask1 & mask2,]
	df
}

server <- function(input, output) {
	set.seed(122)

	histdata <- rnorm(500)

	output $ occurrences_v_tags <- renderPlot({
		df <- get_rows(
			tag_category = input $ selected_tag,
			data_source = input $ selected_sources,
			models = input $ selected_models
		)

		ggplot(df, aes(fill = model, x = title, y = n)) +
			geom_bar(position = "dodge", stat = "identity") +
			scale_fill_viridis_d() +
			labs(
				title = paste("Occurrences of", input $ selected_tag, "per data source"),
				x = "Data Source",
				y = "Occurrences"
			) +
			theme_light() +
			theme(aspect.ratio = 1)
	})
}

shinyApp(ui, server, options = list(port = 6969))
