##################################################################################################
library("ggplot2")
library("ggpubr")
setwd("C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/New.analysis.2024/8.MDA")

##################################################################################################
load('C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/New.analysis.2024/5.time.and.relatedness/Mantel.individual.RData')
> dim(dat)
[1] 1726 1726
> dat[1:5,1:5]
            METF.HRP.1 METF.HRP.11 METF.HRP.13 METF.HRP.14 METF.HRP.15
METF.HRP.1       1.000       0.025       0.000       0.000       0.087
METF.HRP.11      0.025       1.000       0.018       0.031       0.060
METF.HRP.13      0.000       0.018       1.000       0.012       0.040
METF.HRP.14      0.000       0.031       0.012       1.000       0.011
METF.HRP.15      0.087       0.060       0.040       0.011       1.000

> dim(IBD.dis)
[1] 1471470      15

> head(IBD.dis)
     sample1     sample2 fract_sites_IBD   Lat.s1   Lon.s1   Lat.s2   Lon.s2    dis.km    Date.s1 Village.s1 Village.color.s1    Date.s2 Village.s2
1 METF.HRP.1 METF.HRP.11         0.02531 17.91673 97.35067 17.84845 97.34468  7.626776 2015-11-18   region17             Blue 2017-03-23   region21
2 METF.HRP.1 METF.HRP.13         0.00000 17.91673 97.35067 17.74392 97.53331 27.288278 2015-11-18   region17             Blue 2018-12-18   region33
3 METF.HRP.1 METF.HRP.14         0.00000 17.91673 97.35067 18.06109 97.25451 19.024295 2015-11-18   region17             Blue 2017-01-13   region11
4 METF.HRP.1 METF.HRP.15         0.08659 17.91673 97.35067 17.56951 97.72688 55.541490 2015-11-18   region17             Blue 2015-12-21   region38
5 METF.HRP.1 METF.HRP.17         0.09208 17.91673 97.35067 17.92499 97.59927 26.346676 2015-11-18   region17             Blue 2016-06-16   region32
6 METF.HRP.1  METF.HRP.2         0.01547 17.91673 97.35067 17.78334 97.29668 15.913152 2015-11-18   region17             Blue 2017-03-20   region19
  Village.color.s2 diff_in_days
1            Green          491
2            Green         1126
3            Green          422
4      unclustered           33
5            Green          211
6           Purple          488

##################################################################################################
## compare MDA
# pair.info <- read.csv("Pairs.HCPC.csv", header=T, sep=",")
pair.info <- read.csv("Pairs.HCPC_adjust.date_05.12.2025.csv", header=T, sep=",")
pair.info <- pair.info[,c("Pair.ID","Before.or.after","ID")]
> head(pair.info)
  Pair.ID Before.or.after     ID
1       1          before MP1416
2       1          before MP1708
3       1          before MP1624
4       1          before MP1669
5       1          before MP1723
6       1          before MP1724

result <- NULL

for(i in 1:12){

per.pair <- pair.info[pair.info$Pair.ID == i, ]

before <- per.pair[per.pair$Before.or.after == "before",]$ID
after <- per.pair[per.pair$Before.or.after == "after",]$ID

pair.dat1 <- subset(IBD.dis, sample1 %in% before & sample2 %in% after)
pair.dat2 <- subset(IBD.dis, sample1 %in% after & sample2 %in% before)
pair.dat <- rbind(pair.dat1,pair.dat2)

M <- pair.dat[,1:3]

Total <- nrow(M)
count.45 <- nrow(M[M$fract_sites_IBD >= 0.45, ])
prop.45 <- count.45/Total

count.90 <- nrow(M[M$fract_sites_IBD >= 0.90, ])
prop.90 <- count.90/Total

mean.IBD <- mean(M$fract_sites_IBD)

result <- rbind(result, c(prop.45, prop.90, mean.IBD, "before.after"))

}


for(i in 1:12){

per.pair <- pair.info[pair.info$Pair.ID == i, ]

before <- per.pair[per.pair$Before.or.after == "before",]$ID

pair.dat1 <- subset(IBD.dis, sample1 %in% before & sample2 %in% before)
pair.dat <- pair.dat1

M <- pair.dat[,1:3]

Total <- nrow(M)
count.45 <- nrow(M[M$fract_sites_IBD >= 0.45, ])
prop.45 <- count.45/Total

count.90 <- nrow(M[M$fract_sites_IBD >= 0.90, ])
prop.90 <- count.90/Total

mean.IBD <- mean(M$fract_sites_IBD)

result <- rbind(result, c(prop.45, prop.90, mean.IBD, "before.before"))

}



for(i in 1:12){

per.pair <- pair.info[pair.info$Pair.ID == i, ]

after <- per.pair[per.pair$Before.or.after == "after",]$ID

pair.dat1 <- subset(IBD.dis, sample1 %in% after & sample2 %in% after)
pair.dat <- pair.dat1

M <- pair.dat[,1:3]

Total <- nrow(M)
count.45 <- nrow(M[M$fract_sites_IBD >= 0.45, ])
prop.45 <- count.45/Total

count.90 <- nrow(M[M$fract_sites_IBD >= 0.90, ])
prop.90 <- count.90/Total

mean.IBD <- mean(M$fract_sites_IBD)

result <- rbind(result, c(prop.45, prop.90, mean.IBD, "after.after"))

}


write.csv(result,"result.csv")


##################################################################################################

# result <- read.csv("result.csv", header=T, sep=",")

result <- read.csv("result_adjust.date_05.12.2025.csv", header=T, sep=",")

result$MDA <- as.factor(result$MDA)
result$MDA <- factor(result$MDA, levels = c("NO","YES"),ordered = TRUE)

result.color <- result

myColors.a <- c("white", "grey")
names(myColors.a) <- levels(result.color$MDA)

> myColors.a
    YES      NO 
 "grey" "white" 

colScale.a <- scale_colour_manual(name = "MDA",values = myColors.a)
filScale.a <- scale_fill_manual(name = "MDA",values = myColors.a)

p.IBD.90 <- ggplot(result.color, aes(x=MDA, y=IBD.90, fill=MDA)) + 
  geom_boxplot(outliers = FALSE,outlier.shape = NA, width = 0.5) + 
  geom_dotplot(binaxis='y', stackdir='center', dotsize=1) + 
  labs(x="If MDA",  y = "Connectivity (R0.9)") + 
  theme_classic(base_size = 12) +
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))+
  filScale.a + colScale.a 
p.IBD.90

p.IBD.45 <- ggplot(result.color, aes(x=MDA, y=IBD.45, fill=MDA)) + 
  geom_boxplot(outliers = FALSE,outlier.shape = NA, width = 0.5) + 
  geom_dotplot(binaxis='y', stackdir='center', dotsize=1) + 
  labs(x="If MDA",  y = "Connectivity (R0.45)") + 
  theme_classic(base_size = 12) +
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))+
  filScale.a + colScale.a 
p.IBD.45


p.meanIBD <- ggplot(result.color, aes(x=MDA, y=mean.IBD_before.after, fill=MDA)) + 
  geom_boxplot(outliers = FALSE,outlier.shape = NA, width = 0.5) + 
  geom_dotplot(binaxis='y', stackdir='center', dotsize=1) + 
  labs(x="If MDA",  y = "Average IBD") + 
  theme_classic(base_size = 12) +
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))+
  filScale.a + colScale.a 
p.meanIBD


p.prop.45_before.after <- ggplot(result.color, aes(x=MDA, y=prop.45_before.after, fill=MDA)) + 
  geom_boxplot(outliers = FALSE,outlier.shape = NA, width = 0.5) + 
  geom_dotplot(binaxis='y', stackdir='center', dotsize=1) + 
  labs(x="If MDA",  y = "Relatedness (R0.45)") + 
  theme_classic(base_size = 12) +
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))+
  filScale.a + colScale.a 
p.prop.45_before.after


p.prop.90_before.after <- ggplot(result.color, aes(x=MDA, y=prop.90_before.after, fill=MDA)) + 
  geom_boxplot(outliers = FALSE,outlier.shape = NA, width = 0.5) + 
  geom_dotplot(binaxis='y', stackdir='center', dotsize=1) + 
  labs(x="If MDA",  y = "Relatedness (R0.90)") + 
  theme_classic(base_size = 12) +
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))+
  filScale.a + colScale.a 
p.prop.90_before.after


pdf('Figure.MDA.related.pdf', width=9, height=7)
ggarrange(
p.IBD.90, p.IBD.45,  p.meanIBD, p.prop.45_before.after, p.prop.90_before.after, 
          ncol = 3, nrow = 2)
dev.off()

#########################################################################################################
# siginificant test:

# Connectivity IBD.90
A <- result.color[result.color$MDA %in% c("NO"), ]$IBD.90
B <- result.color[result.color$MDA %in% c("YES"), ]$IBD.90
t.test(A,B)

> t.test(A,B)

        Welch Two Sample t-test

data:  A and B
t = 6.8056, df = 9.9775, p-value = 4.761e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.3506020 0.6920775
sample estimates:
mean of x mean of y 
0.6720608 0.1507210 

# mean.IBD_before.after
A <- result.color[result.color$MDA %in% c("NO"), ]$mean.IBD_before.after
B <- result.color[result.color$MDA %in% c("YES"), ]$mean.IBD_before.after
t.test(A,B)

> t.test(A,B)

        Welch Two Sample t-test

data:  A and B
t = 3.1673, df = 9.5053, p-value = 0.01067 # this number in final plot
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.03658977 0.21443378
sample estimates:
mean of x mean of y 
0.2546928 0.1291810 

# Relatedness (R0.45)
A <- result.color[result.color$MDA %in% c("NO"), ]$prop.45_before.after
B <- result.color[result.color$MDA %in% c("YES"), ]$prop.45_before.after
t.test(A,B)

> t.test(A,B)

        Welch Two Sample t-test

data:  A and B
t = 2.9153, df = 8.3802, p-value = 0.01849
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.02964418 0.24584916
sample estimates:
 mean of x  mean of y 
0.22220633 0.08445967 

# Relatedness (R0.90)
A <- result.color[result.color$MDA %in% c("NO"), ]$prop.90_before.after
B <- result.color[result.color$MDA %in% c("YES"), ]$prop.90_before.after
t.test(A,B)

> t.test(A,B)

        Welch Two Sample t-test

data:  A and B
t = 3.9798, df = 9.7612, p-value = 0.002729
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.07746863 0.27605204
sample estimates:
mean of x mean of y 
0.2046743 0.0279140 
