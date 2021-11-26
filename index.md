---
layout: homepage
---

This advanced workshop is an introduction to the stochastic simulation of Gene Regulatory Networks (GRNs) using the R package `sismonr`. You will learn the basics of simulating GRNs, and how to scale up simulations on a HPC.

## Prerequisites

- Familiarity with bash and R
- Basic molecular biology knowledge preferred (gene expression and regulation)
- HPC knowledge preferred

## Learning objectives

By the end of this workshop, participants should be able to:

- explain the concept of modelling and simulations, and how simulations can help answer research questions;
- briefly describe the main steps of gene expression, and explain what is a Gene Regulatory Network;
- list several classes of GRN models;
- generate a small random GRN with the sismonr package and simulate the expression of its gene;
- submit and manage jobs on a cluster using a scheduler and use software through environment modules;
- automate a large number of tasks on a HPC using array jobs.


## Some of the things we won't cover in this workshop

- how to construct a mathematical or statistical model for a specific biological system of interest;
- How to estimate model parameters based on experimental data;
- How to reconstruct a GRN from experimental data;
- Any questions we don't have an answer for :)

## Content

Before getting started, have a look at the [Supplementary data](./workshop_material/10_supplementary.md) for instructions on how to connect to NeSI Mahuika Jupyter.

1. [Introduction](./workshop_material/01_introduction.md)
2. [Getting started with sismonr](./workshop_material/02_getting_started_sismonr.md)
3. [Scaling up your work](./workshop_material/03_scaling_up.md)
4. [Working with job scheduler](./workshop_material/04_working_with_job_scheduler.md)
5. [Automating large number of tasks](./workshop_material/05_automating_large_number_of_tasks.md)
6. [Post-processing](./workshop_material/06_post_processing.md)
7. [Supplementary-material](./workshop_material/07_supplementary.md)

## Schedule


| Day      | Time           | Topic                                                          |
|----------|----------------|----------------------------------------------------------------|
| 1st day: | 10am-12:30pm   | 1. Introduction                                                |
|          | 12:30pm-1:30pm | *Lunch break*                                                  |
|          | 1:30pm-2:30pm  | 2. Getting started with sismonr                                |
|          | 2:30pm-4pm     | 3. Scaling up your work<br>4. Working with job scheduler       |
| 2nd day: | 10am-12pm      | 5. Automating large number of tasks                            |
|          | 12pm-1pm       | *Lunch break*                                                  |
|          | 1pm-3pm        | 5. Post-processing                                             |
|          | 3pm-4pm        | Question time                                                  |
