#! /bin/bash

#Script to work with all folders simultaniously

#for folder in Bac715-24 Buforin2 C105Y c6 CADY CCMV-Gag Grb2 HepatitisB HIV1gp41 HIV_TAT_47-57 IntergrinB3 KaposiFGF MPG Penitratin pVEC R10 sC18 SV40 Transprotan c6m c6m1 c6m2 c6m3 c6m4 c6m5 c6m6
for folder in c6m c6m2 c6m3 c6m4 c6m5 c6m6

do
# make directories
  #mkdir $folder 

# move CPPs
  #mv cpps-for-docking/min$folder.pdb $folder/
  #mv $folder/min$folder.pdb $folder/$folder.pdb

# preparation for energy minimization
cd $folder
  #cp ../*.mdp .
  #gmx pdb2gmx -ff charmm27 -f $folder.pdb -o $folder.gro -p $folder.top -ignh -water tip3p
  #gmx editconf -f $folder.gro -o box.gro -c -d 1.0 -bt cubic 
  #gmx solvate -cp box.gro -cs spc216.gro -o solvate.gro -p $folder.top
  #gmx grompp -f ions.mdp -c solvate.gro -p $folder.top -o ions.tpr
  #echo SOL | gmx genion -s ions.tpr -o ions.gro -p $folder.top -pname NA -nname CL -neutral

# minimization
  #gmx grompp -f minim.mdp -c ions.gro -p $folder.top -o em.tpr
  #gmx mdrun -nt 6 -deffnm em
  #echo "$(tput setaf 1)$(tput setab 7) Job $folder done!!! $(tput sgr 0)"

# finishing-up
  #gmx editconf -f em.gro -o em.pdb
  # remove everything except CPP
  #sed -e '/SOL/,$d' em.pdb > min$folder.pdb
  #echo "TER \nENDMDL" >> min$folder.pdb

# move minimized files
  #mkdir min
  #mv * min/
  #cp min/min*.pdb . 

cd ..

done
