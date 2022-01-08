
*********************************
**Prov Constitucional del Callao:
*********************************
cd "$dataset"
**database
use "dbase.dta", clear
keep    if id==7
rename (id x_c y_c) (_ID _X _Y)
sort _ID
save "dbaseCallao.dta", replace

*coordenadas
use coordep.dta,clear
keep if _ID==7
sort _ID
save coor_callao,replace 
