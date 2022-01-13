cd "$dataset"
	*database
*use dbase_titicaca.dta,clear 
*spmap using coor_titicaca.dta, id(id)

   *coord xy mercator
use coortiticaca.dta,clear 
geo2xy _Y _X , replace proj(mercator)
ret list
replace _Y = _Y / 1000
replace _X = _X / 1000
replace _X=_X + 637
save "xycoor_titicaca.dta",replace 	
***************