##################################################################################################
library(ggplot2)
library(ggpubr)
library(dplyr)
library(reshape2)
library(geosphere)

#########################################################################################################
#########################################################################################################
setwd("C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/New.analysis.2024/5.time.and.relatedness")
village.info <- read.csv("C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/New.analysis.2024/3.Pie.plot/Sample.by.HCPC.csv", header=T, sep=",")

IBD.dis <- read.table("IBD.dis.date.village.txt",sep="\t",row.names=1)

IBD.dis.0m.6m <- subset(IBD.dis, diff_in_days >= 0 & diff_in_days <= 30*6)
IBD.dis.0m.12m <- subset(IBD.dis, diff_in_days >= 0 & diff_in_days <= 30*12)
IBD.dis.12m.24m <- subset(IBD.dis, diff_in_days >= 30*12 & diff_in_days <= 30*24)
IBD.dis.24m.36m <- subset(IBD.dis, diff_in_days >= 30*24 & diff_in_days <= 30*36)
IBD.dis.36m.48m <- subset(IBD.dis, diff_in_days >= 30*36 & diff_in_days <= 30*48)

Info <- village.info[,c("HCPC.myID","new.HCPC.ID","ID")]
Info <- Info[Info$new.HCPC.ID >= 1, ]  # Info$new.HCPC.ID = 0 low sample HCPC cluster
colnames(Info) <- c("VT_PCODE","village.ID","ID")

> head(Info)
  VT_PCODE village.ID          ID
1 region17         18  METF.HRP.1
2 region38         17 METF.HRP.15
3 region28          8 METF.HRP.25
4 region12          6      MP0306
5 region28          8      MS0007
6 region28          8 METF.HRP.53

#########################################################################################################

result <- NULL

#########################################################################################################
# month.0to12
for(i in 1:29){
	for(j in 1:29){
	
village1 <- Info[Info$village.ID == i, ]$ID
village2 <- Info[Info$village.ID == j, ]$ID

pair.dat1 <- subset(IBD.dis.0m.12m, sample1 %in% village1 & sample2 %in% village2)
pair.dat2 <- subset(IBD.dis.0m.12m, sample1 %in% village2 & sample2 %in% village1)
pair.dat <- rbind(pair.dat1,pair.dat2)

M <- pair.dat[,1:3]

Total <- nrow(M)
count.45 <- nrow(M[M$fract_sites_IBD >= 0.45, ])
prop.45 <- count.45/Total
mean.IBD <- mean(M$fract_sites_IBD)

result <- rbind(result, c(unique(Info[Info$village.ID == i, ]$VT_PCODE), unique(Info[Info$village.ID == j, ]$VT_PCODE), prop.45, log(prop.45), mean.IBD, "month.0to12"))

}
}

#########################################################################################################
# month.12to24
for(i in 1:29){
	for(j in 1:29){
	
village1 <- Info[Info$village.ID == i, ]$ID
village2 <- Info[Info$village.ID == j, ]$ID

pair.dat1 <- subset(IBD.dis.12m.24m, sample1 %in% village1 & sample2 %in% village2)
pair.dat2 <- subset(IBD.dis.12m.24m, sample1 %in% village2 & sample2 %in% village1)
pair.dat <- rbind(pair.dat1,pair.dat2)

M <- pair.dat[,1:3]

Total <- nrow(M)
count.45 <- nrow(M[M$fract_sites_IBD >= 0.45, ])
prop.45 <- count.45/Total
mean.IBD <- mean(M$fract_sites_IBD)

result <- rbind(result, c(unique(Info[Info$village.ID == i, ]$VT_PCODE), unique(Info[Info$village.ID == j, ]$VT_PCODE), prop.45, log(prop.45), mean.IBD, "month.12to24"))

}
}

#########################################################################################################
# month.24to36
for(i in 1:29){
	for(j in 1:29){
	
village1 <- Info[Info$village.ID == i, ]$ID
village2 <- Info[Info$village.ID == j, ]$ID

pair.dat1 <- subset(IBD.dis.24m.36m, sample1 %in% village1 & sample2 %in% village2)
pair.dat2 <- subset(IBD.dis.24m.36m, sample1 %in% village2 & sample2 %in% village1)
pair.dat <- rbind(pair.dat1,pair.dat2)

M <- pair.dat[,1:3]

Total <- nrow(M)
count.45 <- nrow(M[M$fract_sites_IBD >= 0.45, ])
prop.45 <- count.45/Total
mean.IBD <- mean(M$fract_sites_IBD)

result <- rbind(result, c(unique(Info[Info$village.ID == i, ]$VT_PCODE), unique(Info[Info$village.ID == j, ]$VT_PCODE), prop.45, log(prop.45), mean.IBD, "month.24to36"))

}
}

#########################################################################################################
# month.36to48
for(i in 1:29){
	for(j in 1:29){
	
village1 <- Info[Info$village.ID == i, ]$ID
village2 <- Info[Info$village.ID == j, ]$ID

pair.dat1 <- subset(IBD.dis.36m.48m, sample1 %in% village1 & sample2 %in% village2)
pair.dat2 <- subset(IBD.dis.36m.48m, sample1 %in% village2 & sample2 %in% village1)
pair.dat <- rbind(pair.dat1,pair.dat2)

M <- pair.dat[,1:3]

Total <- nrow(M)
count.45 <- nrow(M[M$fract_sites_IBD >= 0.45, ])
prop.45 <- count.45/Total
mean.IBD <- mean(M$fract_sites_IBD)

result <- rbind(result, c(unique(Info[Info$village.ID == i, ]$VT_PCODE), unique(Info[Info$village.ID == j, ]$VT_PCODE), prop.45, log(prop.45), mean.IBD, "month.36to48"))

}
}

#########################################################################################################
colnames(result) <- c("village1","village2","prop.45","ln.prop.45","mean.IBD", "mon.dis")
result <- as.data.frame(result) 

villages <- village.info[,c("HCPC.myID","HCPC.mean.Latitude","HCPC.mean.Longitude")]
villages <- unique(villages)

result <- inner_join(result, villages, by = c("village1" = "HCPC.myID")) # Because Id columns names are different
result <- inner_join(result, villages, by = c("village2" = "HCPC.myID")) # Because Id columns names are different

> dim(result)
[1] 4205   10

colnames(result)[7:10] <- c("Lat.v1","Lon.v1","Lat.v2","Lon.v2")

result$dis.km <- ""

for(i in c(1:4205)){
a <- c(result$Lon.v1[i],result$Lat.v1[i])
b <- c(result$Lon.v2[i],result$Lat.v2[i])
result$dis.km[i] <- distm(a, b, fun = distHaversine)/1000
}

result[result == -Inf] <- NA

villages.color <- unique(village.info[,c("HCPC.myID","HCPC.cluster")])

result <- inner_join(result, villages.color, by = c("village1" = "HCPC.myID")) # Because Id columns names are different
result <- inner_join(result, villages.color, by = c("village2" = "HCPC.myID")) # Because Id columns names are different
colnames(result)[12:13] <- c("HCPC.cluster.v1","HCPC.cluster.v2")

write.csv(result,"result_distance.and.relatedness.in.HCPC.cluster.level_by.month.dis_03.31.2025.csv", row.names=TRUE)

#########################################################################################################

result <- read.csv("result_distance.and.relatedness.in.HCPC.cluster.level_by.month.dis_03.31.2025.csv", header=T, sep=",")

result$mon.dis <- as.factor(result$mon.dis)
 
result$mon.dis <- factor(result$mon.dis,
    levels = c("month.0to6","month.0to12", "month.12to24", "month.24to36", "month.36to48"),ordered = TRUE)

result.color <- result

result.color$group <- factor(result.color$group,
    levels = c("within","between"),ordered = TRUE)

myColors.a <- c("grey", "white")
names(myColors.a) <- levels(result.color$group)

> myColors.a
 within between 
 "grey" "white" 

colScale.a <- scale_colour_manual(name = "group",values = myColors.a)
filScale.a <- scale_fill_manual(name = "group",values = myColors.a)

result.color <- result.color[result.color$mon.dis %in% c("month.0to12", "month.12to24", "month.24to36", "month.36to48"), ]

p.IBD.45 <- ggplot(result.color, aes(x=mon.dis, y=ln.prop.45, fill=group)) + 
  geom_boxplot(outliers = FALSE,outlier.shape = NA, width = 0.5) + 
  labs(x="Time range (month)",  y = expression(paste("Log(R[", italic("r"), ">=", "0.45])"))) + 
  theme_classic(base_size = 12) +
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))+
  filScale.a + colScale.a 
p.IBD.45

p.IBD.45.raw <- ggplot(result.color, aes(x=mon.dis, y=prop.45, fill=group)) + 
  geom_boxplot(outliers = FALSE,outlier.shape = NA, width = 0.5) + 
  labs(x="Time range (month)",  y = expression(paste("R[", italic("r"), ">=", "0.45]"))) + 
  theme_classic(base_size = 12) +
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))+
  filScale.a + colScale.a 
p.IBD.45.raw

p.mean.IBD <- ggplot(result.color, aes(x=mon.dis, y=mean.IBD, fill=group)) + 
  geom_boxplot(outliers = FALSE,outlier.shape = NA, width = 0.5) + 
  theme_classic(base_size = 12) +
  labs(x="Time range (month)",  y = "Average IBD")+ 
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14)) +
  filScale.a + colScale.a 
p.mean.IBD


pdf('Figure.distance.time_03.31.2025.pdf', width=6, height=12)
ggarrange(
p.IBD.45,p.mean.IBD,p.IBD.45.raw, 
          ncol = 1, nrow = 3)
dev.off()
