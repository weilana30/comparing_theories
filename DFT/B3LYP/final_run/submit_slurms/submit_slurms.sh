#!/bin/bash
#SBATCH --job-name="submit_slurms"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=1G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 00:10:00

SLURM_DIR="/home/aweiland/comparing_theories/DFT/B3LYP/final_run/slurm_scripts"

for script in $SLURM_DIR/*.sh; do
    sbatch "$script"
    echo "Submitted $script" >> script_submissions.txt
    sleep 5
done