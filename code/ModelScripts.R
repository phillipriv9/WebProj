library(dplyr)
library(tidyverse)
library(lme4)
library(ggplot2)


AllCombined <- read_csv("data/combined/AllCombined.csv")

AllCombined$Latitude <- as.numeric(AllCombined$Latitude)

df1 <- AllCombined

df2 <- df1[! (is.infinite(df1$CN) | is.na(df1$CN)), ]


df3 <- df2 %>%
  filter(Habitat %in% c("marsh", "mangrove"), CN > 5, CN < 100)

df3 <- df3[!is.na(df3$centerdepth), ]
df3 <- df3[!is.na(df3$U_depth_m), ]
df3 <- df3[!is.na(df3$L_depth_m), ]
#Could try pivot longer to help automate that process

#plot nested within source
# variability derives from different experimenters sampling different sites.
model <- lmer(N_perc ~  OC_perc*Habitat + centerdepth + (1 | study_id/core_id), data = df3, REML = FALSE)

#This null model is looking at the interaction of Oxygen concentration percent with Habitat type.
model.interaction.null <- lmer(N_perc ~ OC_perc+Habitat + centerdepth + (1 | study_id/core_id), data = df3, REML = FALSE)

#Null model looking at center depth
model.centerdepth.null <- lmer(N_perc ~ OC_perc*Habitat + (1 | study_id/core_id), data=df3, REML = FALSE)

model.centerdepth.null
model
model.interaction.null
#Perfoming likelhood tests

#Interaction
anova(model.interaction.null, model)

anova(model.centerdepth.null, model)



### Making a graph of this first model.







