#! /bin/bash

#Script to work with all folders simultaniously
echo "##########__NEW_SIM__##########" >> status.log
echo "Start time: $(date)" >> status.log

round=29

for folder in Bac715-24 Buforin2 c6 c6m c6m1 c6m2 c6m3 c6m5 c6m6 C105Y CADY CADY-16E6 CCMV-Gag Grb2 HepatitisB HIV1gp41 HIV1gp41-16E6 HIV_TAT_47-57 IntergrinB3 KaposiFGF MPG Penitratin Penitratin-16E6 pVEC sC18 SV40 Transprotan 
# sC18 c6m4 R10 

do
#mkdir $folder/$round

cd $folder/$round
#reset folder
  #sh ../../sh/reset-folder.sh

#copy sim files
  cp ../../sim/* .

#Fix pdb downloaded from ClusPro. need to remove termination of receptor at line 1346
  #sh ../../sh/fix-pdb.sh

#Make separate chains for RNA strands (A and B) and Protein (P)
  vmd -dispdev text model.000.00.pdb -eofexit < ../../sh/chain.tcl

#PSF Gen
  vmd -dispdev text chain-fixed.pdb -eofexit < ../../sh/PSFGen.tcl

#Fix 3 letter Nucleic acid to single letter
  sh ../../sh/FindAndReplace.sh

#------------------------------------------------------
#GMX
  gmx pdb2gmx -ff charmm27 -f complex.pdb -o complex.gro -p complex.top -ignh -water tip3p 

  gmx editconf -f complex.gro -o box.gro -c -d 1.0 -bt cubic 
  gmx solvate -cp box.gro -cs spc216.gro -o solvate.gro -p complex.top

  gmx grompp -f ions.mdp -c solvate.gro -p complex.top -o ions.tpr
  echo SOL | gmx genion -s ions.tpr -o ions.gro -p complex.top -pname NA -nname CL -neutral

  gmx grompp -f minim.mdp -n rna.ndx -c ions.gro -p complex.top -o em.tpr

  gmx mdrun -v -deffnm em

#------------------------------------------------------
# finishing-up
  gmx editconf -f em.gro -o em.pdb
  # remove everything except complex
  sed -e '/SOL/,$d' em.pdb > min$folder-$round.pdb
  echo "TER \nENDMDL" >> min$folder-$round.pdb

cd ../..
 
#------------------------------------------------------
echo "$(tput setaf 1)$(tput setab 7) Minimization of $folder: Docking $round done!!!$(tput sgr 0)"
echo "Minimization of $folder: Docking $round done!!! at $(date)" >> status.log

done

echo "##########__END_SIM__##########" >> status.log

