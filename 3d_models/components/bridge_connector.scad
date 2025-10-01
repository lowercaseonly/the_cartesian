use <wagon_connector.scad>

include <../shells/threaded_nut.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects the Bridge's Linear Rail Wagons with Bridge's Thread Nut
*/

BRIDGE_SPACING = 7;
BRIDGE_CON_OVERHANG = 50;
BRIDGE_CON_NUT_SHIFT_X = 39.87;
BRIDGE_CON_NUT_SHIFT_Z = -1.87;

NOTHING = 0.01;



module bridge_connector(){

    difference(){
        color([0.8,0.6,0.6]){
            wagon_connector(spacing=BRIDGE_SPACING,
                            attachment="BRIDGE",
                            overhang=BRIDGE_CON_OVERHANG);
            
            translate([22,-BRIDGE_SPACING/2,-16.5])
                cube([BRIDGE_CON_OVERHANG,BRIDGE_SPACING,30]);
        }
        translate([BRIDGE_CON_NUT_SHIFT_X,0,BRIDGE_CON_NUT_SHIFT_Z])
            rotate([90,0,0]){
                cylinder(h=THREAD_NUT_LEN_OUTER+NOTHING,
                         d=THREAD_NUT_DIA_OUTER);
                translate([0,0,-THREAD_NUT_LEN_OUTER-NOTHING])
                    cylinder(h=THREAD_NUT_LEN_TOTAL,
                             d=THREAD_NUT_DIA_INNER);
            }
    }

    translate([BRIDGE_CON_NUT_SHIFT_X,0,BRIDGE_CON_NUT_SHIFT_Z])
        rotate([90,0,0])
            children();

}


bridge_connector($fn=100);
//    thread_nut();