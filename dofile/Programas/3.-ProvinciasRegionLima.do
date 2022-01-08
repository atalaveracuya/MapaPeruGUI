
******************************
*Provincias de la Region lima 
******************************
*database
use dbaseprov,clear
keep if NOMBDEP=="LIMA" & NOMBPROV!="LIMA"
rename (id x_c y_c) (_ID _X _Y)
sort _ID
save "dbaseprovregionlima.dta", replace

*coordenadas
use coorprov.dta,clear
keep if _ID>=130 & _ID<=138
save "coor_provregionlima",replace 

*use dbaseprovregionlima.dta
*spmap using coor_provregionlima, id(_ID)