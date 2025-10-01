include <../helper/bom.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Threaded Rod Envelope
*/

THEADED_ROD_DIA_OUTER = 8.0;



module threaded_rod(length=100){

    bom_item("MOTOR_COUPLING", "length", length);

    color([0.4,0.4,0.8])
        cylinder(h=length, d=THEADED_ROD_DIA_OUTER);

}
