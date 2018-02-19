
# please edit these to match your setting
nproc=<nproc>                                 # number of cpu cores to use
GMXDIR=/usr/local/bin                   # path to gmx
mdrun="${GMXDIR}/gmx mdrun -nt $nproc"  # gmx mdrun command

# do not edit below
env
nvidia-smi
export GMX_MAXBACKUP=-1

$GMXDIR/gmx grompp -f emin.mdp -c p38a.pdb -p p38a.top -o min
$mdrun -deffnm min -c min.pdb

$GMXDIR/gmx grompp -f equil.mdp -c min.pdb -p p38a.top -o equil
$mdrun -deffnm equil -c equil.pdb

