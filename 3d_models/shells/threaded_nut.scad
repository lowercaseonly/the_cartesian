include <../helper/bom.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Threaded Nut Envelope
*/

THREAD_NUT_DIA_OUTER = 22.0;
THREAD_NUT_DIA_INNER = 10.20;
THREAD_NUT_LEN_OUTER = 3.5;
THREAD_NUT_LEN_INNER = 10.0;
THREAD_NUT_LEN_TOTAL = 15.0;



module thread_nut(){

    bom_item("THREADED_NUT");

    color([0.3,0.6,0.3]){
        cylinder(h=THREAD_NUT_LEN_OUTER, d=THREAD_NUT_DIA_OUTER);
        translate([0,0,-THREAD_NUT_LEN_OUTER])
            cylinder(h=THREAD_NUT_LEN_TOTAL, d=THREAD_NUT_DIA_INNER);
    }

}


// Sample Usage
//thread_nut();