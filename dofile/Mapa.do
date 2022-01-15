
*Hacer mapas en Stata*
*De: Andrés Talavera Cuya @atalaveracuya
 
clear all
global shapefile  "D:\ANDRES\Documentos\GitHub\MapaPeruGUI\shapefile"
global dofile     "D:\ANDRES\Documentos\GitHub\MapaPeruGUI\dofile"
global dataset    "D:\ANDRES\Documentos\GitHub\MapaPeruGUI\dataset"
global graficos   "D:\ANDRES\Documentos\GitHub\MapaPeruGUI\graficos"

do "${dofile}//1.-ImportShpStata.do"
do "${dofile}//2.-ProvdeLima.do"
do "${dofile}//3.-ProvinciasRegionLima.do"
do "${dofile}//4.-RegionLima.do"
do "${dofile}//5.-PeruSinLima.do"
do "${dofile}//6.-ProvConstCallao.do"
do "${dofile}//7.-PeruUnido.do"
do "${dofile}//8.-LagoTiticaca.do"
do "${dofile}//9.-Atributos.do"
do "${dofile}//10.-Ubicaciones.do"
do "${dofile}//11.-Poligonos.do"
do "${dofile}//12.-Conectores.do"
************


*Visualizando

cd "$dataset"

** Mapas a nivel departamental: 

*Mapa básico hecho a partir de coordenadas proyectadas:
use "xydatabase.dta", clear
spmap using "xycoord.dta", id(_ID) ocolor(none ..) ///
polygon(data("xycoor_titicaca.dta") fcolor(blue)) ///
line(data("xycoord")  size(0.1) color(black) pattern(shortdash))	
graph export "${graficos}//map1.png", width(1000) replace


use "xydatabase.dta", clear
#delimit ;
spmap using "xycoord.dta", id(_ID) ocolor(none ..) 
polygon(data("xycoor_titicaca.dta") osize(0.3) fcolor(blue) ocolor(blue)) line(data("xycoord.dta") size(0.2) color(black) pattern(shortdash));
#delimit cr	
graph export "${graficos}//map1.png", width(1000) replace
   

*Mapa básico con nombres y porcentaje 

use "xydatabase.dta", clear
#delimit ;
spmap using "xycoord.dta", id(_ID) ocolor(none ..) 
polygon(data("xycoor_titicaca.dta") osize(0.3) fcolor(blue) ocolor(blue)) line(data("xycoord.dta") size(0.2) color(black) pattern(shortdash))
label(data("xy_dbase_ubicaciones.dta") xcoord(x_label) ycoord(y_label)
    by(lgroup) label(s) color(blue) size(*0.6 ..) pos(0 6) length(20)) 
    point(data("xy_dbase_ubicaciones.dta") xcoord(x_anchor) ycoord(y_anchor) shape(x) ocolor(red) ) ;
#delimit cr	
graph export "${graficos}//map2.png", width(1000) replace
   

*Mapa con polígonos adicionales 

use "xydatabase.dta", clear
#delimit ;
spmap using "xy_coor_with_squares.dta", id(_ID) ocolor(gs6) 
polygon(data("xycoor_titicaca.dta") osize(0.3) fcolor(blue) ocolor(blue)) line(data("xy_coor_with_squares.dta") size(0.2) color(black) pattern(shortdash))
label(data("xy_dbase_ubicaciones.dta") xcoord(x_label) ycoord(y_label)
    by(lgroup) label(s) color(blue) size(*0.6 ..) pos(0 6) length(20)) 
    point(data("xy_dbase_ubicaciones.dta") xcoord(x_anchor) ycoord(y_anchor) shape(x) ocolor(red) ) ;
#delimit cr	
graph export "${graficos}//map3.png", width(1000) replace
   
   
*Mapa de coropletas, agregando conectores 

use "xydatabase.dta", clear
merge 1:1 AMBITO using "atributo.dta", assert(match) nogen
#delimit ;
spmap pc using "xy_coor_with_squares.dta", id(_ID) ocolor(none ..) 
polygon(data("xycoor_titicaca.dta") osize(0.3) fcolor(blue) ocolor(blue)) line(data("connectors2")  by(lgroup) size(0.2) color(black) pattern(shortdash))
fcolor(Reds) 
label(data("xy_dbase_ubicaciones.dta") xcoord(x_label) ycoord(y_label)
    by(lgroup) label(s) color(blue) size(*0.6 ..) pos(0 6) length(20)) ;
#delimit cr	
graph export "${graficos}//map4.png", width(1000) replace
   
*Mapa con legendas ; **Adaptado de: Fahad Mirza 

use "xydatabase.dta", clear
merge 1:1 AMBITO using "atributo.dta", assert(match) nogen
#delimit ;
grmap pc using "xy_coor_with_squares.dta", id(_ID) ocolor(none ..) 
polygon(data("xycoor_titicaca.dta") osize(0.3) fcolor(blue) ocolor(blue)) 
	
    caption("Nota: Elaboración propia", size(*0.5) color(gs10))
    fcolor("230 250 250" "230 200 200" "230 150 150" "230 100 100")
    osize(medthin ..)
    legenda(on)
    legstyle(3)
    legend(ring(0) position(7))
    plotregion(icolor(white))
    graphregion(icolor(white))
    legtitle("Cambio porcentual" )
    clbreaks(-90 0 24.9 49.9 100)
    clmethod(custom)
    legend(label(2 "Menos de 0,0") label(3 "0,0 a 24,9")  label(4 "25,0 a 49,9")  label(5 "50 a más") margin(1 1 1 1))
line(data("connectors2")  by(lgroup) size(0.2) color(black) pattern(shortdash))
label(data("xy_dbase_ubicaciones.dta") xcoord(x_label) ycoord(y_label)
    by(lgroup) label(s) color(blue) size(*0.6 ..) pos(0 6) length(20)) ;
#delimit cr	
graph export "${graficos}//map5.png", width(1000) replace
  
  
**Mapa a nivel provincial:

*con legendas ; **Adaptado de: Fahad Mirza*** 

use "dbaseprov.dta", clear
merge 1:1 _ID using "atributo-provincias.dta", assert(match) nogen

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
 
 
**Mapa a nivel distrital: 

* Con legendas ; **Adaptado de: Fahad Mirza*** 

use "dbasedist.dta", clear
merge 1:1 _ID using "atributo-distritos.dta", assert(match) nogen


count if pc>=0.1 & pc<=9.9999
local leg0="`r(N)'" + " " + "distritos"

count if pc>=10.0 & pc<=19.9999
local leg1="`r(N)'" + " " + "distritos" 

count if pc>=20.0 & pc<=39.9999
local leg2="`r(N)'" + " " + "distritos"

count if pc>=40.0 & pc<=59.9999
local leg3="`r(N)'" + " " + "distritos"

sum pc  
count if pc>=60.0 & pc<=`r(max)'
local leg4="`r(N)'" + " " + "distritos"
sum pc
local fmt_max : display %4.1f `r(max)'

#delimit ;
grmap pc using "coordist.dta", id(_ID) ocolor(none ..) mosize(0.001)
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
graph export "${graficos}//map7.png", width(1000) replace
  
  
**Mapa a nivel manzanas - San Juan de Lurigancho -shapefile tomado de www.geogpsperu.com  Descarga de shapefile https://drive.google.com/file/d/1UfVZrMQ91rYv9f5zhu7Ip6y5kPKYuM1r/view

*Capa de manzana censal
 
use "dbasemzn-150132.dta", clear
describe

* Mapa mudo (sin información)
spmap using coormzn-150132.dta, id(_ID) fcolor(olive_teal) note("San Juan de Lurigancho, Lima")
graph export "${graficos}//map08.png", width(1000) replace
  
* Ejemplo para graficar sólo una zona censal 
keep if ZONA=="07000"
spmap using coormzn-150132.dta, id(_ID) fcolor(olive_teal) note("Zona Censal 07000 San Juan de Lurigancho , Lima")
graph export "${graficos}//map09.png", width(1000) replace
   
/* Ahora se necesita incorporar la información de "atributos" para generar gráficos: */

**************************
**límite distrital 
*para fines censales**
	*database
use dbasedist,clear
*gen UBIGEO=CCDD+CCPP+CCDI
keep if UBIGEO=="150132"

use coordist.dta,clear
keep if _ID==916
save coor-SJL,replace 
*************************


use "dbasemzn-150132.dta", clear
merge 1:1 _ID using "atributo-manzanas.dta", assert(match) nogen

sum pc  
count if pc>=0.1 & pc<=9.9999
local leg0="`r(N)'" + " " + "manzanas"

count if pc>=10.0 & pc<=19.9999
local leg1="`r(N)'" + " " + "manzanas" 

count if pc>=20.0 & pc<=39.9999
local leg2="`r(N)'" + " " + "manzanas"

count if pc>=40.0 & pc<=59.9999
local leg3="`r(N)'" + " " + "manzanas"

sum pc  
count if pc>=60.0 & pc<=`r(max)'
local leg4="`r(N)'" + " " + "manzanas"
sum pc
local fmt_max : display %4.1f `r(max)'

#delimit ;
grmap pc using "coormzn-150132.dta", id(_ID) ocolor(none ..) mosize(0.001)
    caption("Nota: Elaboración propia. Shapefile tomado de https://www.geogpsperu.com/", size(*0.5) color(gs10))
    fcolor("255 251 218" "255 236 147" "250 195 103" "234 96 24" "229 27 27")
    osize(0.01)
    legenda(on)
    legstyle(3)
    legend(ring(2) position(6))
    plotregion(icolor(white))
    graphregion(icolor(white))
    legtitle("Porcentaje" )
    clbreaks(0.1 9.9 19.9 39.9 59.9 `r(max)')
    clmethod(custom)
    legend(label(2 "0.1 - 9.9 (`leg0')") label(3 "10.0 - 19.9 (`leg1')")  label(4 "20.0 - 39.9 (`leg2')")  label(5 "40 - 59.9 (`leg3')") label(6 "60.0 - `fmt_max' (`leg4')") margin(1 1 1 1))
line(data("coor-SJL.dta") size(0.2) color(black));
#delimit cr	
graph export "${graficos}//map10.png", width(1000) replace



***REFERENCIAS:
/*
Pisati, M. (2007). spmap: Stata Module to Visualize Spatial Data. Version 1.2.0. Statistical Software Components S456812. Boston College Department of Economics. https://ideas.repec.org/c/boc/bocode/s456812.html .
Picard, R. (2017). geo2xy: Stata Module to Convert Latitude and Longitude to XY Using Map Projections. Version 1.0.1. https://econpapers.repec.org/ software/bocbocode/s457990.htm .

*