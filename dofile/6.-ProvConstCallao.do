
*********************************
**Prov Constitucional del Callao:
*********************************
cd "$dataset"
**database
use "dbasedep.dta", clear
keep    if _ID==7
rename (x_c y_c) (_X _Y)
sort _ID
save "dbaseCallao.dta", replace

*coordenadas
use coordep.dta,clear
keep if _ID==7
sort _ID
save coor_callao,replace 
