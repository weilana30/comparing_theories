#!/bin/bash
#SBATCH --job-name="xtb_test"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=2G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 00:30:00

source ~/.bashrc
conda activate xtb
module load cpu/0.15.4
module load gcc/9.2.0
module load openmpi/4.1.1
module load orca/5.0.1

export MY_ORCA_WRAPPER=$SLURM_TMPDIR/orca_xtb_wrapper
mkdir -p $MY_ORCA_WRAPPER

# --- Link ORCA binaries
ORCA_BIN_DIR=/cm/shared/apps/spack/cpu/opt/spack/linux-centos8-zen2/gcc-9.2.0/orca-5.0.1-jsqrtwvdaohcqu364ikkyihigrphx645/bin
ln -s $ORCA_BIN_DIR/* $MY_ORCA_WRAPPER/

# --- Link xtb binary from conda env into same directory
ln -s $(which xtb) $MY_ORCA_WRAPPER/xtb

# --- Use that path to call ORCA
$MY_ORCA_WRAPPER/orca xtb_test2.inp > xtb_test2.out

