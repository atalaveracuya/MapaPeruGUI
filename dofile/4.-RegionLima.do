*********************
*Region lima 
*********************

*Primero uso mergepoly para crear un shapefile de los
* límites de toda la region lima a partir del shapefile de las provincias
*de lima.
* Para instalar mergepoly , escriba en la ventana de comandos de Stata:

ssc install mergepoly

cd "$dataset"
use "dbaseprovregionlima", clear
mergepoly _ID using "coor_provregionlima", coord("regionlima_coor.dta") replace

*database
save databasereglima,replace 

use databasereglima,clear 
replace _ID=130 if _ID==1
gen str12 AMBITO="REGION LIMA"
sort _ID, stable
save,replace 

*coordenadas 
use regionlima_coor.dta,clear
replace _ID=130 if _ID==1
sort _ID, stable
save regionlima_coor.dta,replace 

*use databasereglima,clear 
*spmap using regionlima_coor.dta, id(_ID)
