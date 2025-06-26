import ase.io
from ase.optimize import BFGS
import torch
from ase.calculators.calculator import all_changes
from mace.calculators import mace_off
from ase.io import Trajectory
import os


dir_100 = "/home/aweiland/comparing_theories/egret/egret_benchmark/100_files"

fmax=0.1

for file in os.listdir(dir_100):
    if not file.endswith(".xyz"):
        continue
    
    path = os.path.join(dir_100, file)
    
    ids = file.strip("dft_").strip(".xyz")
    
    atoms = ase.io.read(path, format="xyz")

    model_path = "/home/aweiland/comparing_theories/egret/EGRET_1.model"

    calculator = mace_off(model=model_path, default_dtype="float64", device="cpu")


    atoms.calc = calculator

    traj_dir = f"/home/aweiland/comparing_theories/egret/egret_benchmark/outputs/{str(fmax)}/mol_{ids}"
    
    os.makedirs(traj_dir, exist_ok=True)
    
    traj_path = os.path.join(traj_dir, "opt.traj")
    log_path = os.path.join(traj_dir, "opt.log")
    
    traj = Trajectory(traj_path, 'w', atoms)
    opt = BFGS(atoms, trajectory=traj, logfile=log_path)
    opt.run(fmax=fmax)