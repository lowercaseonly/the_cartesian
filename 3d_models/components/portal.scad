$fn=120;

use <../helper/base_plate.scad>
include <../helper/t_slot.scad>
include <../helper/m_skrew.scad>
include <../helper/connector_a.scad>
include <../helper/linear_wagon.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects Linear Rail Support Wagon to main CNC Portal Bridge T-Slot Profile
*/

TOLERANCE = 0.01;


M_SKREW_SINK = 7;
M_SKREW_DIST_X = 40.35-M_SKREW_SHAFT_DIA;
M_SKREW_DIST_Y = 36.66-M_SKREW_SHAFT_DIA;



// Spindle Connector
SPIND_CON_SQUARE_SIDE = 5;
SPIND_CON_DIST = 20;



TROUGH_WIDTH = 32;
TROUGH_CORNER = 2;









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


module NUT8_mount(){
    
    linear_extrude(height=SLOT_PROF_WIDTH)
        polygon([[0, 0],
                 [0, 20+BASE_THICKNESS],
                 [10, 20+BASE_THICKNESS],
                 [10+40,BASE_THICKNESS],
                 [10+40+0, BASE_THICKNESS],
                 [10+40+0,0]]);
}


module NUT8_mount_complete(){
    
    translate([110,-(SLOT_PROF_WIDTH-BASE_WIDTH)/2,0])
        difference(){
            rotate([0,0,-180])
                rotate([90,0,0])
                    NUT8_mount();
            translate([-2,0,-TOLERANCE])
                NUT8_45x2();
            for (y_shift=[false,true])
                union(){
                    translate([TROUGH_CORNER-62,
                               TROUGH_CORNER+(SLOT_PROF_WIDTH)/2+ (y_shift?3:-3-TROUGH_WIDTH),
                               TROUGH_CORNER+BASE_THICKNESS])
                        minkowski(){
                            cube([55-2*TROUGH_CORNER,
                                  TROUGH_WIDTH-2*TROUGH_CORNER,
                                  100-2*TROUGH_CORNER]);
                            sphere(r=TROUGH_CORNER);
                        };
                    translate([8,
                               (SLOT_PROF_WIDTH)/2+(SLOT_DIST+SLOT_WIDTH)/2*(y_shift?-1:1),
                               7.5+BASE_THICKNESS+2+TOLERANCE])
                        rotate([0,-90,0])
                            m_skrew();
                    }
        }
}


HGH20CA_plate();
bridge(); //color(c=[255,0,0])
NUT8_mount_complete();
