include <../helper/bom.scad>
include <../helper/nut_mount_connector.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects two Linear Rail Support Wagons or Portals with a Thread Nut Holder
*/

PORTAL_DIST = 100.7;
PORTAL_THICK = 5.0;  // Clipped to fit printing area,  actually: 13.5;
MOUNT_WIDTH = 75;
MOUNT_HEIGHT = 10;
THREAD_ROD_DIA = 10.0;
TOLERANCE = 0.01;


module nut_mount(){

    bom_item("NUT_MOUNT");

    difference(){
        union(){
            translate([0,0,MOUNT_HEIGHT/2])
                cube([PORTAL_DIST, MOUNT_WIDTH, MOUNT_HEIGHT], center=true);
            translate([-PORTAL_THICK-PORTAL_DIST/2,0,0])
                rotate([0,-90,180])
                    nut_mount_connector(length=PORTAL_DIST+2*PORTAL_THICK,
                                        male=true);
        }
        for (y_shift=[-MOUNT_WIDTH/2+5, MOUNT_WIDTH/2-10])
            translate([0,y_shift,-TOLERANCE])
                rotate([0,0,90])
                    nut_mount_connector(length=MOUNT_HEIGHT+2*TOLERANCE);
    };

}


nut_mount($fn=120);
