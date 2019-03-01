library(tidyverse)
library(xlsx) # For importing the xlsx file to R
library(glmmTMB) # For fitting the GLMM model
library(gamlss) # For fitting the GAMLSS model
library(emmeans) # For post-hoc comparisons

# Figure 2
ggplot(data = dat, aes(x = Typha)) +
  geom_histogram(color = "black", fill = "red") +
  theme_dark() +
  labs(title = "Distribution of Typha")
# Figure 3
ggplot(data = dat, aes(x = trmt, y = Typha)) +
  geom_boxplot(color = "black", fill = "red") +
  facet_grid(. ~ site) + theme_dark() +
  labs(title = "Typha vs. Treatment") +
  stat_summary(fun.y = mean, colour = "White",
               geom = "point", size = 3,
               show.legend = FALSE)