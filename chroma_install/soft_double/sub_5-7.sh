#!/bin/bash

#SBATCH --job-name=make_5-7
#SBATCH --partition=64c512g
#SBATCH -N 1
#SBATCH --ntasks-per-node=32
#SBATCH --exclusive
#SBATCH --output=make_5-7.out
#SBATCH --error=make_5-7.err
#SBATCH --exclude=node171

bash make_5.sh
bash make_6.sh
bash make_7.sh
