
*Hacer mapas en Stata*
*De: Andrés Talavera Cuya @atalaveracuya
 
clear all
global shapefile  "D:\ANDRES\Documentos\GitHub\Mapa\shapefile"
global dofile     "D:\ANDRES\Documentos\GitHub\Mapa\dofile"
global dataset    "D:\ANDRES\Documentos\GitHub\Mapa\dataset"
global graficos   "D:\ANDRES\Documentos\GitHub\Mapa\graficos"

do "${dofile}//1.-ImportShpStata.do"
do "${dofile}//2.-ProvdeLima.do"
do "${dofile}//3.-ProvinciasRegionLima.do"
do "${dofile}//4.-RegionLima.do"
do "${dofile}//5.-PeruSinLima.do"
do "${dofile}//6.-ProvConstCallao.do"
do "${dofile}//7.-PeruUnido.do"
do "${dofile}//8.-PeruUnido_xy.do"
do "${dofile}//9.-LagoTiticaca.do"
do "${dofile}//10.-Atributos.do"
do "${dofile}//11.-Ubicaciones.do"
do "${dofile}//12.-Poligonos.do"
do "${dofile}//13.-Conectores.do"
************


*Visualizando
cd "$dataset"
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
spmap using "xy_coor_with_squares.dta", id(_ID) ocolor(none ..) 
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
   

***REFERENCIAS:
/*
Pisati, M. (2007). spmap: Stata Module to Visualize Spatial Data. Version 1.2.0. Statistical Software Components S456812. Boston College Department of Economics. https://ideas.repec.org/c/boc/bocode/s456812.html .
Picard, R. (2017). geo2xy: Stata Module to Convert Latitude and Longitude to XY Using Map Projections. Version 1.0.1. https://econpapers.repec.org/ software/bocbocode/s457990.htm .

*