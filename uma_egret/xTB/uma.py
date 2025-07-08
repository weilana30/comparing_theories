from ase.build import fcc100, add_adsorbate, molecule
from fairchem.core import pretrained_mlip, FAIRChemCalculator
import ase.io
from ase.optimize import BFGS
import torch
from ase.calculators.calculator import all_changes
from mace.calculators import mace_off
from ase.io import Trajectory
import os

directory = "/home/aweiland/comparing_theories/uma_egret/xTB/xtb_files"

for file in os.listdir(directory):
    if not file.endswith(".xyz"):
        continue
    
    path = os.path.join(directory, file)
    
    ids = file[6:].strip(".xyz")


    atoms = ase.io.read(path, format="xyz")

    predictor = pretrained_mlip.get_predict_unit("uma-s-1", device="cpu")
    calc = FAIRChemCalculator(predictor, task_name="omol")

    atoms.calc = calc
    
    
    traj_dir = f"comparing_theories/uma_egret/xTB/outputs/mol_{ids}"
    
    os.makedirs(traj_dir, exist_ok=True)
    
    traj_path = os.path.join(traj_dir, "opt.traj")
    log_path = os.path.join(traj_dir, "opt.log")

    opt = BFGS(atoms, logfile=log_path, trajectory=traj_path)
    opt.run(fmax=0.05)
