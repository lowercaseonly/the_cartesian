$fn=120;

include <../helper/t_slot.scad>
include <../helper/linear_wagon.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects Linear Rail Support Wagon to main CNC Portal Bridge T-Slot Profile
*/

TOLERANCE = 0.01;

// Spindle Connector
SPIND_CON_SQUARE_SIDE = 5;
SPIND_CON_DIST = 20;




module bridge(){
    
    translate([BASE_HEIGHT-BASE_CORNER,0,0])
        difference(){
            linear_extrude(height=BASE_THICKNESS)
                polygon([[0, 0],
                         [2, BASE_WIDTH/2], // Avoid Overlap with Base Skrew Holes
                         [0, BASE_WIDTH],
                         [18.5, SLOT_PROF_WIDTH-(SLOT_PROF_WIDTH-BASE_WIDTH)/2],
                         [18.5, -(SLOT_PROF_WIDTH-BASE_WIDTH)/2]]);
            for (shift=[-SPIND_CON_DIST,0,SPIND_CON_DIST])
                translate([10,
                           (BASE_WIDTH-SPIND_CON_SQUARE_SIDE)/2+shift,
                           -TOLERANCE])
                    cube([SPIND_CON_SQUARE_SIDE,SPIND_CON_SQUARE_SIDE,100]);
        }
}


HGH20CA_plate();
bridge();
translate([110,-(SLOT_PROF_WIDTH-BASE_WIDTH)/2,0])
    NUT8_mount_complete(thickness=BASE_THICKNESS);
