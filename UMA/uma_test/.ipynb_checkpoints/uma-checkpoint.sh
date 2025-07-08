#!/bin/bash
#SBATCH --job-name="uma-test"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 00:30:00


source ~/.bashrc
conda activate egret-env

python /home/aweiland/comparing_theories/UMA/uma_test/uma_test.py