---
accordion: 
  - title: Excersise 4.1
    content: |
            ```bash
            #summary of current states of compute nodes known to the scheduler
            $ sinfo

            #similar to above but expanded
            $ sinfo --format="%16P %.8m %.5a %10T %.5D %80N"

            #will print a long output as it is one row per compute node in the cluster
            $ sinfo -N -l

            #Explore the capacity of a compute node
            $ sinfo -n wch001 -o "%n %c %m"
            ```
---


# 4. Working with job scheduler

<p style="text-align:left;">
    <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/03_scaling_up.html">&lt; 3. Scaling up</a></b>
    <span style="float:right;">
     <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/05_parallel_job_arrays.html">5. Parallel Job Arrays  &gt;</a></b>
    </span>
</p>

## Outline
* Do not remove this line (it will not be displayed)
{:toc}

## Introduction to slurm scheduler and directives

An HPC system might have thousands of nodes and thousands of users. How do we decide who gets what and when? How do we ensure that a task is run with the resources it needs? This job is handled by a special piece of software called the scheduler. On an HPC system, the scheduler manages which jobs run where and when. In brief, scheduler is a 


* Mechanism to control access by many users to shared computing resources
* Queuing / scheduling system for users’ jobs
* Manages the reservation of resources and job execution on these resources 
* Allows users to “fire and forget” large, long calculations or many jobs (“production runs”)

Why do we need a scheduler ?

* To ensure the machine is utilised as fully as possible
* To ensure all users get a fair chance to use compute resources (demand usually exceeds supply)
* To track usage - for accounting and budget control
* To mediate access to other resources e.g. software licences

Commonly used schedulers

* Slurm
* PBS , Torque
* Grid Engine
* LSF – IBM Systems
* LoadLeveller – IBM Systems


All NeSI clusters use Slurm *(Simple Linux Utility for Resource Management)* scheduler (or job submission system) to manage resources and how they are made available to users. The main commands you will use with Slurm on NeSI Mahuika cluster are:
   
---

| Command        | Function                                                                                             |
|:---------------|:------------------------------------------------------------------------------------------------------|
| `sbatch`       | Submit non-interactive (batch) jobs to the scheduler                                                 |
| `squeue`       | List jobs in the queue                                                                               |
| `scancel`      | Cancel a job                                                                                         |
| `sacct`        | Display accounting data for all jobs and job steps in the Slurm job accounting log or Slurm database|
| `srun`         | Slurm directive for parallel computing                                                                      |
| `sinfo`        | Query the current state of nodes                                                                     |
| `salloc`       | Submit interactive jobs to the scheduler                                                             |

---

>A quick note on `sinfo`(Query the current state of nodes) which is not a command a researcher will use regularly but helps HPC admins and support staff with monitoring. 
Let's run the following commands and discuss the outputs

{% include accordion.html %}

## Life cycle of a slurm job

<br>
<p align="center"><img src="nesi_images/slurm_flow.png" alt="drawing" width="1000"/></p> 
<br>


## Anatomy of a slurm script and submitting first slurm job 🧐

As with most other scheduler systems, job submission scripts in Slurm consist of a header section with the shell specification and options to the submission command (`sbatch` in this case) followed by the body of the script that actually runs the commands you want. In the header section, options to `sbatch` should be prepended with `#SBATCH`.

<br>
<p align="center"><img src="nesi_images/anatomy_of_a_slurm_script.png" alt="drawing" width="700"/></p> 
<br>

>Commented lines are ignored by the bash interpreter, but they are not ignored by slurm. The `#SBATCH` parameters are read by slurm when we submit the job. When the job starts, the bash interpreter will ignore all lines starting with `#`. This is very similar to the shebang mentioned earlier, when you run your script, the system looks at the `#!`, then uses the program at the subsequent path to interpret the script, in our case `/bin/bash` (the program `bash` found in the */bin* directory

---

| header          | use                                 | description                                          |
|:--------------- |:------------------------------------|:-----------------------------------------------------|
|--job-name 	  | `#SBATCH --job-name=MyJob` 	        |The name that will appear when using squeue or sacct. |
|--account 	      | `#SBATCH --account=nesi12345` 	    |The account your core hours will be 'charged' to.     |
|--time 	      | `#SBATCH --time=DD-HH:MM:SS` 	    |Job max walltime.                                     |
|--mem 	          | `#SBATCH --mem=512MB` 	            |Memory required per node.                             |
|--cpus-per-task  | `#SBATCH --cpus-per-task=10` 	    |Will request 10 logical CPUs per task.                |
|--output 	      | `#SBATCH --output=%j_output.out` 	|Path and name of standard output file. `%j` will be replaced by the job ID.         |
|--mail-user 	  | `#SBATCH --mail-user=me23@gmail.com`|address to send mail notifications.                   |
|--mail-type 	  | `#SBATCH --mail-type=ALL` 	        |Will send a mail notification at BEGIN END FAIL.      |
|                 | `#SBATCH --mail-type=TIME_LIMIT_80` |Will send message at 80% walltime.                    |

---
### Exercise 4.2

Let's put these directives together and compile our first slurm script

* First create a new working directory and write the script

```bash

#make sure the current path is the designated working directory
$ pwd
/nesi/project/nesi02659/sismonr_workshop/workingdir/me123/

#create a new directory for this section and change the directory to it
$ mkdir 4_wwscheduler && cd 4_wwscheduler

#use a text editor of choice to create a file named firstslurm.sl - we will use nano here
$ nano firstslurm.sl
```
>Content of `firstslum.sl` should be as below. Please discuss as you make progress
>
>```bash
>#!/bin/bash 
>
>#SBATCH --job-name      myfirstslurmjob
>#SBATCH --account       nesi02659
>#SBATCH --time          00:01:00
>#SBATCH --cpus-per-task 1
>#SBATCH --mem           512
>#SBATCH --output        slurmjob.%j.out
>
>sleep 40
>
>echo "I am a slurm job and I slept for 40 seconds"
>
>echo "$SLURM_JOB_ID END"
>```

* **Save** and **Exit**
* Submit the script with `sbatch` command

```bash
$ sbatch firstslum.sl
```
>Execute `squeue -u usrename` and `sacct`. Discuss the outputs

---

### STDOUT/STDERR from jobs

**STDOUT** and **STDERR** from jobs are, by default, written to a file called `slurm-<jobid>.out` and `slurm-<jobid>.err` in the working directory for the job (unless the job script changes this, this will be the directory where you submitted the job). So for a job with ID 12345 STDOUT and STDERR would be in `slurm-12345.out` and `slurm-12345.err`.

 When things go wrong, first step of **debugging** (STORY TIME !) starts with a referral to these files. 

## Assessing resource utilisation (cpu, memory, time)

Understanding the resources you have available and how to use them most efficiently is a vital skill in high performance computing. The three resources that every single job submitted on the platform needs to request are:

* CPUs (i.e. logical CPU cores), and
* Memory (RAM), and
* Time.

***What happens if I ask for the wrong resources?***

---

| Resource         | Asking for too much                                   | Not asking for enough                                                               |
|:---------------  |:------------------------------------------------------|:------------------------------------------------------------------------------------|
| Number of CPUs   | Job may wait in the queue for longer   	           | Job will run more slowly than expected, and so may run out time    |                    
|                  | Drop in fairshare score which determines job priority |                                                                                     |
| Memory           | (above)                                               | Job will fail, probably with `OUT OF MEMORY` error, segmentation fault or bus error|
| Wall time        | (above)                                               | Job will run out of time and get killed                                             |

---

### Exercise 4.3 

* Let's submit another slurm job and review its resource utilisation

```bash
$pwd
/nesi/project/nesi02659/sismonr_workshop/workingdir/me123/4_wwscheduler

#create a separate directory for .out files generated by slurm : This is a good practice 
$ mkdir slurmout

#copy the R script to current working directory
$ cp /nesi/project/nesi02659/sismonr_workshop/dev/slurm_examples/example1_arraysum.R ./

#copy the corresponding slurm script for above R script
$ cp /nesi/project/nesi02659/sismonr_workshop/dev/slurm_examples/example1_arraysum.sl ./

#edit the mail-user directive value with a valid email address and submit the script
$ sbatch example1_arraysum.sl 
```

>use `squeue -u username` and `sacct` again to evaluate the job status
>
>Once the job ran into completion, use `nn_seff jobid` command to print the resource utilisation statistics 
>
>```bash
>$ nn_seff 23263188
>Job ID: 23263188
>Cluster: mahuika
>User/Group: me1234/me123
>State: COMPLETED (exit code 0)
>Cores: 1
>Tasks: 1
>Nodes: 1
>Job Wall-time:  20.56%  00:00:37 of 00:03:00 time limit
>CPU Efficiency: 178.38%  00:01:06 of 00:00:37 core-walltime
>Mem Efficiency: 21.94%  224.68 MB of 1.00 GB
>```

---

## slurm profiling

Although `nn_seff` command is a quick and easy way to determine the resource utilisation, it relies on **peak** values (data gets recorded every 30 seconds) which doesn't allows us to examine resource usage over the run-time of the job. There are number of in-built/external tools to achieve the latter which will require some effort to understand its deployment, tracing and interpretation. Therefore, we will use **slurm native profiling** to evaluate resource usage over run-time. This is a simple and elegant solution.

### Exercise 4.4

* Edit `example1_arraysum.sl ` by adding the following slurm directives
    * `#SBATCH --profile task`  - CPU, Memory and I/O data collected
    * `#SBATCH --acctg-freq 1`  - By default, data will be gathered every 30 seconds. Given our job finishes in ~33 seconds, we will gather data every 1 second
    
* Once the above edits are done, submit the job as before with `sbatch example1_arraysum.sl`. Do take a note of the jobid

```bash

#collate the data into an HDF5 file using the command
$ sh5util -j jobid
sh5util: Merging node-step files into ./job_jobid.h5

#Download the python script to analyse and plot data in above .h5 file
$ curl -O https://raw.githubusercontent.com/DininduSenanayake/NeSI-Mahuika_slurm_profiling/master/profile_plot_Jul2020.py

#execute the script on .h5 file. We will need one of the Python 3 modules to do this. Ignore the deprecating warning 
$ module purge && module load Python/3.8.2-gimkl-2020a
$ python profile_plot_Jul2020.py job_jobid.h5

#This should generate a .png file where the filename is in the format of job_23258404_profile.png
``` 

<br>
<p align="center"><img src="nesi_images/slurm_profile.png" alt="drawing" width="1000"/></p> 
<br>

### Exercise 4.5 😬	

>Let's submit your first sismonr slum job. 
>* First step is to copy the already written R script to current working directory
>
>```bash
>#please do make sure the working directory is 4_wwscheduler
>$ pwd
>/nesi/project/nesi02659/sismonr_workshop/workingdir/me123/4_wwscheduler
>
>#copy the network file
>$ cp /nesi/project/nesi02659/sismonr_workshop/dev/slurm_small_sim/simulate_colsystem_1second.R ./
>```
>* Now build a slurm script with the following parameters
>    * We would like the name of the slurm script file to be ***firstsim_slurm.sl***
>    * job-name can be anything you want 
>    * `--cpus-per-task 1` and `--mem 1G` (this is based on test runs)
>    * `--time 00:12:00` ( we expect the job to run within 10.2 minutes. Let's give it a bit more as runtime can affected by other factors)
>    * Give any filename to `--out` but make sure the .out gets written into `slurmout` directory
>    * Let's add profiling as well. Given the job runs for ~10 minutes, let's leave slurm alone and *not* ask it to gather data every 1 second. Instead, we will run it with the **default** 30 second time points .i.e. Don't need a `--acctg-freq 1` directive
>    * Now to the bash commands section of the slurm script.  😱😱😱😱😱
>
>```bash
>export TMPDIR=/nesi/nobackup/nesi02659/tmp/tmp_$SLURM_JOB_ID
>mkdir -p $TMPDIR
>
>module purge
>module load sismonr/2.0.0-gimkl-2020a-R-4.1.0
>
>Rscript --vanilla simulate_colsystem_1second.R 
>```
---

<p style="text-align:left;">
    <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/03_scaling_up.html">&lt; 3. Scaling up</a></b>
    <span style="float:right;">
     <b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/workshop_material/05_parallel_job_arrays.html">5. Parallel Job Arrays  &gt;</a></b>
    </span>
</p>

<p align="center"><b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/">Back to homepage</a></b></p>
