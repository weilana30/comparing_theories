from ase.build import fcc100, add_adsorbate, molecule
from fairchem.core import pretrained_mlip, FAIRChemCalculator
import ase.io
from ase.optimize import BFGS
import torch
from ase.calculators.calculator import all_changes
from mace.calculators import mace_off
from ase.io import Trajectory

test_file = "/home/aweiland/comparing_theories/dft_geometries/dft_xyz_files/dft_20071924.xyz"

atoms = ase.io.read(test_file, format="xyz")

predictor = pretrained_mlip.get_predict_unit("uma-s-1", device="cpu")  # or "cuda" if GPU available
calc = FAIRChemCalculator(predictor, task_name="omol")

atoms.calc = calc

traj = Trajectory('opt.traj', 'w', atoms)

opt = BFGS(atoms, logfile="opt.log", trajectory=traj)
opt.run(fmax=0.05)