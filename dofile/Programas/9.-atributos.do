*******************************
*Generar una base de atributos.
*******************************
use xydatabase.dta,clear 
gen pc = runiform(-20,90)
replace pc=round(pc, 0.1)
gen spc =string(pc) 

replace spc = subinstr(spc, ".", ",", .)
replace spc = subinstr(spc, "-", "", .)
replace spc=spc+",0" if ~strpos(spc,",")
replace spc ="0" + spc  if (pc>0 & pc<1)
replace spc ="0" + spc  if (pc<0 & pc>-1)

replace spc =char(43) + "" + spc  if pc>0
replace spc =char(45) + "" + spc  if pc<0
replace spc = " " + spc + " "
save atributo.dta,replace 
