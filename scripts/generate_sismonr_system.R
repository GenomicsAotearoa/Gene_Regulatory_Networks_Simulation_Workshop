here::i_am("scripts/generate_sismonr_system.R")

library(here)
library(sismonr)
library(tidyverse)

## ----------------------------- ##
## Creating the in silico system ##
## ----------------------------- ##

## Gene ID - name correspondence
genes_name2id = tibble("ID" = as.character(1:7),
                       "name" = c("MYB", ## 1
                                  "bHLH1", ## 2
                                  "WDR", ## 3
                                  "bHLH2", ## 4
                                  "MYBrep", ## 5
                                  "R3-MYB", ## 6
                                  "DFR")) ## 7

## Complex ID - name correspondence
complexes_name2id = tibble("ID" = paste0("CTC", 1:10),
                           "name" = c("bHLH1dimer", ## CTC1
                                      "MYBdimer", ## CTC2
                                      "WDR-bHLH1dimer", ## CTC3
                                      "MBW1", ## CTC4
                                      "bHLH2dimer", ## CTC5
                                      "WDR-bHLH2dimer", ## CTC6
                                      "MBW2", ## CTC7
                                      "MBWr", ## CTC8
                                      "R3-bHLH1dimer", ## CTC9
                                      "R3-bHLH2dimer")) ## CTC10


id2names = c(genes_name2id$name, complexes_name2id$name)
names(id2names) = c(genes_name2id$ID, complexes_name2id$ID)


## ----------------------------- ##
## Creating the in silico system ##
## ----------------------------- ##

## We create a system with 7 genes, and no regulatory
## interactions (they will be added manually)
colsystem = createInSilicoSystem(empty = T,
                                 G = 7,
                                 PC.p = 1,
                                 ## all genes are regulators of transcription:
                                 PC.TC.p = 1, 
                                 PC.TL.p = 0,
                                 PC.RD.p = 0,
                                 PC.PD.p = 0,
                                 PC.PTM.p = 0,
                                 PC.MR.p = 0,
                                 ploidy = 2)

## Changing the kinetic parameters of the genes
colsystem$genes$TCrate = c(5, 0.1, 0.5, 0.01, 0.01, 0.1, 0.5)
colsystem$genes$TLrate = c(0.1, 0.01, 0.01, 0.01, 0.01, 0.01, 0.001)
colsystem$genes$RDrate = c(0.1, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01)
colsystem$genes$PDrate = c(0.01, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001)

## Adding regulatory complexes in the system
compo = list(list("compo" = c(2, 2),
                  "formationrate" = 2.5, "dissociationrate" = 0.1),
             list("compo" = c(1, 1),
                  "formationrate" = 2.5, "dissociationrate" = 0.1),
             list("compo" = c("CTC1", 3),
                  "formationrate" = 1, "dissociationrate" = 0.1),
             list("compo" = c("CTC2", "CTC3"),
                  "formationrate" = 1, "dissociationrate" = 0.1),
             list("compo" = c(4, 4),
                  "formationrate" = 2.5, "dissociationrate" = 0.1),
             list("compo" = c("CTC5", 3),
                  "formationrate" = 2, "dissociationrate" = 0.1),
             list("compo" = c("CTC6", "CTC2"),
                  "formationrate" = 2, "dissociationrate" = 0.1),
             list("compo" = c("CTC7", 5),
                  "formationrate" = 2.5, "dissociationrate" = 0.1),
             list("compo" = c("CTC1", 6),
                  "formationrate" = 1.5, "dissociationrate" = 0.1),
             list("compo" = c("CTC5", 6),
                  "formationrate" = 1.5, "dissociationrate" = 0.1))

for(comp in compo){
  colsystem = addComplex(colsystem,
                         comp$compo,
                         formationrate = comp$formationrate,
                         dissociationrate = comp$dissociationrate)
}

## Adding  regulatory interactions in the system
interactions = list(list("edge" = c("CTC4", 4),
                         "regsign" = "1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2,
                                           "TCfoldchange" = 25)),
                    list("edge" = c("CTC7", 4),
                         "regsign" = "1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2,
                                           "TCfoldchange" = 25)),
                    list("edge" = c("CTC7", 5),
                         "regsign" = "1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2,
                                           "TCfoldchange" = 50)),
                    list("edge" = c("CTC7", 6),
                         "regsign" = "1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2,
                                           "TCfoldchange" = 50)),
                    list("edge" = c("CTC7", 7),
                         "regsign" = "1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2,
                                           "TCfoldchange" = 15)),
                    list("edge" = c("CTC8", 4),
                         "regsign" = "-1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2)),
                    list("edge" = c("CTC8", 5),
                         "regsign" = "-1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2)),
                    list("edge" = c("CTC8", 6),
                         "regsign" = "-1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2)),
                    list("edge" = c("CTC8", 7),
                         "regsign" = "-1",
                         "kinetics" = list("TCbindingrate" = 0.1,
                                           "TCunbindingrate" = 2)))

for(inter in interactions){
  colsystem = addEdge(colsystem,
                      inter$edge[1],
                      inter$edge[2],
                      regsign = inter$regsign,
                      kinetics = inter$kinetics)
}


## ---------------------------------- ##
## Creating the in silico individuals ##
## ---------------------------------- ##

## We are going to simulate three different individuals/plants
## One is a wild-type plant (no mutation in any of its genes).
## The second is a mutant, in which gene 5 (the MYBrep gene) 
## is overexpressed (here we increase its transcription rate by 50 + 
## the gene becomes insensitive to transcription factors).
## The third is a mutant in which gene 5 (the MYBrep gene) is 
## silenced (in the experiments the gene is silenced via RNA 
## silencing, which increases the decay of the RNAs of the gene,
## which is what we are reproducing here).

plants = createInSilicoPopulation(3,
                                  colsystem,
                                  initialNoise = F,
                                  ngenevariants = 1)


## We add the QTL effect coefficients for the second individual
## such that the transcription rate of gene 5 is increased +
## the gene becomes insensitive to transcription factors
## (qtlTCregbind set to 0.)
## We have to change it for both homologs of the gene (GCN1 and GCN2)
## as the plants are diploid.
plants$individualsList$Ind2$QTLeffects$GCN1$qtlTCrate[5] = 50
plants$individualsList$Ind2$QTLeffects$GCN2$qtlTCrate[5] = 50

plants$individualsList$Ind2$QTLeffects$GCN1$qtlTCregbind[5] = 0
plants$individualsList$Ind2$QTLeffects$GCN2$qtlTCregbind[5] = 0

## We add the QTL effect coefficient for the second individual
## such that the RNA decay rate of gene 5 is increased
plants$individualsList$Ind3$QTLeffects$GCN1$qtlRDrate[5] = 20
plants$individualsList$Ind3$QTLeffects$GCN2$qtlRDrate[5] = 20

## Changing the initial conditions:
## As specified in Albert et al., 2014, only genes 2 and 3
## (bHLH1 and WDR) are constitutively expressed.
for(g in names(plants$individualsList$Ind1$InitAbundance)){
  for(i in names(plants$individualsList)){
    plants$individualsList[[i]]$InitAbundance[[g]]$R =
      plants$individualsList[[i]]$InitAbundance[[g]]$R * 
      c(0, 1, 1, 0, 0, 0, 0)
    plants$individualsList[[i]]$InitAbundance[[g]]$P =
      plants$individualsList[[i]]$InitAbundance[[g]]$P * 
      c(0, 1, 1, 0, 0, 0, 0)
  }
}

plants_all = plants ## contains all 3 in silico plants

## Only the wild-type and overexpressed mutate
plants$individualsList = plants$individualsList[1:2]



## --------------------------------- ##
## Saving the system and individuals ##
## --------------------------------- ##

save(colsystem, plants, id2names, file = here("data/sismonr_anthocyanin_system.RData"))

## -------------------------------------------------------------------- ##
## Simulating the expression profiles of the genes for the three plants ##
## -------------------------------------------------------------------- ##

set.seed(123)
sim = simulateInSilicoSystem(colsystem,
                             plants, 
                             simtime = 1200,
                             ntrials = 1)
sim$runningtime / 60
sum(sim$runningtime)

plotSimulation(sim$Simulation, molecules = 1:7, mergeComplexes = TRUE)
