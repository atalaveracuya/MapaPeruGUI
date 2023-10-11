

global url "D:\Dropbox\Mapas\Mapas_2020\ARCHIVO 2\Shapefile\"
global dataset "D:\ANDRES\Desktop\Mapa_prueba\"

cd "$url"
shp2dta using "GRANDES_CIUADES_2020.shp", ///
    data("${dataset}\dbasedist.dta") coor("${dataset}\coordist.dta") genid(id) gencentroids(c) replace


*Visualizando
cd "$dataset"

** Mapa por ingreso per capita a nivel distrital: 

use "dbasedist.dta", clear
keep if DISTRITO=="MALA"

/*** Bajo ***/
count if ESTRATO==1 
local leg1="`r(N)'" + " " + "mz."
display "`leg1'"

/*** Medio bajo ***/ 
count if ESTRATO==2
local leg2="`r(N)'" + " " + "mz." 
display "`leg2'"

/*** Medio ***/
count if ESTRATO==3
local leg3="`r(N)'" + " " + "mz."
display "`leg3'"

/*** Medio alto ***/
count if ESTRATO==4
local leg4="`r(N)'" + " " + "mz."
display "`leg4'"

/*** Alto ***/
count if ESTRATO==5
local leg5="`r(N)'" + " " + "mz."

    . spmap ESTRATO using "coordist.dta", id(id)          ///
        clnumber(3) fcolor("166 70 38" "255 179 62") ocolor(black ..)                       ///
        title(" ", size(*0.8))         ///
        subtitle(" " " ", size(*0.8))                       ///
        legstyle(3) ///
legend(label(1 "Bajo (`leg1')") label(2 "Medio bajo (`leg2')")  label(3 "Medio (`leg3')")  label(4 "Medio alto (`leg4')") label(5 "Alto (`leg5')") margin(1 1 1 1 1) ring(1) position(3))   


	