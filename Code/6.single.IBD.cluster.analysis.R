library(ggplot2)
library(RColorBrewer)
library("maps")
library("mapdata")
library("maptools")
library("scales")
library("gplots")
library("rnaturalearth")
library("rnaturalearthdata")
library("sf")
require(sp)
require(rgdal)
library(ggrepel)
library(geosphere)
library(animation)
library(grid)
library(gridExtra)
library(ggmap)
library(ggsn)
library(raster)
library(beepr)
library(tictoc)
library(dplyr)
library(ggspatial)
library(gridExtra)
library(ggpubr)

library(raster)
library(gdalUtils)
library(rgdal)

# Plot SE Asia region: background
world <- ne_countries(scale = "large", returnclass = "sf")
class(world)

sf::sf_use_s2(FALSE)
world_points <- st_centroid(world) 
world_points <- cbind(world, st_coordinates(st_centroid(world$geometry))) 

# read in Myanmer polygons
Myan <-readOGR("C:/Users/xli/Dropbox (TX Biomed)/Emily/3.Myan/4.final.Myan.2023/1.1.sample.location.map/Myan.map/mmr_polbnda_adm0_250k_mimu/mmr_polbnda_adm0_250k_mimu.shp", stringsAsFactors=FALSE)
Myan2 <-readOGR("C:/Users/xli/Dropbox (TX Biomed)/Emily/3.Myan/4.final.Myan.2023/1.1.sample.location.map/Myan.map/mmr_polbnda_250k_adm2_mimu/mmr_polbnda_250k_adm2_mimu.shp", stringsAsFactors=FALSE)
Thai <- map_data("world", region = c("Thailand"))
kayin <-readOGR("C:/Users/xli/Dropbox (TX Biomed)/Emily/3.Myan/1.METF_bigdataset/Transimission_Myan/IBD_by_village/Myan_map/kayin_state_village_tract_boundaries/kayin_state_village_tract_boundaries.shp", stringsAsFactors=FALSE)

Myan2.Hpapun <- Myan2[Myan2$DT == "Hpapun",]
Myan2.Hlaingbwe <- kayin[kayin$TS == "Hlaingbwe",]
Myan2.Kawkareik <- Myan2[Myan2$DT == "Kawkareik",]
Myan2.Myawaddy <- Myan2[Myan2$DT == "Myawaddy",]

Hpapun <- kayin[kayin$TS == "Hpapun",]
road <- readOGR("C:/Users/xli/Dropbox (TX Biomed)/Emily/3.Myan/4.final.Myan.2023/1.1.sample.location.map/Myan.map/mmr_rdsl_250k_mimu/mmr_rdsl_250k_mimu.shp", stringsAsFactors=FALSE)
road.Main <- road[road$Road_Type == "main", ]
river <-readOGR("C:/Users/xli/Dropbox (TX Biomed)/Emily/3.Myan/4.final.Myan.2023/1.1.sample.location.map/Myan.map/myanmar_river_network/myanmar_river_network.shp", stringsAsFactors=FALSE)
river.large <-readOGR("C:/Users/xli/Dropbox (TX Biomed)/Emily/3.Myan/4.final.Myan.2023/1.1.sample.location.map/Myan.map/myanmar_river_network_250k/myanmar_river_network_250k.shp", stringsAsFactors=FALSE)


############################################################################
### plot single IBD cluster
setwd("C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/New.analysis.2024/6.individual.IBD.cluster")
seq.info <- read.csv("C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/Figure5_location/location/sample.info.csv", header=T, sep=",")

IBD.info <- read.csv("IBD.info.csv", header=T, sep=",")

p1 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "#FFDB6D") +
scale_size(range = c(1,8), limits = c(1,40))

p1 

p2 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster2"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "lightgreen")+
scale_size(range = c(1,8), limits = c(1,40))
p2 

p3 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster3"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "purple")+
scale_size(range = c(1,8), limits = c(1,40))
p3 

p4 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster4"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "#0072B2")+
scale_size(range = c(1,8), limits = c(1,40))
p4 

p5 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster5"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "purple")+
scale_size(range = c(1,8), limits = c(1,40))
p5 

p6 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster6"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "lightblue")+
scale_size(range = c(1,8), limits = c(1,40))
p6 

p7 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster7"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "lightblue")+
scale_size(range = c(1,8), limits = c(1,40))
p7 

p8 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster8"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "lightblue")+
scale_size(range = c(1,8), limits = c(1,40))
p8 

p9 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster9"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "lightblue")+
scale_size(range = c(1,8), limits = c(1,40))
p9 

p10 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster10"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "lightblue")+
scale_size(range = c(1,8), limits = c(1,40))
p10 


p.C580Y <- ggplot(data = world) + geom_sf(color = "white", fill = NA, size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan, aes(x = long, y = lat, group = group),color = "black", fill= "azure",size = 0.5)+
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster25"),], aes(x = Longitude, y = Latitude, size = Count), shape = 24, fill = "red")+
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster29"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "red")+
geom_point(data = IBD.info[IBD.info$IBD.cluster %in% c("Cluster39"),], aes(x = Longitude, y = Latitude, size = Count), shape = 23, fill = "red")+
# geom_point(data = IBD.info[IBD.info$kelch13.clean %in% c("C580Y"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "red")+
scale_size(range = c(1,8), limits = c(1,10))
p.C580Y

pdf('Figure.C580Y.pdf', width=16, height=24) 

ggarrange(
p.C580Y,
ncol = 3, nrow = 4)
 
dev.off()


pdf('Figure.top10IBD.colored.byk13.raw.data.pdf', width=16, height=24) 
ggarrange(
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,
ncol = 3, nrow = 4)
 
dev.off()

##########################################################################################
# 4. R561 outbreak: Plot maps showing R561H clone (in yellow) vs all others, across time. This should show how R561H clone emerges, because all other haplotypes have been eliminated.
R561H.info <- read.csv("R561H.by.year.csv", header=T, sep=",")

R561H.info.2016 <- R561H.info[R561H.info$Year %in% c("2016"),]
R561H.info.2017 <- R561H.info[R561H.info$Year %in% c("2017"),]
R561H.info.2018 <- R561H.info[R561H.info$Year %in% c("2018"),]
R561H.info.2019 <- R561H.info[R561H.info$Year %in% c("2019"),]
R561H.info.2020 <- R561H.info[R561H.info$Year %in% c("2020"),]

p.2016 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "white", color = "black") + # METF hotspot
# geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = R561H.info.2016[R561H.info.2016$IBD.cluster %!in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), color = "black", shape = 21, fill = NA, stroke = .5) +
geom_point(data = R561H.info.2016[R561H.info.2016$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "#FFDB6D") +
# geom_point(data = R561H.info.2016[R561H.info.2016$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "red") +
scale_size(range = c(1,8), limits = c(1,40))

p.2016

p.2017 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "white", color = "black") + # METF hotspot
# geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = R561H.info.2017[R561H.info.2017$IBD.cluster %!in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), color = "black", shape = 21, fill = NA, stroke = .5) +
geom_point(data = R561H.info.2017[R561H.info.2017$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "#FFDB6D") +
# geom_point(data = R561H.info.2017[R561H.info.2017$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "red") +
scale_size(range = c(1,8), limits = c(1,40))

p.2017


p.2018 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "white", color = "black") + # METF hotspot
# geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = R561H.info.2018[R561H.info.2018$IBD.cluster %!in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), color = "black", shape = 21, fill = NA, stroke = .5) +
geom_point(data = R561H.info.2018[R561H.info.2018$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "#FFDB6D") +
# geom_point(data = R561H.info.2018[R561H.info.2018$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "red") +
scale_size(range = c(1,8), limits = c(1,40))

p.2018


p.2019 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "white", color = "black") + # METF hotspot
# geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = R561H.info.2019[R561H.info.2019$IBD.cluster %!in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), color = "black", shape = 21, fill = NA, stroke = .5) +
geom_point(data = R561H.info.2019[R561H.info.2019$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "#FFDB6D") +
# geom_point(data = R561H.info.2019[R561H.info.2019$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "red") +
scale_size(range = c(1,8), limits = c(1,40))

p.2019



p.2020 <- ggplot() + geom_sf(color = "black", fill = "white", size = 0.5) +
coord_sf(xlim = c(96.5,98.5), ylim = c(17,19), expand = FALSE) +
xlab("Longitude") + ylab("Latitude") +
geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "white", color = "black") + # METF hotspot
# geom_polygon(data = Myan2.Hpapun, aes(x = long, y = lat, group = group), fill= "#E69F00") + # METF hotspot
annotation_scale(location = "tr", width_hint = 0.2) +
theme(panel.grid.major = element_line(color = gray(.9), linetype = "dashed", size = 0.5), panel.background = element_rect(fill = "white")) +
geom_point(data = R561H.info.2020[R561H.info.2020$IBD.cluster %!in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), color = "lightgrey", shape = 21, fill = NA, stroke = .5) +
geom_point(data = R561H.info.2020[R561H.info.2020$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "#FFDB6D") +
# geom_point(data = R561H.info.2020[R561H.info.2020$IBD.cluster %in% c("Cluster1"),], aes(x = Longitude, y = Latitude, size = Count), shape = 21, fill = "red") +
scale_size(range = c(1,8), limits = c(1,40))

p.2020


pdf('Figure.R561H.and.all_raw.data.pdf', width=16, height=24) 

ggarrange(
p.2016,p.2017,p.2018,p.2019,p.2020,
ncol = 3, nrow = 4)
 
dev.off()
