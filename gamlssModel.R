library(tidyverse)
library(xlsx) # For importing the xlsx file to R
library(glmmTMB) # For fitting the GLMM model
library(gamlss) # For fitting the GAMLSS model
library(emmeans) # For post-hoc comparisons

# Figure 5
# Fit GAMLSS model with gamlss package
finalModel <- gamlss(Typha ~ factor(trmt) + waterDepth + factor(year),
                     sigma.formula = ~ factor(trmt),
                     nu.formula = ~ 1,
                     family = BEINF0(mu.link = "logit",
                                     sigma.link = "logit",
                                     nu.link = "log"),
                     data = dat,
                     trace = FALSE) # turns off console printing

# Residual plot for GAMLSS model
plot(finalModel,
     summaries = FALSE,
     parameter = par(mfrow = c(2, 2), mar = par("mar") + c(0, 1, 0, 0),
                     col.axis = "blue4", col = "blue4", col.main = "blue4",
                     col.lab = "blue4", pch = "+", cex = .45,
                     cex.lab = 1.2, cex.axis = 1, cex.main = 1.2))

# Post-hoc comparisons
results <- emmeans(finalModel, c("trmt"),
                   by = c("year"), type = "response", comparison = TRUE)
# Visual plot of post-hoc comparison
plot(results, comparison = TRUE)

summary(finalModel)
