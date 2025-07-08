#!/bin/bash
#SBATCH --job-name="egret_test"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 2-00:00:00


source ~/.bashrc
conda activate egret-env

python /home/aweiland/comparing_theories/UMA/final_uma/final_uma.py 