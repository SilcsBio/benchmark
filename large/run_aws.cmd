#!/bin/bash
#SBATCH --output benchmark_test.out
#SBATCH --job-name l_202X.Y
#SBATCH --ntasks 8
#SBATCH --partition gpu
#SBATCH --time 24:00:00

nproc=8
#GMXDIR="/shared/apps/gromacs/2020.3/bin"
#GMXDIR=/shared/apps/gromacs/2021.3/bin
GMXDIR="/shared/apps/gromacs/2021.4/bin"
charmmff="charmm36.ff"

mpirun="mpirun --leave-session-attached"

mdrun="${GMXDIR}/gmx mdrun -nt $nproc"  # gmx mdrun command

# do not edit below
env
nvidia-smi
export GMX_MAXBACKUP=-1

$GMXDIR/gmx grompp -f emin.mdp -c fab.pdb -p fab.top -o min -r fab.pdb -maxwarn 4
$mdrun -deffnm min -c min.pdb

$GMXDIR/gmx grompp -f equil.mdp -c min.pdb -p fab.top -o equil -r fab.pdb -maxwarn 4
$mdrun -deffnm equil -c equil.pdb

$GMXDIR/gmx grompp -f prod.mdp -c equil.pdb -p fab.top -o prod -r fab.pdb -maxwarn 4
$mdrun -deffnm prod -c prod.pdb

