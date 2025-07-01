############################################################################
### 
setwd("C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/New.analysis.2024/7.Correlograms")

##### get data
# Load necessary libraries
library(ape)
library(geosphere)
library(adegenet)
library(spdep)

load('C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/New.analysis.2024/5.time.and.relatedness/Mantel.individual.RData')
seq.info <- read.csv("C:/Users/xli/TX Biomed Dropbox/Xue Li/Emily/3.Myan/4.final.Myan.2023/Figure5_location/location/sample.info.csv", header=T, sep=",")

#########  genetic distance (1-IBD proportion)
> dim(prop.dist)
[1] 1726 1726
> prop.dist[1:5,1:5]
            METF.HRP.1 METF.HRP.11 METF.HRP.13 METF.HRP.14 METF.HRP.15
METF.HRP.1       0.000       0.975       1.000       1.000       0.913
METF.HRP.11      0.975       0.000       0.982       0.969       0.940
METF.HRP.13      1.000       0.982       0.000       0.988       0.960
METF.HRP.14      1.000       0.969       0.988       0.000       0.989
METF.HRP.15      0.913       0.940       0.960       0.989       0.000

dist_matrix <- prop.dist
write.csv(dist_matrix, "dist_matrix.csv")

#########  geographic distance (km) 
> dim(dis.dist)
[1] 1726 1726
> dis.dist[1:5,1:5]
            METF.HRP.1 METF.HRP.11 METF.HRP.13 METF.HRP.14 METF.HRP.15
METF.HRP.1        0.00        7.63       27.29       19.02       55.54
METF.HRP.11       7.63        0.00       23.13       25.52       51.06
METF.HRP.13      27.29       23.13        0.00       46.03       28.26
METF.HRP.14      19.02       25.52       46.03        0.00       74.17
METF.HRP.15      55.54       51.06       28.26       74.17        0.00

geo_dist <- dis.dist

#########  temporal distance (days)
> dim(dis.temporal)
[1] 1726 1726
> dis.temporal[1:5,1:5]
            METF.HRP.1 METF.HRP.11 METF.HRP.13 METF.HRP.14 METF.HRP.15
METF.HRP.1           0         491        1126         422          33
METF.HRP.11        491           0         635          69         458
METF.HRP.13       1126         635           0         704        1093
METF.HRP.14        422          69         704           0         389
METF.HRP.15         33         458        1093         389           0

names.remove <- c("MP1056", "MP1060", "MP1061", "MP1062", "MP1063", "MP0030", "MP0035", "MP2888m")
dist_matrix <- dist_matrix[-which(row.names(dist_matrix) %in% names.remove), -which(colnames(dist_matrix) %in% names.remove)]
geo_dist <- geo_dist[-which(row.names(geo_dist) %in% names.remove), -which(colnames(geo_dist) %in% names.remove)]
dis.temporal <- dis.temporal[-which(row.names(dis.temporal) %in% names.remove), -which(colnames(dis.temporal) %in% names.remove)]

> dim(dist_matrix)
[1] 1718 1718
> dim(geo_dist)
[1] 1718 1718
> dim(dis.temporal)
[1] 1718 1718


#################################################################################################################
############################ Mantel test ########################################################################
#################################################################################################################

# geographic distance (km) and genetic distance (1-IBD proportion)
# use vegan R package
dis.prop.dist <- vegan::mantel(dis.dist, prop.dist, method = "spearman", permutations = 999, na.rm = TRUE)
dis.prop.dist

Mantel statistic based on Spearman''s rank correlation rho 

Call:
mantel(xdis = dis.dist, ydis = prop.dist, method = "spearman", permutations = 999, na.rm = TRUE) 

Mantel statistic r: 0.1309 
      Significance: 1e-04 

Upper quantiles of permutations (null model):
    90%     95%   97.5%     99% 
0.00988 0.01261 0.01495 0.01759 
Permutation: free
Number of permutations: 999

# temporal distance (days) and genetic distance (1-IBD proportion)
# use vegan R package
dis.prop.temporal <- mantel(dis.temporal, prop.dist, method = "spearman", permutations = 999, na.rm = TRUE)
dis.prop.temporal

Mantel statistic based on Spearman''s rank correlation rho 

Call:
mantel(xdis = dis.temporal, ydis = prop.dist, method = "spearman", permutations = 999, na.rm = TRUE) 

Mantel statistic r: 0.05206 
      Significance: 1e-04 

Upper quantiles of permutations (null model):
    90%     95%   97.5%     99% 
0.00966 0.01237 0.01474 0.01762 
Permutation: free
Number of permutations: 999

#################################################################################################################
######################## Mantel correlogram  ####################################################################
#################################################################################################################

library(ecodist)

#######################################################
corr_dis_geo <- mgram(as.dist(dist_matrix), as.dist(geo_dist), breaks = c(4.46,8,10,12.5,15,17.5,20,22.5,25,27.5,30,35,40,45,50,60,70,80,90,100,125,150,175,200,300,400), equiprobable = FALSE, nperm = 999, mrank = TRUE, nboot = 500, pboot = 0.6, cboot = 0.95, alternative = "two.sided", trace = FALSE) 
plot(corr_dis_geo)

> corr_dis_geo_test_2$mgram
         lag ngroup       mantelr        pval         llim         ulim
 [1,]   6.23  66903  7.614985e-02 0.001001001  0.068218406  0.084681522
 [2,]   9.00  43907  4.381640e-02 0.001001001  0.037039799  0.050627906
 [3,]  11.25  65455  3.341880e-02 0.001001001  0.026224379  0.040464775
 [4,]  13.75  74088  1.809713e-02 0.001001001  0.010106918  0.026199804
 [5,]  16.25  83305  2.528294e-02 0.001001001  0.019044221  0.031833089
 [6,]  18.75  80054  1.735009e-02 0.001001001  0.010989174  0.023877736
 [7,]  21.25  87995  2.034096e-03 0.415415415 -0.004449129  0.009520745
 [8,]  23.75  88718 -1.264406e-02 0.001001001 -0.019016134 -0.006102119
 [9,]  26.25  81867 -1.477149e-03 0.489489489 -0.007547646  0.004452199
[10,]  28.75  74256 -2.215633e-02 0.001001001 -0.028452511 -0.016212817
[11,]  32.50 143846 -3.392487e-02 0.001001001 -0.041286944 -0.026882590
[12,]  37.50 117999 -3.572459e-02 0.001001001 -0.042067033 -0.028013672
[13,]  42.50  89226 -2.032192e-02 0.001001001 -0.027172208 -0.013732053
[14,]  47.50  65611 -3.573356e-02 0.001001001 -0.042438393 -0.028213619
[15,]  55.00  92949 -3.894532e-02 0.001001001 -0.046982347 -0.030957820
[16,]  65.00  56399 -2.793401e-02 0.001001001 -0.036130417 -0.018838993
[17,]  75.00  28143 -1.683656e-02 0.001001001 -0.025623446 -0.007763649
[18,]  85.00  18307 -1.035636e-02 0.008008008 -0.018533087 -0.001755899
[19,]  95.00  12586 -2.214790e-03 0.610610611 -0.009314088  0.004737189
[20,] 112.50  13857 -8.545617e-03 0.126126126 -0.016404840 -0.001057475
[21,] 137.50   7459 -5.219503e-03 0.384384384 -0.013262585  0.003796398
[22,] 162.50   7169  5.410638e-03 0.411411411 -0.002124701  0.012952722
[23,] 187.50   4326  3.186828e-05 0.995995996 -0.007662739  0.007146889
[24,] 250.00  21983 -6.447951e-03 0.555555556 -0.025829022  0.014728100
[25,] 350.00    839  2.828467e-03 0.361361361 -0.004249557  0.008571566


#######################################################
corr_dis_time <- mgram(as.dist(dist_matrix), as.dist(dis.temporal), nclass = 30, equiprobable = FALSE, nperm = 999, mrank = TRUE, nboot = 500, pboot = 0.6, cboot = 0.95, alternative = "two.sided", trace = FALSE) 
> corr_dis_time
$mgram
             lag ngroup       mantelr        pval          llim          ulim
 [1,]   28.43333 189745  0.0436017829 0.001001001  3.457509e-02  0.0521291922
 [2,]   85.30000 118503  0.0096784748 0.011011011  2.217745e-03  0.0178669326
 [3,]  142.16667 140134  0.0092675926 0.003003003  3.709793e-03  0.0152943693
 [4,]  199.03333 155066  0.0010322105 0.736736737 -5.483864e-03  0.0080204564
 [5,]  255.90000  91889 -0.0037413932 0.196196196 -9.539068e-03  0.0014704589
 [6,]  312.76667  93967  0.0008447617 0.749749750 -5.136405e-03  0.0064357685
 [7,]  369.63333 122157 -0.0094707981 0.002002002 -1.556544e-02 -0.0027006062
 [8,]  426.50000  64966 -0.0054041163 0.031031031 -1.081226e-02  0.0008748809
 [9,]  483.36667  69025 -0.0084607027 0.002002002 -1.458241e-02 -0.0027752183
[10,]  540.23333  92501 -0.0132756699 0.001001001 -1.942768e-02 -0.0072567870
[11,]  597.10000  56731  0.0007313437 0.788788789 -5.257750e-03  0.0059636513
[12,]  653.96667  39621  0.0004831918 0.861861862 -4.948584e-03  0.0057234911
[13,]  710.83333  55299 -0.0069212202 0.014014014 -1.297609e-02 -0.0007635953
[14,]  767.70000  31465 -0.0025243600 0.328328328 -8.399499e-03  0.0035070478
[15,]  824.56667  21775 -0.0010362959 0.696696697 -7.689333e-03  0.0049007956
[16,]  881.43333  35269 -0.0042081171 0.181181181 -1.105048e-02  0.0036842688
[17,]  938.30000  26641 -0.0091994260 0.002002002 -1.632078e-02 -0.0020121511
[18,]  995.16667  11221 -0.0073253952 0.003003003 -1.322821e-02 -0.0017819650
[19,] 1052.03333  11792 -0.0072771758 0.008008008 -1.323769e-02 -0.0010913598
[20,] 1108.90000  14964 -0.0207726750 0.001001001 -2.806793e-02 -0.0133864632
[21,] 1165.76667   4603 -0.0086705017 0.001001001 -1.509089e-02 -0.0030386961
[22,] 1222.63333   5608 -0.0183875376 0.001001001 -2.445463e-02 -0.0123372662
[23,] 1279.50000   4837 -0.0045226520 0.066066066 -1.136729e-02  0.0025719192
[24,] 1336.36667   2090 -0.0000758970 0.972972973 -6.672577e-03  0.0061179226
[25,] 1393.23333   2957 -0.0125335539 0.001001001 -1.901096e-02 -0.0045725749
[26,] 1450.10000   5695 -0.0287219370 0.001001001 -3.716569e-02 -0.0191769679
[27,] 1506.96667   1798 -0.0095487355 0.001001001 -1.614479e-02 -0.0030783144
[28,] 1563.83333    803 -0.0026781617 0.211211211 -7.814919e-03  0.0031675844
[29,] 1620.70000    394  0.0008613823 0.635635636 -5.735259e-03  0.0065991389
[30,] 1677.56667     98  0.0095690218 0.001001001 -1.083763e-13  0.0139150477


#######################################################
# plot results
library(ggplot2)
library(ggpubr)
  
p.corr_dis_geo <- ggplot(data = corr_dis_geo$mgram, aes(x = lag, y = mantelr)) +
  geom_hline(yintercept=0, linetype="dashed", color = "black", size=0.5) +
  geom_ribbon(data = corr_dis_geo_NULL$mgram, aes(x = lag, ymin = llim, ymax = ulim), fill = "grey", alpha = 0.5)+
  geom_line() +
  geom_errorbar(aes(ymin = llim, ymax = ulim), width = 3) +
  geom_point(color = "black", fill = "#E69F00", size = 3, shape = 21)+ 
  ylim(-0.075,0.125) + xlim(0,200) + theme_bw() +
  labs(x="Distance class (km)",  y = "Autocorrelation coefficient")+ 
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))
p.corr_dis_geo
   

p.corr_dis_time <- ggplot(data = corr_dis_time$mgram, aes(x = lag, y = mantelr)) +
  geom_hline(yintercept=0, linetype="dashed", color = "black", size=0.5) +
  geom_ribbon(data = corr_dis_time_NULL$mgram, aes(x = lag, ymin = llim, ymax = ulim), fill = "grey", alpha = 0.5)+
  geom_line() +
  geom_errorbar(aes(ymin = llim, ymax = ulim), width = 15) +
  geom_point(color = "black", fill = "#E69F00", size = 3, shape = 21)+ 
  ylim(-0.05,0.1) + xlim(0,1000) + theme_bw() +
  labs(x="Distance class (days)",  y = "Autocorrelation coefficient")+ 
  theme(axis.text=element_text(size=14),axis.title=element_text(size=14))
p.corr_dis_time


pdf('Figure.mental.correlogram.pdf', width=8, height=8)
ggarrange(
p.corr_dis_geo, p.corr_dis_time,
          ncol = 1, nrow = 2)
dev.off()
