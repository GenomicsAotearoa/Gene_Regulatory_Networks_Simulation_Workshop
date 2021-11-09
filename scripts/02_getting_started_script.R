library(sismonr)

set.seed(12) # important for reproducibility of "random" results in R!
small_grn <- createInSilicoSystem(G = 10, 
                                  PC.p = 1, # proportion of genes that are protein-coding
                                  ploidy = 2) # ploidy of the system

plotGRN(small_grn)

## To save the HTML plot
# visNetwork::visSave(plotGRN(small_grn, width = "800px"),
#                     "_includes/sismonr_network.html")

getGenes(small_grn)
getEdges(small_grn)

?insilicosystemargs

set.seed(45)
another_grn <- createInSilicoSystem(G = 5, 
                                    PC.p = 1, 
                                    PC.TC.p = 1)

small_grn2 <- addGene(small_grn, 
                      coding = "PC", 
                      TCrate = 0.01,
                      RDrate = 0.005)

small_grn3 <- addEdge(small_grn2, 11, 8, regsign = "1")

set.seed(23)
small_pop <- createInSilicoPopulation(3, ## number of individuals
                                      small_grn,
                                      ngenevariants = 2) ## how many alleles per gene

plotMutations(small_pop, small_grn, nGenesPerRow = 5)
