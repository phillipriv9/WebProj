library(dplyr)
library(tidyverse)
library(lme4)


AllCombined <- read_csv("data/combined/AllCombined.csv")

AllCombined$Latitude <- as.numeric(AllCombined$Latitude)

df1 <- AllCombined

df2 <- df1[! (is.infinite(df1$CN) | is.na(df1$CN)), ]


df3 <- df2 %>%
  filter(Habitat %in% c("marsh", "mangrove"), CN > 5, CN < 100)
