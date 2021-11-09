here::i_am("scripts/generate_reactions_example.R")

library(sismonr)
library(stringr)
library(dplyr)

## Generate a system of 3 genes (all transcription factors)
set.seed(456)
mysystem <- createInSilicoSystem(G = 3, empty = TRUE, ploidy = 1, PC.p = 1, PC.TC.p = 1)
mysystem <- addEdge(mysystem, 1, 2, regsign = "1")
mysystem <- addEdge(mysystem, 2, 3, regsign = "1")
mysystem <- addEdge(mysystem, 3, 1, regsign = "-1")

## Get the list of reactions from the system
reactions <- getReactions(mysystem)
str_remove_all(reactions$reaction, "GCN1")

## Generate 2 in silico individuals
set.seed(123)
mypop <- createInSilicoPopulation(2, ## number of individuals
                                  small_grn,
                                  ngenevariants = 2) ## how many alleles per gene

## Get the list of reactions and associated reaction rates 
reactions_rates <- getReactions(mysystem, mypop)
reactions_rates %>% 
  select(reaction, starts_with("rate")) %>% 
  mutate(reaction = str_remove_all(reaction, "GCN1"),
         across(starts_with("rate"), ~ signif(.x, digits = 3)))



## Generate the same system but diploid
set.seed(456)
mysystem2 <- createInSilicoSystem(G = 3, empty = TRUE, ploidy = 2, PC.p = 1, PC.TC.p = 1)
mysystem2 <- addEdge(mysystem2, 1, 2, regsign = "1")
mysystem2 <- addEdge(mysystem2, 2, 3, regsign = "1")
mysystem2 <- addEdge(mysystem2, 3, 1, regsign = "-1")

## Get the list of reactions from the system
reactions2 <- getReactions(mysystem2)
reactions2$reaction


