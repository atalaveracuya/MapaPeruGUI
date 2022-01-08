
clear all
cd "$shapefile"

shp2dta using "LIMITE_PROV.shp", ///
    data("${dataset}\dbaseprov.dta") coor("${dataset}\coorprov.dta") genid(id) gencentroids(c) replace
	
clear 
shp2dta using "LIMITE_DEP.shp", ///
    data("${dataset}\dbase.dta") coor("${dataset}\coordep.dta") genid(id) gencentroids(c) replace

clear
shp2dta using "LAGO_TITICACA_GEO.shp", ///
    data("${dataset}\dbase_titicaca.dta") coor("${dataset}\coor_titicaca.dta") genid(id) gencentroids(c) replace