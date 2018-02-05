#! /bin/bash

for folder in Bac715-24 Buforin2 c6 c6m c6m1 c6m2 c6m3 c6m4 c6m5 c6m6 C105Y CADY CCMV-Gag Grb2 HepatitisB HIV1gp41 HIV_TAT_47-57 IntergrinB3 KaposiFGF MPG Penitratin pVEC R10 sC18 SV40 Transprotan HIV1gp41-16E6 Penitratin-16E6 CADY-16E6
do
    for (( i=1; i<=30; i++))
    do
        cd $folder/$i
        sed -n 3p cluspro*.csv | cut -c 23- >> ../../results/results-$folder.dat
        cd ../..
        done
done
