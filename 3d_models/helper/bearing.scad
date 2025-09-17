/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Ball Bearing Hull
*/

BEARING_DIA_OUTER = 22.0;
BEARING_DIA_INNER = 8.0;
BEARING_LEN = 7.0;
NOTHING = 0.01;

module bearing(){

    color("Orchid")
        difference(){
            cylinder(d=BEARING_DIA_OUTER,h=BEARING_LEN);
            translate([0,0,-NOTHING])
                cylinder(d=BEARING_DIA_INNER,h=BEARING_LEN+NOTHING*2);
        }

}


// Sample Usage
//bearing($fn=300);