#!/bin/bash
#SBATCH --job-name="xtb_test"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=8G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 00:30:00

source ~/.bashrc
conda activate xtb
module load cpu/0.15.4
module load gcc/9.2.0
module load openmpi/4.1.1


export MY_ORCA_WRAPPER=$SLURM_TMPDIR/orca_xtb_wrapper
mkdir -p $MY_ORCA_WRAPPER

# --- Link ORCA binaries
ORCA_BIN_DIR=/home/aweiland/comparing_theories/orca/orca_6_1_0_linux_x86-64_shared_openmpi418
ln -s $ORCA_BIN_DIR/* $MY_ORCA_WRAPPER/

# --- Link xtb binary from conda env into same directory
ln -s $(which xtb) $MY_ORCA_WRAPPER/xtb

# --- Use that path to call ORCA
$MY_ORCA_WRAPPER/orca xtb_test2.inp > xtb_test2.out

