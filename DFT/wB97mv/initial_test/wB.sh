#!/bin/bash
#SBATCH --job-name="r2scan3c_test"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=16G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 02:00:00

source ~/.bashrc
module load cpu/0.15.4
module load gcc/9.2.0
module load openmpi/4.1.1

SCRATCH="/scratch/$USER/job_$SLURM_JOB_ID"

mkdir -p "$SCRATCH"
mkdir -p "$SCRATCH/outputs"

cp "/home/aweiland/comparing_theories/DFT/wB97mv/initial_test/wB.inp" "$SCRATCH/"

cd "$SCRATCH"


/home/aweiland/comparing_theories/orca/orca_6_1_0_linux_x86-64_shared_openmpi418/orca wB.inp > wB.out

cp -r $SCRATCH/* /home/aweiland/comparing_theories/DFT/wB97mv/initial_test/

