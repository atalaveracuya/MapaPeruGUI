
**********************
*provincia de Lima
**********************
	*database
use dbaseprov,clear
keep if id==129
rename (id x_c y_c) (_ID _X _Y)
sort _ID
replace NOMBPROV="PROVINCIA LIMA" if NOMBPROV=="LIMA"
save "dbaseprovlima.dta", replace

    *coordenadas
use coorprov.dta,clear
keep if _ID==129
save coor_provlima,replace 

*use dbaseprovlima
*spmap using coor_provlima.dta, id(_ID)