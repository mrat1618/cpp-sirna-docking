# vmd script to view CPP binding onto siRNA

# view  / render setting
display projection Orthographic
display resetview
axes location Off

#color Display Background white
#display depthcue off
 display shadows on
 display ambientocclusion on
 display aoambient 0.700000
 display aoambient 0.600000
 display aodirect 0.400000
 display aodirect 0.500000

rotate x by 90.000000

# BUILDING REPRESENTATIONS

mol modselect 0 0 segname N1 N2
mol modcolor 0 0 Type
mol modstyle 0 0 QuickSurf 1.000000 0.500000 1.000000 1.000000

set nCPPs 30

# for all but last CPP
for { set i 1 } { $i <= $nCPPs } { incr i } {
	mol color ResType
	mol representation NewCartoon 0.300000 10.000000 4.100000 0
	mol selection segname P$i
	mol material Diffuse
	mol addrep 0
	mol showrep 0 $i 0
}

for { set i 1 } { $i <= $nCPPs } { incr i } {
	mol showrep 0 $i 0
} 
