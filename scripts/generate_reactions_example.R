here::i_am("scripts/generate_reactions_example.R")

library(sismonr)
library(XRJulia)
library(stringr)

## Generate a system of 3 genes (all transcription factors)
set.seed(456)
mysystem = createInSilicoSystem(G = 3, empty = TRUE, ploidy = 1, PC.p = 1, PC.TC.p = 1)
mysystem = addEdge(mysystem, 1, 2, regsign = "1")
mysystem = addEdge(mysystem, 2, 3, regsign = "1")
mysystem = addEdge(mysystem, 3, 1, regsign = "-1")

## Generate the stochastic system with sismonr
stochsys = sismonr::createStochSystem(mysystem)

## Extract the list of reactions from the Julia object
reactions = unlist(juliaGet(juliaEval(paste0(stochsys@.Data, "[\"reactions\"]"))))

## Make the reactions more user friendly
reactions = str_remove_all(reactions, "GCN\\d")

for(i in reactions) cat(i, "\n")

## Extract the list of reaction propensities
propensities = unlist(juliaGet(juliaEval(paste0(stochsys@.Data, "[\"propensities\"]"))))

## Create an in silico individual to compute the propensities for
mypop = createInSilicoPopulation(1, mysystem, ngenevariants = 1)
QTLeffects = mypop$individualsList$Ind1$QTLeffects

## Compute the values of the propensities
propensities = str_replace_all(propensities, "\\[", "\\[\\[")
propensities = str_replace_all(propensities, "\\]", "\\]\\]")
propensities = sapply(propensities, function(i){eval(str2expression(i))})
propensities = format(propensities, digits = 3)

text = paste0(reactions, " (", propensities, ")")
for(i in text) cat(i, "\n")

## Generate the same system but diploid
set.seed(456)
mysystem2 = createInSilicoSystem(G = 3, empty = TRUE, ploidy = 2, PC.p = 1, PC.TC.p = 1)
mysystem2 = addEdge(mysystem2, 1, 2, regsign = "1")
mysystem2 = addEdge(mysystem2, 2, 3, regsign = "1")
mysystem2 = addEdge(mysystem2, 3, 1, regsign = "-1")

## Generate the stochastic system with sismonr
stochsys2 = sismonr::createStochSystem(mysystem2)

## Extract the list of reactions from the Julia object
reactions = unlist(juliaGet(juliaEval(paste0(stochsys2@.Data, "[\"reactions\"]"))))

for(i in reactions) cat(i, "\n")

