# To assess potential pfhrp2-3 deletions, read coverage and mapping patterns were visually inspected using the Integrative Genomics Viewer (IGV) for all samples carrying the kelch13 R561H mutation.

# Correlation between parasitemia and hrp2 deletion

# 1. Read data
df <- read.csv("HRP2.parasitemia_10.20.25.csv")

# 2. Make hrp2.deletion a factor with correct order
df$hrp2.deletion <- factor(df$hrp2.deletion, levels = c("full", "del"))

# 3. Plot: boxplot + jittered points + significance
p <- ggplot(df, aes(x = hrp2.deletion, y = Parsitemia_per.500.WBC, fill = hrp2.deletion)) +
  geom_boxplot(width = 0.5, alpha = 0.6, outlier.shape = NA) +
  geom_jitter(shape = 21,         # <-- dot with border + fill
              width = 0.12,
              size = 3.5,         # dot size
              fill = "grey",     # fill color (change here)
              color = "black",    # border color (change here)
              stroke = 1.0,       # border thickness
              alpha = 0.75) +
  labs(x = "HRP2 Deletion Status", y = "Parasitemia per 500 WBC") +
  theme_classic(base_size = 14) + ylim(0,4000)+
  theme(legend.position = "none")

print(p)

t_result <- t.test(Parsitemia_per.500.WBC ~ hrp2.deletion, data = df,
  var.equal = FALSE   # FALSE = Welch test (recommended)
  )

# Print results
print(t_result)
> print(t_result)

        Welch Two Sample t-test

data:  Parsitemia_per.500.WBC by hrp2.deletion
t = 2.6322, df = 9.4605, p-value = 0.02619
alternative hypothesis: true difference in means between group full and group del is not equal to 0
95 percent confidence interval:
  128.759 1623.968
sample estimates:
mean in group full  mean in group del 
          2132.000           1255.636 


######
p.DOF <- ggplot(df, aes(x = hrp2.deletion, y = DOF_Days_of_Fever, fill = hrp2.deletion)) +
  geom_boxplot(width = 0.5, alpha = 0.6, outlier.shape = NA) +
  geom_jitter(shape = 21,         # <-- dot with border + fill
              width = 0.12,
              size = 3.5,         # dot size
              fill = "grey",     # fill color (change here)
              color = "black",    # border color (change here)
              stroke = 1.0,       # border thickness
              alpha = 0.75) +
  labs(x = "HRP2 Deletion Status", y = "Days of Fever") +
  theme_classic(base_size = 14) + # ylim(0,4000)+
  theme(legend.position = "none")

print(p.DOF)

t_result <- t.test(DOF_Days_of_Fever ~ hrp2.deletion, data = df,
  var.equal = FALSE   # FALSE = Welch test (recommended)
  )

# Print results
print(t_result)

        Welch Two Sample t-test

data:  DOF_Days_of_Fever by hrp2.deletion
t = -4.3116, df = 43.372, p-value = 9.178e-05
alternative hypothesis: true difference in means between group full and group del is not equal to 0
95 percent confidence interval:
 -4.519620 -1.639471
sample estimates:
mean in group full  mean in group del 
          1.625000           4.704545 

library(gridExtra)

grid.arrange(p, p.DOF, ncol = 2)
