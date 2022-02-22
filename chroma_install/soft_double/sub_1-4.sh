#!/bin/bash

#SBATCH --job-name=make_1-4
#SBATCH --partition=64c512g
#SBATCH -N 1
#SBATCH --ntasks-per-node=32
#SBATCH --exclusive
#SBATCH --output=make_1-4.out
#SBATCH --error=make_1-4.err
#SBATCH --exclude=node171

bash make_1.sh
bash make_2.sh
bash make_3.sh
bash make_4.sh
