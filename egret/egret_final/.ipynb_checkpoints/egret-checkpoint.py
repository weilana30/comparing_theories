import ase.io
from ase.optimize import BFGS
import torch
from ase.calculators.calculator import all_changes
from mace.calculators import mace_off
from ase.io import Trajectory
import os
import click


@click.command()
@click.option('--batch_num', default=1, help='Batch number')

def main(batch_num):
    dir_100 = f"/home/aweiland/comparing_theories/egret/egret_final/batches/batch_{batch_num}"

    fmax=0.05

    for file in os.listdir(dir_100):
        if not file.endswith(".xyz"):
            continue

        path = os.path.join(dir_100, file)

        ids = file.strip("dft_").strip(".xyz")

        atoms = ase.io.read(path, format="xyz")

        model_path = "/home/aweiland/comparing_theories/egret/EGRET_1.model"

        calculator = mace_off(model=model_path, default_dtype="float64", device="cpu")


        atoms.calc = calculator

        traj_dir = f"/home/aweiland/comparing_theories/egret/egret_final/output/batch_{batch_num}/mol_{ids}"

        os.makedirs(traj_dir, exist_ok=True)

        traj_path = os.path.join(traj_dir, "opt.traj")
        log_path = os.path.join(traj_dir, "opt.log")

        traj = Trajectory(traj_path, 'w', atoms)
        opt = BFGS(atoms, trajectory=traj, logfile=log_path)
        opt.run(fmax=fmax)

if __name__ == "__main__":
    main()