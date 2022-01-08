
clear all
cd "$shapefile"

shp2dta using "LIMITE_PROV.shp", ///
    data("dbaseprov.dta") coor("coorprov.dta") genid(id) gencentroids(c) replace
	
clear 
shp2dta using "LIMITE_DEP.shp", ///
    data("dbase.dta") coor("coordep.dta") genid(id) gencentroids(c) replace

clear
shp2dta using "LAGO_TITICACA_GEO.shp", ///
    data("dbase_titicaca.dta") coor("coor_titicaca.dta") genid(id) gencentroids(c) replace