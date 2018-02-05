#! /bin/bash

for folder in Buforin2 c6 c6m c6m1 c6m2 c6m3 c6m4 c6m5 c6m6 C105Y CADY CADY-16E6 CCMV-Gag Grb2 HepatitisB HIV1gp41 HIV1gp41-16E6 HIV_TAT_47-57 IntergrinB3 KaposiFGF MPG Penitratin Penitratin-16E6 pVEC R10 sC18 SV40 Transprotan 
#Bac715-24
do
cd $folder
vmd -dispdev text -eofexit < /home/madhuranga/Desktop/scripts/sasa.tcl
cd ..
done
