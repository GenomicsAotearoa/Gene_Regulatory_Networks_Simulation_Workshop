here::i_am("scripts/post_processing.R")

library(sismonr)
library(here)
library(dplyr)
library(tidyr)
library(purrr)
library(tibble)
library(ggplot2)
library(stringr) 

## Importing each simulation
sim_files <- list.files(here("data/backup_250_simulations/"))
n_sim <- length(sim_files)

sim_df <- lapply(1:n_sim, function(i){
  load(paste0(here::here("data/backup_250_simulations/"), sim_files[i]))
  
  mergeAlleleAbundance(sim$Simulation) %>% 
    mutate(trial = trial + 2*(i - 1))
}) %>% 
  reduce(bind_rows) %>% 
    as_tibble() 

## Loading the sismonr dataset to get colours and names
load(here("data/sismonr_anthocyanin_system.RData"))

plotSimulation(sim_df,
               molecules = names(colours),
               mergeComplexes = FALSE,
               labels = id2names[names(colours)],
               colours = colours)
ggsave(here("workshop_material/images/colsystem_simulations_500trials.png"), width = 12, height = 8)

## Comparing the distribution of DFR expression for the two plants
sim_df %>% 
  filter(time == 1200) %>% 
  select(trial, Ind, "P7") %>% 
  mutate(Ind = factor(Ind, 
                      levels = c("Ind1", "Ind2"), 
                      labels = c("Wild-type", "MYBrep overexpressed"))) %>% 
  ggplot(aes(x = P7, fill = Ind)) + #
  geom_histogram(alpha = 0.5, colour = "gray20", bins = 50) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  labs(x = "DFR protein abundance",
       y = "Count (simulations)",
       fill = "Plant",
       title = "DFR expression is reduced in mutant plants",
       subtitle = "Results from 500 simulations") +
  theme_bw() +
  theme(legend.position = "bottom",
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))
ggsave(here("workshop_material/images/colsystem_simulations_fdr_histogram.png"), width = 6, height = 4)


##################################
## To go further: one more plot ##
##################################

sim_df2 <- lapply(1:n_sim, function(i){
  load(paste0(here::here("data/backup_250_simulations/"), sim_files[i]))
  
  mergeComplexesAbundance(sim$Simulation) %>% 
  mergeAlleleAbundance() %>% 
    as_tibble() %>% 
    mutate(trial = trial + 2*(i - 1))
}) %>% 
  reduce(bind_rows)

sim_df2 %>% 
  filter(time == 1200) %>% 
  pivot_longer(cols = starts_with("P"),
               names_to = "Molecule",
               values_to = "Abundance") %>% 
  mutate(Molecule_name = id2names[str_remove(Molecule, "^P")],
         Molecule_name = factor(Molecule_name, levels = id2names),
         Ind = factor(Ind, 
                      levels = c("Ind1", "Ind2"), 
                      labels = c("Wild-type", "MYBrep overexpressed"))) %>% 
  ggplot(aes(x = Ind, y = Abundance, fill = Ind)) +
  geom_boxplot(alpha = 0.5, colour = "black") +
  scale_y_log10() +
  scale_fill_brewer(palette = "Set1", direction = -1, guide = "none") +
  facet_wrap(~Molecule_name, scales = "free") +
  labs(title = "MYB expression is reduced in the mutant plant?!",
       subtitle = "Results over 500 simulations",
       x = NULL,
       y = "Protein abundance") +
  theme_bw() +
  theme(legend.position = "bottom",
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

