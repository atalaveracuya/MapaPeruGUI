********************************************************
*****poligonos adicionales para el callao y tumbes *****
********************************************************
* polygon for squares that connect to the right or left
cd "$dataset"
clear
input float(obs x y rconnect)
1  .  . 0
2 -1  0 0
3 -1  1 0
4  1  1 0
5  1 -1 0
6 -1 -1 0
7 -1  0 0
1  .  . 1
2  1  0 1
3  1 -1 1
4 -1 -1 1
5 -1  1 1
6  1  1 1
7  1  0 1
end
tempfile poly
save "`poly'"

* group label by whether they connect to the middle-right or not
use "xy_dbase_ubicaciones.dta", clear
keep if !mi(rconnect)
keep if lgroup == 1
sort rconnect NOMBDEP
keep _ID NOMBDEP x_label y_label rconnect
list , sepby(rconnect)

* form all pairwise combinations with the polygon points
joinby rconnect using "`poly'"
isid rconnect NOMBDEP obs, sort

* scale using 30 km for each unit segment
gen x_sq = x_label + cond(rconnect,100,-100) + 30 * x
gen y_sq = y_label + 30 * y
save "squares.dta", replace

* combine with the composite map's coordinates
keep _ID x_sq y_sq
rename (x_sq y_sq) (_X _Y)
keep _ID _X _Y
append using "xycoord.dta"
sort _ID, stable

save "xy_coor_with_squares.dta", replace