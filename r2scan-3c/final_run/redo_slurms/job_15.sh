#!/bin/bash
#SBATCH --job-name="r2scan3c_calc"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=32G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 2-00:00:00

source ~/.bashrc
module load cpu/0.15.4
module load gcc/9.2.0
module load openmpi/4.1.1

SCRATCH="/scratch/$USER/job_$SLURM_JOB_ID"

mkdir -p "$SCRATCH"
mkdir -p "$SCRATCH/redo_outputs"

cp -r /home/aweiland/comparing_theories/r2scan-3c/final_run/redo_batches/batch_15 "$SCRATCH/"

cd "$SCRATCH/batch_15"

for file in *.inp; do
    echo "DEBUG: Running ORCA on file '$file'"
    mol_num=$(basename "$file" .inp)
    mkdir -p "$SCRATCH/redo_outputs/batch_15/$mol_num"
    /usr/bin/time -p /home/aweiland/comparing_theories/orca/orca_6_1_0_linux_x86-64_shared_openmpi418/orca "$file" > "$SCRATCH/redo_outputs/batch_15/$mol_num/${mol_num}.out" 2> "$SCRATCH/redo_outputs/batch_15/$mol_num/runtime.txt"
done

mkdir -p /home/aweiland/comparing_theories/r2scan-3c/final_run/redo_outputs/batch_15
cp -r "$SCRATCH/redo_outputs/batch_15"/* /home/aweiland/comparing_theories/r2scan-3c/final_run/redo_outputs/batch_15/
