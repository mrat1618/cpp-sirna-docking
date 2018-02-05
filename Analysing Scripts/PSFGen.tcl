### PART I - Split the separate segments into individual pdb files

# RA0, RB0 - double stranded siRNA
# RP, RQ ....  are peptides 
#  once Z is reached, wrap back around to C on the peptides.
#  last peptide is considered the ligand and is hence named L?0
set siRNA [atomselect top nucleic]
set CPP [atomselect top protein]
set ALL [atomselect top all]

set RNAsegl [lsort -unique [$siRNA get segname ]]
set PEPsegl [lsort -unique [$CPP get segname ]]
set seglist [lsort -unique [$ALL get segname ]]

set counter 0
foreach segment $seglist {
   set segsel [ atomselect top "segname $segment"]
   $segsel writepdb $segment.pdb
   incr counter 1
}

puts "pdbs written for $counter segments"


### END PART I ####



### PART II - Generate psf file for the whole complex
set NEWFILE complex
#set PARDIR /home/madhuranga/param/topper

package require psfgen 	 
topology /home/madhuranga/param/toppar/top_all36_prot.rtf
topology /home/madhuranga/param/toppar/top_all36_na.rtf

proc psfalias {} { 

        # Define common aliases 
        # Nucleic Acids 
        pdbalias residue G GUA 
        pdbalias residue C CYT 
        pdbalias residue A ADE 
        pdbalias residue T THY 
	pdbalias residue U URA

        pdbalias residue DG GUA 
        pdbalias residue DC CYT 
        pdbalias residue DA ADE 
        pdbalias residue DT THY 

	pdbalias residue HIS HSD    
	pdbalias atom ILE CD1 CD

        foreach bp { GUA CYT ADE THY URA } { 
                pdbalias atom $bp "O5\*" O5' 
                pdbalias atom $bp "C5\*" C5' 
                pdbalias atom $bp "O4\*" O4' 
                pdbalias atom $bp "C4\*" C4' 
                pdbalias atom $bp "C3\*" C3' 
                pdbalias atom $bp "O3\*" O3' 
                pdbalias atom $bp "C2\*" C2'  
                pdbalias atom $bp "O2\*" O2' 
                pdbalias atom $bp "C1\*" C1' 
 	    } 

      #pdbalias in C6
      pdbalias residue HIS HSE 

      #pdbalias in DOPC
      pdbalias atom DOPC O1 O12  	 
      pdbalias atom DOPC O2 O11 	 
      pdbalias atom DOPC O3 O13  	 
      pdbalias atom DOPC O4 O14  	 
      pdbalias atom DOPC P1 P
	#give aliases for atom names
	#pdbalias atom DT C7  C5M    

} 

psfalias

set RNAcnt 1
foreach segment $RNAsegl {
   segment RN$RNAcnt {pdb $segment.pdb} 	 
   coordpdb $segment.pdb RN$RNAcnt 
   patch 5TER RN$RNAcnt:1 	
   patch 3TER RN$RNAcnt:21 	
   incr RNAcnt 
}

set PEPcnt 1
foreach segment $PEPsegl {
   segment CP$PEPcnt {pdb $segment.pdb} 	 
   coordpdb $segment.pdb CP$PEPcnt 
   incr PEPcnt 
}

guesscoord 
regenerate angles dihedrals

writepsf $NEWFILE.psf 
writepdb $NEWFILE.pdb 

set newmol [molinfo num] 
set lastmol [expr $newmol -1 ]

mol off $lastmol
mol new $NEWFILE.psf type {psf} 
mol addfile $NEWFILE.pdb type {pdb} $newmol


foreach segment $seglist {
   rm ./$segment.pdb
}
