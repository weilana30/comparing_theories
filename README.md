# Geometry Optimization Comparison

This project explores the performance of seven different levels of theory for molecular geometry optimization. The goal is to analyze how computational methods affect optimized structures and to build a dataset for machine learning applications.

## Overview

- **Objective:** Compare geometry optimization results across multiple computational chemistry methods.
- **Scope:** Optimized geometries for a large set of molecules (used for subsequent ML models predicting molecular properties like HOMO/LUMO gaps).
- **Tools:** Python, computational chemistry software (e.g., Gaussian, ORCA), RDKit for molecular processing.

## Methods

The project involved:

1. Selecting a representative set of molecules. I used the dataset used to train CASCADE 1.0 by the Paton Lab at Colorado State University.
2. Performing geometry optimization using seven different levels of theory (AIMNET-2, Egret-1, UMA, ωB97mv-D4/def2-TZVP, B3LYP-D3/def2-TZVP, r2scan-3c, xTB).
3. Collecting optimized geometries and relevant molecular properties.
4. Comparing root mean squared deviation (rmsd) of all optimized geometries with a baseline (optimized at M06-2x/def2-TZVP).

## Dataset

- **Size:** 6,000 drug-related molecules.
- **Format:** Standard chemical formats compatible with RDKit and ML pipelines (e.g., `.sdf` or `.xyz` files).

## Results

- Analysis of findings can be found in the /analysis/rmsd_analysis.ipynb notebook for analysis on accuracy and /analysis/time_comparison.ipynb for analysis on computational cost.

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/geometry-optimization-comparison.git
