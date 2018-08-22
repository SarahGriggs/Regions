

library(maptools)
library (ggplot2)
library(ggmap)
library(tmap)
library(rgdal)
library (maptools)
library (plyr)
library (dplyr)
library (tibble)
library (r2stl)
library(rgl)


regShp = readOGR(dsn=".", layer= "regShp")
regShp@data$id = rownames(regShp@data)
regShp.points = fortify(regShp, region="id")
region = join(regShp.points, regShp@data, by="id")


region$long <- floor(region$long)+125
region$lat <- floor(region$lat)
region <- unique(region)


z <- data.matrix(as.data.frame.matrix(xtabs(Jan17~long+lat,region)))
x <- 1:dim(z)[1]
y <- 1:dim(z)[2]


r2stl(x, y, z, filename = "RegiontoDolla.stl", show.persp = TRUE)
