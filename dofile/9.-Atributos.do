*******************************
*Generar una base de atributos.
*******************************

*Para nivel departamental 

cd "$dataset"
use xydatabase.dta,clear 
gen pc = runiform(-20,90)
replace pc=round(pc, 0.1)
gen spc =string(pc) 

replace spc = subinstr(spc, ".", ",", .)
replace spc = subinstr(spc, "-", "", .)
replace spc=spc+",0" if ~strpos(spc,",")
replace spc ="0" + spc  if (pc>0 & pc<1)
replace spc ="0" + spc  if (pc<0 & pc>-1)

replace spc ="＋" + "" + spc  if pc>0
replace spc ="－" + "" + spc  if pc<0
replace spc = " " + spc + " "
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