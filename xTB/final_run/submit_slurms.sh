#!/bin/bash
#SBATCH --job-name="submit_slurms"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=1G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 00:10:00

SLURM_DIR="/home/aweiland/comparing_theories/xTB/final_run/slurm_scripts"

shopt -s nullglob

for script in "$SLURM_DIR"/job_*.sh; do
    
    num=${script##*_}
    num=${num%.sh}

    if [[ $num =~ ^[0-9]+$ ]] && (( num >= 0 && num <= 19 )); then
        continue
    fi

    sbatch "$script"
    echo "Submitted batch $num script: $script" >> script_submissions.txt
    sleep 5
done

