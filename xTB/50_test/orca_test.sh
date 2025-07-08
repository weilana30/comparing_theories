#!/bin/bash
#SBATCH --job-name="xtb_test"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=32G
#SBATCH --account=slc154
#SBATCH --export=ALL
#SBATCH -t 04:00:00

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


INPUT_DIR="/home/aweiland/comparing_theories/xTB/50_test/50_mols"
OUTPUT_BASE="/home/aweiland/comparing_theories/xTB/50_test/outputs"
mkdir -p "$OUTPUT_BASE"

start_time=$(date +"%s")
# --- Use that path to call ORCA
for file in ${INPUT_DIR}/*.inp; do
    base=$(basename "$file" .inp)
    OUTPUT_DIR="$OUTPUT_BASE/$base"
    mkdir -p "$OUTPUT_DIR"
    
    cp "$file" "$OUTPUT_DIR/"
    
    cd "$OUTPUT_DIR"
    $MY_ORCA_WRAPPER/orca "${base}.inp" > "${base}.out"
done

end=$(date +"%s")
total_time=$((end - start_time))
echo "The 50 molecules took $total_time seconds"

