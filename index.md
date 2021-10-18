This advanced workshop is an introduction to the stochastic simulation of Gene Regulatory Networks (GRNs) using the R package `sismonr`. You will learn the basics of simulating GRNs, and how to scale up simulations on a HPC.

## Pre-workshop information

## Prerequisites

- Familiarity with bash and R
- Basic molecular biology knowledge preferred (gene expression and regulation)
- HPC knowledge preferred

## Learning goals

## Schedule

## Outline (draft)

1. [Introduction](./workshop_material/01_introduction.md)
2. The research question
    1. The topic (simulation of anthocyanin biosynthesis pathway)
    2. Setting on local machine
    3. The main steps of a scaling project
3. First steps on the HPC
    1. Loading modules (R and Julia)
    4. Running a test script
4. Scaling up your work
    1. Assessing time and memory usage
    2. profiling code
5. Parallel computing on NeSI
    1. Introduction to parallel computing
    2. How to execute parallel code on NeSI
6. Post-processing
    1. Analysing the output

## The research question

### Modelling the anthocyanin biosynthesis regulation pathway in eudicots

<img src="images/anthocyanin_model_animation.gif" alt="The sismonr stochastic system rules" width="700"/>

<small> Schema of the model of the anthocyanin biosynthesis regulation pathway. A static image of the model can be found [here](https://raw.githubusercontent.com/GenomicsAotearoa/Gene_Regulatory_Networks_Simulation_Workshop/main/images/anthocyanin_pathway_schema.png). </small>
