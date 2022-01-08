******************
*G: Peru unido xy
******************
cd "$dataset"
use database,clear 
replace AMBITO=NOMBDEP if AMBITO==""
replace AMBITO=NOMBPROV if _ID==129 

append using "coord.dta"
geo2xy _Y _X , replace proj(mercator)
* convert to km and save the database and coordinates
replace _Y = _Y / 1000
replace _X = _X / 1000 

preserve
keep if !mi(AMBITO) //elimina observaciones si es diferente de missing en la variable AMBITO
rename (_Y _X) (y_c x_c)
merge 1:1 _ID using "database.dta", assert(match) nogen 
sort _ID
save "xydatabase.dta", replace
restore
drop if !mi(AMBITO)
drop AMBITO
sort _ID, stable
save "xycoord", replace 