
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

clear
shp2dta using "SAN_JUAN_DE_LURIGANCHO_LIMA_150132_Manzanas_Poblacion.shp", ///
    data("${dataset}\dbasemzn-150132.dta") coor("${dataset}\coormzn-150132.dta") genid(id) gencentroids(c) replace
	
cd "$dataset"	
foreach x in dep prov dist titicaca mzn-150132{ 
use dbase`x',clear 
rename id _ID 
save,replace
}
	
	