#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -o benchmark.out
#$ -j y
#$ -N benchmark
#$ -l h_data=1000M,h_rt=240:00:00
#$ -pe mpi 8
#$ -R y

# please edit these to match your setting
nproc=8                                 # number of cpu cores to use
GMXDIR=/shared/apps/gromacs/2018.1/bin  # path to gmx
mdrun="${GMXDIR}/gmx mdrun -nt $nproc"  # gmx mdrun command

# do not edit below
env
nvidia-smi
export GMX_MAXBACKUP=-1

$GMXDIR/gmx grompp -f emin.mdp -c fab.pdb -p fab.top -o min -r fab.pdb -maxwarn 4
$mdrun -deffnm min -c min.pdb

$GMXDIR/gmx grompp -f equil.mdp -c min.pdb -p fab.top -o equil -r fab.pdb -maxwarn 4
$mdrun -deffnm equil -c equil.pdb

