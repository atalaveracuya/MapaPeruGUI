
*********************************
**Prov Constitucional del Callao:
*********************************

**database
use "dbase.dta", clear
keep    if id==7
replace id=777
rename (id x_c y_c) (_ID _X _Y)
sort _ID
save "dbaseCallao.dta", replace

*coordenadas
use coordep.dta,clear
keep if _ID==7
replace _ID=777
sort _ID
save coor_callao,replace 

/*
use dbaseCallao.dta
spmap using coor_callao, id(_ID)


*https://www.statalist.org/forums/forum/general-stata-discussion/general/1362679-spmap-display-alaska-and-hawaii-next-to-contiguous-united-states

* apply a Google Maps projection
use "coor_callao.dta", clear
geo2xy _Y _X, replace
save "coor_callao_XY.dta", replace

* create the map
use "dbaseCallao.dta", clear
spmap using "coor_callao_XY.dta", id(_ID)
graph export "coor_callao_XY.png", width(1000) replace





/*



use xycoor_provconstCallao,clear 
replace _X = _X - 1
replace _Y = _X - 1
gen nuts = 1
sort _ID, stable
save,replace 

use xycoord,clear
gen nuts=2 
append using xycoor_provconstCallao
sort _ID, stable
save, replace 
