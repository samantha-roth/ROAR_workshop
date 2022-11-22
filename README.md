# ROAR_workshop
tutorial on how to do some basic stuff with PSU's supercomputing system


PART 1: Just use the RStudio Server!

1. Go to https://portal2.aci.ics.psu.edu/pun/sys/dashboard/ and log in.

2. Under Interactive Apps, click RStudio Server

3. Under Allocation, click "open" or whatever else is available to you.

4. You can use a custom environment if you want, but you don't have to. We'll start without one.

   a) Creating and using a custom environment is useful for code reproducibility since you can keep the version of R the same and you don't have reinstall the same R packages over and over again.
   
   b) You may need to use software like "gcc" or "github" and you can find which versions are available to use here: https://www.icds.psu.edu/computing-services/software/

5. Select an R version (only matters if there's no custom environment).

6. Select 1 hour, 1 core, and 5gb of memory per core.

   a) You should only select more than one core if you want to parallelize something, which we will do later. For now we just need one.
   
   b) The amount of memory you choose should be the amount of memory you think you'll use. Unless you're working with a large dataset or fitting a very complex model you shouldn't need much memory.

7. Aaaaand you all know how to use RStudio.

PART 2: Create a yml file and a pbs script for creating conda environments.

1. Create a new text file and add dependencies (a.k.a. R packages) as shown in parallel_env.yml
   
   a) In general, when adding dependencies, you can find the right name by searching the name of the R package in the search bar at: https://anaconda.org/conda-forge/

2. Make sure to save the file name as parallel_env.yml (the .yml part is most important, DO NOT write .R!)

3. Create another new text file with specifications as shown in make_parallel_env.yml
   
   a) "#!/bin/bash": Always put this at the top. Don't ask me what it means.
   
   b) "#PBS -l nodes=1:ppn=1": Only specify >1 ppn (processor per node) if you need to parallelize code.
      
      i. Ex: "#PBS -l nodes=1:ppn=19": Request 19 ppn to parallelize your code across 18 processors. Request 19 ppn because one parent node is needed.
   
   c) "#PBS -l walltime=48:00:00": what is the maximum amount of time you think your code will take to run? format is HOURS:MINUTES:SECONDS. 
      
      i. You can't request more than 48 hours. Your code will get to the front of the line to be run faster if you request less time.
   
   d) "#PBS -l pmem=10gb" OR "#PBS -l mem=10gb": if you write pmem this is the amount of memory per processor. If you write mem, this is the amount of total memory requested. 
      
      i. If you only specify 1 ppn, these two mean the same thing. 
      
      ii. Be careful not to request more memory per node than is allowed in your specified allocation. Mine allows up to 250 gb total, which I think is also true for the stat department allocation since "sc" indicates standard core -- same kind of allocation. 
   
   e) "#PBS -A open": the allocation you want to run your code on. 
      
      i. Yours could also be the stat department allocation, "drh20_a_g_sc_default". There are 10 nodes and 20 processors per node available on this allocation. 
   
   f) "#PBS -j oe": I forgot what this means but I always leave it there.
   
   g) "module load python/3.6.8": need this to set up a conda environment. The appropriate version of python is specified at https://www.icds.psu.edu/computing-services/software/
   
   h) "module load anaconda3/2021.05": need this to set up a conda environment. The appropriate version of anaconda is specified at https://www.icds.psu.edu/computing-services/software/
   
   i) "cd /storage/work/svr5482/ROAR_workshop": cd changes the working directory to the file structure where your .yml is located.
   
   j) "conda env create --file paralell_env.yml": create the conda environment with the name of your .yml file!
   
   k) "source deactivate": deactivate your conda environment when you're done using it.


"source activate /storage/work/svr5482/parallel_env" activates the conda environment you want to run your code in. If you're not using anything more than the base R packages in your code you don't need this line since you don't need to create a conda environment to load other packages. I'll send another email on conda environments.
"cd /storage/work/svr5482/Climate_CornYield-me/yield/data_prep": cd changes the working directory to the file structure where your R script is located.
"Rscript macametmodel_dataframe.R": tells ROAR to run your .R file
