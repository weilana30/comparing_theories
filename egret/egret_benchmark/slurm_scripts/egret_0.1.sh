#!/bin/bash
#SBATCH --job-name="egret_test"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 16:00:00


source ~/.bashrc
conda activate egret-env

python /home/aweiland/comparing_theories/egret/egret_benchmark/fmax_py/0.1.py \ &> /home/aweiland/comparing_theories/egret/egret_benchmark/time/0.1.txt
