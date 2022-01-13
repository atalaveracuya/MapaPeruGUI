*****************
**Peru sin Lima:
*****************
cd "$dataset"
**database
use "dbasedep.dta", clear
drop if _ID==15
rename (x_c y_c) (_X _Y)
sort _ID
save "perusinlimadbase.dta", replace

*coordenadas
use coordep.dta,clear
drop if _ID==15
save coor_perusinlima,replace 


*use perusinlimadbase.dta
*spmap using coor_perusinlima, id(_ID)