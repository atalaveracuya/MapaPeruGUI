
clear all
cd "$shapefile"


shp2dta using "LIMITE_DIST.shp", ///
    data("${dataset}\dbasedist.dta") coor("${dataset}\coordist.dta") genid(id) gencentroids(c) replace

clear 
shp2dta using "LIMITE_PROV.shp", ///
    data("${dataset}\dbaseprov.dta") coor("${dataset}\coorprov.dta") genid(id) gencentroids(c) replace
	
clear 
shp2dta using "LIMITE_DEP.shp", ///
    data("${dataset}\dbasedep.dta") coor("${dataset}\coordep.dta") genid(id) gencentroids(c) replace

clear
shp2dta using "LAGO_TITICACA_GEO.shp", ///
    data("${dataset}\dbasetiticaca.dta") coor("${dataset}\coortiticaca.dta") genid(id) gencentroids(c) replace
	

cd "$dataset"	
foreach x in dep prov dist titicaca{ 
use dbase`x',clear 
rename id _ID 
save,replace
}
	