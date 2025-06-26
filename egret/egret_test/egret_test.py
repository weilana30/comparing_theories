import ase.io
from ase.optimize import BFGS
import torch
from ase.calculators.calculator import all_changes
from mace.calculators import mace_off
from ase.io import Trajectory


dir_100 = "/home/aweiland/comparing_theories/egret/egret_benchmark/100_files"



for file in os.listdir(dir_100):
    
    #path to xyz file
    path = os.path.join(dir_100, file)
    
    #id of mol
    ids = file.strip("dft_").strip(".xyz")

    atoms = ase.io.read(path, format="xyz")

    model_path = "/home/aweiland/comparing_theories/egret/EGRET_1.model"

    calculator = mace_off(model=model_path, default_dtype="float64", device="cpu")


    atoms.calc = calculator


    traj = Trajectory(f'egret_opt.traj', 'w', atoms)
    opt = BFGS(atoms, trajectory=traj, logfile="egret_test_opt.log")
    opt.run(fmax=0.1)