*************
 *Perú Unido
*************	
cd "$dataset"
*dbase
use _ID _X _Y NOMBDEP using perusinlimadbase.dta,clear 
append using databasereglima
append using dbaseprovlima
sort _ID, stable
save database,replace

*coord	
use _ID _X _Y using "coor_provlima.dta", clear
append using "regionlima_coor.dta"
append using "coor_perusinlima"
sort _ID, stable
save coord,replace 


**************
*Peru unido xy
**************
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