# Supplementary

<p align="center"><b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/">Back to homepage</a></b></p>

## Outline
* Do not remove this line (it will not be displayed)
{:toc}

## NeSI Mahuika Jupyter login


 1. <p>Follow [https://jupyter.nesi.org.nz/hub/login](https://jupyter.nesi.org.nz/hub/login)</p>
 2. <p>Enter NeSI username, HPC password and 6 digit second factor token <br><img src="nesi_images/jupyter_login_labels_updated.png" alt="drawing" width="720"/></p>
 3. <p>Choose server options as below<br><img src="nesi_images/ServerOptions_jupyterhubNeSI.png" alt="drawing" width="700"/></p>
 

## Opening a Jupyter teminal, create a working directory, switch Jupyter file explorer to correct path and open sismonr Jupyter kernel (sismonr/R-4.1.0) 

1. <p>Start a terminal session from the JupyterLab launcher<br><img src="nesi_images/jupyterLauncher.png" alt="terminal" width="500"/></p>

 When you connect to NeSI JupyterLab you always start in a new hidden directory. To make sure you can find your work next time, you should change to another location. Here we will create a working directory in project nesi02659 workspace for each attendee and then create a symlink from home (~) for easy access. 

 ```bash
 cd ~
 mkdir -p /nesi/project/nesi02659/sismonr_workshop/workingdir/$USER
 ln -s  /nesi/project/nesi02659/sismonr_workshop/workingdir/$USER sism_2021
 ```

2. <p>Guide Jupyter file explorer (left panel) to above working directory<br><img src="nesi_images/jupyter_fileexplorer.png" alt="drawing" width="700"/></p> 

3. <p>Open sismonr/R-4.1.0 kernel<br><img src="nesi_images/sismonr_kernel.png" alt="drawing" width="600"/></p>

## Local setup

---

<p align="center"><b><a href="https://genomicsaotearoa.github.io/Gene_Regulatory_Networks_Simulation_Workshop/">Back to homepage</a></b></p>