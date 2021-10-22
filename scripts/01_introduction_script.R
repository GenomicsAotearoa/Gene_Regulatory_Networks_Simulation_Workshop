library(sismonr)

set.seed(12) # important for reproducibility of "random" results in R!
small_grn <- createInSilicoSystem(G = 10, 
                                  PC.p = 1, # proportion of genes that are protein-coding
                                  ploidy = 2) # ploidy of the system

plotGRN(small_grn)

visNetwork::visSave(plotGRN(small_grn, width = "800px"),
                    "_includes/sismonr_network.html")

getGenes(small_grn)

?insilicosystemargs

small_grn2 <- addEdge(small_grn2, 11, 10, regsign = "-1")

set.seed(23)
small_pop <- createInSilicoPopulation(2, ## number of individuals
                                      small_grn,
                                      ngenevariants = 2) ## how many alleles per gene

plotMutations(small_pop, small_grn, nGenesPerRow = 5)
