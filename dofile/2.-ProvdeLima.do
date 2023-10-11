
**********************
*provincia de Lima
**********************
cd "$dataset"
	*database
use dbaseprov,clear
keep if _ID==129
rename (x_c y_c) (_X _Y)
sort _ID
replace NOMBPROV="LIMA" if NOMBPROV=="LIMA"
save "dbaseprovlima.dta", replace

    *coordenadas
use coorprov.dta,clear
keep if _ID==129
save coor_provlima,replace 

*use dbaseprovlima
*spmap using coor_provlima.dta, id(_ID)