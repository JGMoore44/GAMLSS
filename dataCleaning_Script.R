#Authors: Juan Canovas, Jimmy Moore, Jassie Singh

library(tidyverse)
library(xlsx) # For importing the xlsx file to R
library(glmmTMB) # For fitting the GLMM model
library(gamlss) # For fitting the GAMLSS model
library(emmeans) # For post-hoc comparisons


# Import data
# Whole data set
dat <- read.xlsx(file = "C:/path/Stats_Project_Percent_Cover_Ohsowski.xlsx",
                 sheetIndex = 1, header = TRUE)
# Remove empty columns
dat <- dat %>%
  dplyr::select(1:12) # called like this because other packages mask "select()" function
# Convert year to a factor
dat <- dat %>%
  mutate(year, year = as.factor(year))
# Set the baseline of "trmt" to be "Control" group
dat <- dat %>%
  mutate(trmt = relevel(trmt, ref = "Control"))
# Convert percentages to range 0 to 1
dat <- dat %>%
  mutate(unVegCover = unVegCover/100) %>%
  mutate(vegCover = vegCover/100) %>%
  mutate(waterDepth = waterDepth/100) %>%
  mutate(Typha = Typha/100) %>%
  mutate(potber = potber/100) %>%
  mutate(utrmin = utrmin/100) %>%
  mutate(utrvul = utrvul/100)

# Beta regression and GLMM cannot handle exact zeros or exact ones.
# Transform them using (y * (n-1)) + 0.5 / n) where n is sample size
# Details: see Smithson and Verkuilen 2006
dat <- dat %>%
  mutate(TyphaNoZero = replace(Typha, Typha == 0, (0 * (nrow(dat) - 1) + 0.5)/nrow(dat)))

# Only selecting site Cedarville
dat_ced <- dat %>%
  filter(site == "Cedarville")
# Only selecting site Munuscong
dat_mun <- dat %>%
  filter(site == "Munuscong")