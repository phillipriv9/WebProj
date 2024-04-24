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


graph1 <- ggplot(df3, aes(x = N_perc, y = OC_perc)) +
  facet_grid(.~Habitat) +
  geom_point(aes(color = centerdepth)) +
  geom_smooth(method = lm) +
  labs(y = "Percent of Organic Carbon", x = "Percent of Nitrogen", ) +
  theme_bw() +
  scale_color_gradient(low = 	"#B057BF", high = "#1A1A1A", space = "Lab")


Hab_labs <- c("mangrove", "marsh")
names(Hab_labs) <- c("Mangrove", "Marsh")


graph1 <- graph1 + facet_grid(. ~Habitat, labeller = labeller(Habitat = c("mangrove" = "Mangrove", "marsh" ="Marsh")))

graph1

