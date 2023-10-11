*******************************
*Generar una base de atributos.
*******************************

*Para nivel departamental 

cd "$dataset"


use atributo.dta ,clear 

dir*dta 
use horas_agua.dta,clear 
gen  _ID=.
replace _ID=rDpto2
replace _ID=129 if rDpto2==15
replace _ID=130 if rDpto2==16 

forvalues i=16/25 {
local j= `i'+1
replace _ID=`i' if _ID==`j' 
}

merge 1:1 _ID using xydatabase.dta
drop _merge 
replace horas_dia=round(horas_dia)
gen spc =string(horas_dia) 

save atributo.dta,replace  


*Para nivel provincial 

use "dbaseprov.dta", clear
gen pc = runiform(0.1,80)
replace pc=round(pc, 0.1)
save atributo-provincias,replace  


*Para nivel distrital 

use "dbasedist.dta", clear
gen pc = runiform(0.1,80)
replace pc=round(pc, 0.1)
save atributo-distritos,replace 

*Para nivel de manzanas  
use "dbasemzn-150132.dta", clear
gen pc = runiform(0.1,80)
replace pc=round(pc, 0.1)
save atributo-manzanas,replace   