#!/bin/bash

#SBATCH --job-name=make_7
#SBATCH --partition=debug64c512g
#SBATCH -N 1
#SBATCH --ntasks-per-node=32
#SBATCH --exclusive
#SBATCH --output=make_7.out
#SBATCH --error=make_7.err
#SBATCH --exclude=node171
 
bash make_7.sh