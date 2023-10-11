
********************************************************
*****poligonos adicionales para el callao y tumbes *****
********************************************************
* polygon for squares that connect to the right or left
cd "$dataset"


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

geo2xy _Y _X , replace proj(mercator)
* convert to km and save the database and coordinates
replace _Y = _Y / 1000 + 1325
replace _X = _X / 1000 



rename _X x
rename _Y y
gen obs=_n
gen rconnect=1 
drop _ID 

save coor2_callao,replace
tempfile callao 
save "`callao'"

* group label by whether they connect to the middle-right or not
use "xy_dbase_ubicaciones.dta", clear
keep if !mi(rconnect)
keep if lgroup == 1
sort rconnect NOMBDEP
keep _ID NOMBDEP x_label y_label rconnect
list , sepby(rconnect)

* form all pairwise combinations with the polygon points
joinby rconnect using "`callao'"
isid rconnect NOMBDEP obs, sort


* scale using 30 km for each unit segment
gen x_sq = x_label + cond(rconnect,100,-100) + 5 * x 
gen y_sq = y_label + 5 * y 
save "squares2.dta", replace

* combine with the composite map's coordinates
keep _ID x_sq y_sq
rename (x_sq y_sq) (_X _Y)
keep _ID _X _Y

append using "xycoord.dta"
sort _ID, stable


save "xy_coor_with_squares_callao.dta", replace






use "xydatabase.dta", clear
spmap using "xy_coor_with_squares_callao.dta", id(_ID) ocolor(gs6) polygon(data("xycoor_titicaca.dta") osize(0.3) fcolor(blue) ocolor(blue)) line(data("xy_coor_with_squares_callao.dta") size(0.2) color(black) pattern(shortdash)) label(data("xy_dbase_ubicaciones.dta") xcoord(x_label) ycoord(y_label) by(lgroup) label(s) color(blue) size(*0.6 ..) pos(0 6) length(20)) point(data("xy_dbase_ubicaciones.dta") xcoord(x_anchor) ycoord(y_anchor) shape(x) ocolor(red) ) 



use "xydatabase.dta", clear
#delimit ;
spmap using "xy_coor_with_squares_callao.dta", id(_ID) ocolor(black) 
polygon(data("xycoor_titicaca.dta") osize(0.3) fcolor(blue) ocolor(blue))
line(data("connectors3")  by(lgroup) size(0.2) color(black) pattern(shortdash));
#delimit cr	



use "xydatabase.dta", clear
merge 1:1 AMBITO using "atributo.dta", assert(match) nogen
#delimit ;
spmap horas_dia using "xy_coor_with_squares_callao.dta", id(_ID) ocolor(none ..) 
polygon(data("xycoor_titicaca.dta") osize(0.3) fcolor(blue) ocolor(blue)) line(data("connectors2")  by(lgroup) size(0.2) color(black) pattern(shortdash))
fcolor(Reds) 
label(data("xy_dbase_ubicaciones.dta") xcoord(x_label) ycoord(y_label)
    by(lgroup) label(s) color(blue) size(*0.6 ..) pos(0 6) length(20)) ;
#delimit cr	



use "atributo.dta",clear 








