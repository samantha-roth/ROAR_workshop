#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --mem-per-cpu=5gb
#SBATCH --partition=open
#SBATCH --time=3:00:00 

module load anaconda3/2021.05
conda activate parallel_env

cd /storage/work/svr5482/ROAR_workshop/exercise4
Rscript exercise4.R
