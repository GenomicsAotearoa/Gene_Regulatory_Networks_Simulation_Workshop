library(tidyverse)
library(gganimate)
library(gifski)

sim_df <- readRDS("C:/Users/hrpoab/Downloads/sim_df.rds")
load("C:/Users/hrpoab/Downloads/sismonr_anthocyanin_system.RData")


p <- sim_df |> 
  ## Get the data in a long format
  pivot_longer(c(-time, -trial, -Ind),
               names_to = "id",
               values_to = "abundance") |> 
  ## Extract type of the molecule:
  ## RNAs start with R, proteins with P,
  ## and regulatory complexes with C
  mutate(type = str_extract(id, "^\\w")) |> 
  ## Getting rid of the RNAs
  filter(type != "R") |> 
  ## Removing the P prefix from protein IDs
  mutate(id = str_remove(id, "P")) |> 
  filter(id %in% names(colours)) |> 
  mutate(label = id2names[id],
         Ind = factor(Ind, levels = c("Ind1", "Ind2"), labels = c("Wild type", "Mutant"))) |> 
  ggplot(aes(x = Ind, y = abundance, fill = id)) + 
  geom_boxplot() + 
  facet_wrap(~label, scales = "free_y") + 
  scale_fill_manual(values = colours, guide = "none") +
  theme_bw() + 
  labs(x = "Plant", 
       y = "Free protein / regulatory complex abundance")
  
p +
  transition_time(time) +
  labs(title = "Time: {frame_time} s")
