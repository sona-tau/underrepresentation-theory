library(shiny)
library(shinydashboard)
library(shinylive)

ui <- dashboardPage(
	dashboardHeader(),
	dashboardSidebar(
		sidebarMenu(
			menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
			menuItem("Widgets", tabName = "widgets", icon = icon("th"))
		)
	),
	dashboardBody(
		tabItems(
			tabItem(
				tabName = "dashboard",
				fluidRow(
					box(plotOutput("plot1", height = 250)),

					box(title = "Controls", sliderInput("slider", "Number of observations:", 1, 100, 50))
				)
			),
			tabItem(
				tabName = "widgets",
				h2("Widgets tab content")
			)
		)
	)
)

server <- function(input, output) {
	set.seed(122)

	histdata <- rnorm(500)

	output $ plot1 <- renderPlot({
		data <- histdata[seq_len(input $ slider)]

		hist(data)
	})
}

shinylive::export(appdir = ".", destdir = "../../site")
shinyApp(ui, server, options = c(port = "6969"))
