#################################################################################################################################
## This script ...
#################################################################################################################################
here::i_am("scripts/grn_modelling_examples.R")

library(deSolve)
library(here)
library(tidyverse)

theme_set(theme_bw())
theme_update(plot.title = element_text(hjust = 0.5))
theme_update(legend.position = "bottom")

## Continuous and deterministic model 

parameters <- c(k1s = 2, k2s = 2, k3s = 15,
                k1d = 1, k2d = 1, k3d = 1,
                k21 = 1, k31 = 1, k32 = 1, k13 = 100)

state <- c(X1 = 0, X2 = 0, X3 = 0)

grn_model <- function(t, state, parameters){
  with(as.list(c(state, parameters)), {
    
    dX1 <- k1s * 1 / (1 + k13 * X3) - k1d * X1
    dX2 <- k2s * (k21 * X1) / (1 + k21 * X1) - k2d * X2
    dX3 <- k3s * (k31 * X1 * k32 * X2) / ((1 + k31 * X1) * (1 + k32 * X2)) - k3d * X3
    
    list(c(dX1, dX2, dX3))
  })
}

times <- seq(0, 5, by = 0.01)

sim_ode <- ode(y = state, times = times, func = grn_model, parms = parameters, method = "rk4")

mol_names_ode <- c("X1" = "Gene 1",
                   "X2" = "Gene 2",
                   "X3" = "Gene 3")

as.data.frame(sim_ode) %>% 
  pivot_longer(cols = -time,
               names_to = "molecule",
               values_to = "concentration") %>% 
  mutate(molecule = mol_names_ode[molecule]) %>% 
  ggplot(aes(x = time, y = concentration, colour = molecule)) +
  geom_line() +
  scale_colour_brewer(palette = "Set1") +
  labs(x = "Time",
       y = "Concentration",
       colour = NULL)

ggsave(here::here("workshop_material/images/ode_model_example_simulation.png"), width = 6, height = 3.75)



## Discrete and stochastic model
library(GillespieSSA)

## DNA1 DNA2 DNA3 G1 G2 G3 DNA1_G3 DNA2_G1 G1_G2 DNA3_G1_G2

stochiometry_mat <- matrix(c(0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
                             0, 0, 0, -1, 0, 0, 0, 0, 0, 0,
                             -1, 0, 0, 0, 0, -1, 1, 0, 0, 0,
                             1, 0, 0, 0, 0, 1, -1, 0, 0, 0,
                             0, -1, 0, -1, 0, 0, 0, 1, 0, 0,
                             0, 1, 0, 1, 0, 0, 0, -1, 0, 0,
                             0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
                             0, 0, 0, 0, -1, 0, 0, 0, 0, 0,
                             0, 0, 0, -1, -1, 0, 0, 0, 1, 0,
                             0, 0, 0, 1, 1, 0, 0, 0, -1, 0,
                             0, 0, -1, 0, 0, 0, 0, 0, -1, 1,
                             0, 0, 1, 0, 0, 0, 0, 0, 1, -1,
                             0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
                             0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
                           nrow = 10,
                           ncol = 14, 
                           byrow = FALSE)
rownames(stochiometry_mat) <- c("DNA1", "DNA2", "DNA3", "G1", "G2", "G3", "DNA1_G3", "DNA2_G1", "G1_G2", "DNA3_G1_G2")

propensities <- c("TC1 * DNA1",
                  "RD1 * G1",
                  "A13 * DNA1 * G3",
                  "D13 * DNA1_G3",
                  "A21 * DNA2 * G1",
                  "D21 * DNA2_G1",
                  "TC2 * DNA2_G1",
                  "RD2 * G2",
                  "C12 * G1 * G2",
                  "DC12 * G1_G2",
                  "A312 * DNA3 * G1_G2",
                  "D312 * DNA3_G1_G2",
                  "TC3 * DNA3_G1_G2",
                  "RD3 * G3")

x0 <- c("DNA1" = 1, 
        "DNA2" = 1,
        "DNA3" = 1,
        "G1" = 0, 
        "G2" = 0, 
        "G3" = 0, 
        "DNA1_G3" = 0, 
        "DNA2_G1" = 0,
        "G1_G2" = 0, 
        "DNA3_G1_G2" = 0)

parms <- c("TC1" = 2,
           "RD1" = 0.2,
           "A13" = 0.1,
           "D13" = 0.01,
           "A21" = 0.01,
           "D21" = 0.01,
           "TC2" = 2,
           "RD2" = 0.2,
           "C12" = 0.01,
           "DC12" = 0.01,
           "A312" = 0.01,
           "D312" = 0.01,
           "TC3" = 7,
           "RD3" = 0.2)


set.seed(1)
sim_ssa <- ssa(x0 = x0,
               a = propensities,
               nu = stochiometry_mat,
               parms = parms,
               tf = 60,
               method = ssa.d(),
               simName = "ssa_model",
               verbose = FALSE,
               consoleInterval = 1)

mol_names_ssa <- c("G1" = "Gene 1", "G2" = "Gene 2", "G3" = "Gene 3")

as_tibble(sim_ssa$data) %>% 
  distinct() %>% ## to remove duplicated last t
  pivot_longer(cols = -t,
               names_to = "molecule",
               values_to = "abundance") %>% 
  mutate(contains_gene = case_when(str_detect(molecule, "G1") ~ "G1",
                                   str_detect(molecule, "G2") ~ "G2",
                                   str_detect(molecule, "G3") ~ "G3",
                                   TRUE ~ "none")) %>%
  group_by(t, contains_gene) %>%
  summarise(abundance = sum(abundance)) %>%
  filter(contains_gene != "none") %>%
  mutate(contains_gene = mol_names_ssa[contains_gene]) %>% 
  ggplot(aes(x = t, y = abundance, colour = contains_gene)) +
  geom_line() +
  scale_colour_brewer(palette = "Set1") +
  labs(x = "Time",
       y = "Abundance",
       colour = NULL)

ggsave(here::here("workshop_material/images/ssa_model_example_simulation.png"), width = 6, height = 3.75)

