#!/bin/bash
#SBATCH --job-name="r2scan3c_test"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=16G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 12:00:00

source ~/.bashrc
module load cpu/0.15.4
module load gcc/9.2.0
module load openmpi/4.1.1

SCRATCH="/scratch/$USER/job_$SLURM_JOB_ID"

mkdir -p "$SCRATCH"
mkdir -p "$SCRATCH/outputs"

cp "/home/aweiland/comparing_theories/DFT/B3LYP/initial_test/B3.inp" "$SCRATCH/"

cd "$SCRATCH"


/home/aweiland/comparing_theories/orca/orca_6_1_0_linux_x86-64_shared_openmpi418/orca B3.inp > B3.out

cp -r $SCRATCH/* /home/aweiland/comparing_theories/DFT/B3LYP/initial_test/

