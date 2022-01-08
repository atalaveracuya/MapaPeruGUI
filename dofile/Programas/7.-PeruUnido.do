*************
 *Perú Unido
*************	

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