
*Hacer mapas en Stata*
*De: Andrés Talavera Cuya @atalaveracuya
 *12/01/2022 
clear all
global shapefile  "D:\ANDRES\Documentos\GitHub\MapaPeruGUI\shapefile"
global dofile     "D:\ANDRES\Documentos\GitHub\MapaPeruGUI\dofile"
global dataset    "D:\ANDRES\Documentos\GitHub\MapaPeruGUI\dataset"
global graficos   "D:\ANDRES\Documentos\GitHub\MapaPeruGUI\graficos"

do "${dofile}//1.-ImportShpStata.do"
************

graph set window fontface "Arial Narrow"

cd "$dataset"
 
foreach x in dep prov dist titicaca{ 
use dbase`x',clear 
rename id _ID 
save,replace
}

****Mapa con legendas ; **Adaptado de: Fahad Mirza*** 
use "dbaseprov.dta", clear
gen pc = runiform(0.1,80)
replace pc=round(pc, 0.1)
count if pc>=0.1 & pc<=9.9999
local leg0="`r(N)'" + " " + "provincias"

count if pc>=10.0 & pc<=19.9999
local leg1="`r(N)'" + " " + "provincias" 

count if pc>=20.0 & pc<=39.9999
local leg2="`r(N)'" + " " + "provincias"

count if pc>=40.0 & pc<=59.9999
local leg3="`r(N)'" + " " + "provincias"

sum pc  
count if pc>=60.0 & pc<=`r(max)'
local leg4="`r(N)'" + " " + "provincias"
sum pc
local fmt_max : display %4.1f `r(max)'

#delimit ;
grmap pc using "coorprov.dta", id(_ID) ocolor(none ..) mosize(0.001)
polygon(data("coortiticaca.dta") osize(0.3) fcolor(blue) ocolor(blue)) 
    caption("Nota: Elaboración propia", size(*0.5) color(gs10))
    fcolor("255 251 218" "255 236 147" "250 195 103" "234 96 24" "229 27 27")
    osize(0.01)
    legenda(on)
    legstyle(3)
    legend(ring(0) position(7))
    plotregion(icolor(white))
    graphregion(icolor(white))
    legtitle("Porcentaje" )
    clbreaks(0.1 9.9 19.9 39.9 59.9 `r(max)')
    clmethod(custom)
    legend(label(2 "0.1 - 9.9 (`leg0')") label(3 "10.0 - 19.9 (`leg1')")  label(4 "20.0 - 39.9 (`leg2')")  label(5 "40 - 59.9 (`leg3')") label(6 "60.0 - `fmt_max' (`leg4')") margin(1 1 1 1))
label(data("dbasedep.dta") xcoord(x_c) ycoord(y_c) by(_ID) label(NOMBDEP) color(black) size(*0.6 ..) pos(0 6) length(25))
line(data("coordep.dta") size(0.2) color(black));
#delimit cr	
graph export "${graficos}//map6.png", width(1000) replace
