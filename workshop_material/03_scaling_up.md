# 3. Scaling up your work

<p style="text-align:left;">
    <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/02_getting_started_sismonr.html">&lt; 2. Getting started with sismonr</a></b>
    <span style="float:right;">
     <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/04_parallel_computing.html">4. Parallel computing on NeSI &gt;</a></b>
    </span>
</p>

## Outline
* Do not remove this line (it will not be displayed)
{:toc}

## Introduction to HPC

### Defining high-performance computing

he simplest way of defining high-performance computing is by saying that it is the using of high-performance computers. However, this leads to our next question.

>**Question** - what you think defines a high-performance computer
><
>> **Answer**
>>
>>A high-performance computer is a network of computers in a cluster that typically share a common purpose and are used to accomplish tasks that might otherwise be too big for any one computer.
>>
>{: .answer}
<br>
<p>While modern computers can do a lot (and a lot more than their equivalents 10-20 years ago), there are limits to what they can do and the speed at which they are able to do this. One way to overcome these limits is to pool computers together to create a cluster of computers. These pooled resources can then be used to run software that requires more total memory, or need more processors to complete in a reasonable time.</p>

<p>One way to do this is to take a group of computers and link them together via a network switch. Consider a case where you have five 4-core computers. By connecting them together, you could run jobs on 20 cores, which could result in your software running faster.</p>

### HPC architectures

<p>Most HPC systems follow the ideas described above of taking many computers and linking them via network switches. What distinguishes a high-performance computer from the computer clusters described above is:</p>
<br>

* The number of computers/nodes 
* The strength of each individual computer/nodes 
* The network interconnect – this dictates the communication speed between nodes. The faster this speed is, the more a group of individual nodes will act like a unit.


### NeSI Mahuika Cluster architecture

NeSI Mahuika cluster (CRAY HPE CS400) system consists of a number of different node types. The ones visible to researchers are:

* Login nodes
* Compute nodes
<br>
<p align="center"><img src="nesi_images/hpc_architecture.png" alt="drawing" width="600"/></p> 
<br>
In reality

<p align="center"><img src="nesi_images/mahuika_maui_real.png" alt="drawing" width="600"/></p>


## Introduction to slurm scheduler and directives

## First slurm job

## Assessing time and memory usage

## slurm profiling

## Running more than 2 jobs (provisional)

---

<p style="text-align:left;">
    <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/02_getting_started_sismonr.html">&lt; 2. Getting started with sismonr</a></b>
    <span style="float:right;">
     <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/04_parallel_computing.html">4. Parallel computing on NeSI &gt;</a></b>
    </span>
</p>

<p align="center"><b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/">Back to homepage</a></b></p>
