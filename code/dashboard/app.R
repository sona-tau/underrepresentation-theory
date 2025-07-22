library(shiny)
library(shinydashboard)
library(ggplot2)
library(viridis)
library(SnowballC)
source("data.R")

ui <- dashboardPage(
	dashboardHeader(),
	sidebarMenu(
		menuItem(
			"Home",
			tabName = "home",
			icon = icon("house-blank")
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
					selectInput(
						inputId = "selected_tag",
						label = "Select a tag below:",
						choices = tags |> as.list()
					) |> box(),
					htmlOutput(
						outputId = "filtered_sources",
					) |> box()
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

server <- function(input, output) {
	set.seed(122)

	histdata <- rnorm(500)

	output $ value <- renderText({
		input $ selected_tag
	})

	output $ filtered_sources <- renderText({
		sources <- get_df_tag(input $ selected_tag)
		sources <- sources[sources $ n != 0,]
		print(sources)
	})

	output $ occurrences_v_tags <- renderPlot({
#		ggplot(df, aes(fill = model, x = title, y = n)) +
#			geom_bar(position = "dodge", stat = "identity") +
#			scale_fill_viridis_d() +
#			labs(
#				x = "Data Source",
#				y = "Occurrences"
#			) +
#			theme_light() +
#			theme(aspect.ratio = 1)
	})
}

shinyApp(ui, server, options = list(port = 6969))
