# vmd script to view CPP binding onto siRNA

# view  / render setting
display projection Orthographic
display resetview
axes location Off

color Display Background white
display depthcue off
 display shadows on
 display ambientocclusion on
 display aoambient 0.700000
 display aoambient 0.600000
 display aodirect 0.400000
 display aodirect 0.500000


rotate x by 90.000000



# BUILDING REPRESENTATIONS

mol modselect 0 0 nucleic
mol modstyle 0 0 QuickSurf 1.000000 0.500000 1.000000 1.000000
mol modcolor 0 0 Type
mol color Element
mol representation QuickSurf 1.000000 0.500000 1.000000 1.000000
mol selection nucleic
mol material Opaque
mol addrep 0
mol modselect 1 0 protein
mol modcolor 1 0 ResType
mol modstyle 1 0 NewCartoon 0.300000 10.000000 4.100000 0
mol color ResType
mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol selection protein
mol material Opaque
mol addrep 0
mol modstyle 2 0 Licorice 0.100000 10.000000 10.000000
#render Tachyon vmdscene.dat "/opt/vmd/vmd-1.9.1/lib/tachyon_LINUXAMD64" -aasamples 12 %s -format TARGA -o %s.tga
