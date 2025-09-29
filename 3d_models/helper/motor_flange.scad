
use <../helper/base_plate.scad>
include <../helper/m_skrew.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Flange for Mounting a NEMA 23 Stepper Motor
*/

MOTOR_FLANGE_INNER_DIA = 38.1;
MOTOR_FLANGE_WIDTH = 56.0;
MOTOR_FLANGE_HEIGHT = 56.0;
MOTOR_FLANGE_CORNER = 3.25;
MOTOR_FLANGE_MOUNT_HOLE_DIA = 5.25;
MOTOR_FLANGE_MOUNT_HOLE_BORDER_DIST = 2.0;
MOTOR_FLANGE_THICKNESS = 8.0;
MOTOR_FLANGE_SCREW_SINK = 3.78;
MOTOR_FLANGE_CUTOUT_LEN_INNER = 16;
MOTOR_FLANGE_CUTOUT_LEN_HOLE = 10;

NOTHING = 0.01;



module motor_flange_base(){

    base_plate(MOTOR_FLANGE_HEIGHT,
               MOTOR_FLANGE_WIDTH,
               MOTOR_FLANGE_THICKNESS,
               MOTOR_FLANGE_CORNER);

}


module motor_flange_cutout(){

    // Central Hole
    cylinder(h=MOTOR_FLANGE_CUTOUT_LEN_INNER,
             d=MOTOR_FLANGE_INNER_DIA,center=true);

    // Central Hole (Continuation in Motor Shaft Direction)
    translate([0,0,MOTOR_FLANGE_CUTOUT_LEN_INNER/2-NOTHING])
        cylinder(h=MOTOR_FLANGE_CUTOUT_LEN_INNER*2,
                 d1=MOTOR_FLANGE_INNER_DIA,
                 d2=0);

    // Cutouts for Mounting Screws
    for (cx=[0,1])
        for (cy=[0,1])
            translate([(cx-0.5)*MOTOR_FLANGE_WIDTH
                       -(cx-0.5)*2*(MOTOR_FLANGE_MOUNT_HOLE_BORDER_DIST
                                    + MOTOR_FLANGE_MOUNT_HOLE_DIA/2),
                       (cy-0.5)*MOTOR_FLANGE_HEIGHT
                       -(cy-0.5)*2*(MOTOR_FLANGE_MOUNT_HOLE_BORDER_DIST
                                    + MOTOR_FLANGE_MOUNT_HOLE_DIA/2),
                       0]){
                cylinder(h=MOTOR_FLANGE_CUTOUT_LEN_HOLE,
                         d=MOTOR_FLANGE_MOUNT_HOLE_DIA,
                         center=true);
                rotate([0,0,45+90*((cx==1&&cy==1)?2:cx-cy)])
                    translate([0,0,MOTOR_FLANGE_THICKNESS-
                                   MOTOR_FLANGE_SCREW_SINK])
                    m_nut(elongate=true);
            }

}


module motor_flange(){
    
    difference(){
        motor_flange_base();
        motor_flange_cutout();
    }

};
