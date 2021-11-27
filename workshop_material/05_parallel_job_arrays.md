# 5. Parallel Job Arrays

<p style="text-align:left;">
    <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/04_working_with_job_scheduler.html">&lt;  4. Working with job scheduler</a></b>
    <span style="float:right;">
     <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/06_post_processing.html">6. Post-processing &gt;</a></b>
    </span>
</p>

## Outline
* Do not remove this line (it will not be displayed)
{:toc}

## Introduction to parallel computing

Many scientific software applications are written to take advantage of multiple CPUs in some way. But often this must be specifically requested by the user at the time they run the program, rather than happening automatically.

The scheduler provides the simplest method for running parallel computations. SLURM schedules thousands of simultaneous calculations on NeSI clusters  and will gladly execute many of your jobs at once, as long as there are available resources.

This means, that in contrast to the language-specific parallelism methods required by shared memory ( OpenMP, etc. 😕), distributed memory (MPI,etc. 😕😕), and various threading  methods built into languages like Python, Matlab, and R, slurm can provide [embarassingly parallel](https://en.wikipedia.org/wiki/Embarrassingly_parallel) calculations. These calculations, more generously called “perfectly parallel” do not require any exchange of information between individual jobs which would otherwise require a high-speed network and intelligent algorithm for communicating these data. (🤔) They scale perfectly which means that twice as much calculation can be completed in the same amount of time with twice as much hardware. This is not always *true** for true or imperfect parallel calculations

>Shared memory, Distributed memory, OpenMP, MPI ? ....none of these terms are associated with Gene Regulation 😠 
>>Correct. However, these concepts/specifications in Parallel computing is important for the *scaling up* part of the workshop. 
---


## How to execute parallel code on NeSI

---

<p style="text-align:left;">
    <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/04_working_with_job_scheduler.html">&lt;  4. Working with job scheduler</a></b>
    <span style="float:right;">
     <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/06_post_processing.html">6. Post-processing &gt;</a></b>
    </span>
</p>

<p align="center"><b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/">Back to homepage</a></b></p>