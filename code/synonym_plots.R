library(ggplot2)
library(reshape2)
library(viridis)

data <- read.csv("data/synonym_thresholds.csv")
mat <- data.frame(
	data $ min,
	data $ q1,
	data $ median,
	data $ mean,
	data $ q3,
	data $ max
) |> as.matrix()

rownames(mat) <- list(
	"Google News",
	"GloVe 300-D",
	"GloVe 200-D",
	"GloVe 100-D",
	"GloVe 50-D"
) |> as.character()

colnames(mat) <- list(
	"Minimum",
	"First Quartile",
	"Median",
	"Mean",
	"Third Quartile",
	"Max"
)

ld <- melt(mat)
ld <- ld[ld $ value != 0,]

pdf("synonyms.pdf")
ggplot(ld, aes(x = Var2, y = Var1)) +
	geom_raster(aes(fill = value)) +
	scale_fill_viridis_c() +
	geom_text(aes(label = value)) +
	labs(x = "Quartiles", y = "Models") +
	theme_light() +
	theme(aspect.ratio = 1)
dev.off()
