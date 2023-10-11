
******************************
******  Variable rDpto  ******
******************************

gen rDpto=real(substr(ubigeo,1,2))
gen rprov=(substr(ubigeo,1,4))
label var rDpto "Departamento"

label define rDpto /*
*/ 1 "Amazonas" 2 "Áncash" 3 "Apurímac" 4 "Arequipa" 5 "Ayacucho" 6 "Cajamarca" 7 "Prov Const del Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" /*
*/ 11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Lima" 16 "Loreto" 17 "Madre de Dios" 18 "Moquegua" 19 "Pasco" 20 "Piura" /* 
*/ 21 "Puno" 22 "San Martín" 23 "Tacna" 24 "Tumbes" 25 "Ucayali"

label values rDpto rDpto

*******************************
******  Variable rDpto2  ******
*******************************


gen LimMetro=.
replace LimMetro=1 if rDpto==7
replace LimMetro=1 if rprov=="1501"

gen rDpto2=rDpto if rDpto<16
replace rDpto2=16 if rDpto==15 & LimMetro!=1
replace rDpto2=rDpto+1 if rDpto>=16

label var rDpto2 "Departamento"

label define rDpto2 /*
*/ 1 "Amazonas" 2 "Áncash" 3 "Apurímac" 4 "Arequipa" 5 "Ayacucho" 6 "Cajamarca" 7 "Prov Const del Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huánuco" /*
*/ 11 "Ica" 12 "Junín" 13 "La Libertad" 14 "Lambayeque" 15 "Provincia de Lima" 16 "Lima Provincias" 17 "Loreto" 18 "Madre de Dios" 19 "Moquegua" 20 "Pasco" 21 "Piura" /* 
*/ 22 "Puno" 23 "San Martín" 24 "Tacna" 25 "Tumbes" 26 "Ucayali"

label values rDpto2 rDpto2
