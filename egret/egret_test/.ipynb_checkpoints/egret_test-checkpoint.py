import ase.io
from ase.optimize import BFGS
import torch
from ase.calculators.calculator import all_changes
from mace.calculators import mace_off
from ase.io import Trajectory

test_file = "/home/aweiland/comparing_theories/dft_geometries/dft_xyz_files/dft_20071924.xyz"

atoms = ase.io.read(test_file, format="xyz")

model_path = "/home/aweiland/comparing_theories/egret/EGRET_1.model"

calculator = mace_off(model=model_path, default_dtype="float64", device="cpu")


atoms.calc = calculator


traj = Trajectory('egret_test_opt.traj', 'w', atoms)
opt = BFGS(atoms, trajectory=traj, logfile="egret_test_opt.log")
opt.run(fmax=0.1)