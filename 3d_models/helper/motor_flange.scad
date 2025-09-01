
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
MOTOR_FLANGE_THICKNESS = 7.0;

NOTHING = 0.01;



module motor_flange_base(){

    base_plate(MOTOR_FLANGE_HEIGHT,
               MOTOR_FLANGE_WIDTH,
               MOTOR_FLANGE_THICKNESS,
               MOTOR_FLANGE_CORNER);

}


module motor_flange_cutout(){

    translate([MOTOR_FLANGE_WIDTH/2,MOTOR_FLANGE_HEIGHT/2,0])
        cylinder(h=100,d=MOTOR_FLANGE_INNER_DIA,center=true);

    for (cx=[0,1])
        for (cy=[0,1])
            translate([cx*MOTOR_FLANGE_WIDTH
                       -(cx-0.5)*2*(MOTOR_FLANGE_MOUNT_HOLE_BORDER_DIST
                                    + MOTOR_FLANGE_MOUNT_HOLE_DIA/2),
                       cy*MOTOR_FLANGE_HEIGHT
                       -(cy-0.5)*2*(MOTOR_FLANGE_MOUNT_HOLE_BORDER_DIST
                                    + MOTOR_FLANGE_MOUNT_HOLE_DIA/2),
                       0])
                union(){
                    cylinder(h=100,
                             d=MOTOR_FLANGE_MOUNT_HOLE_DIA,
                             center=true);
                    translate([0,0,MOTOR_FLANGE_THICKNESS-M_NUT_HEIGHT+NOTHING])
                        m_nut();
                }

}


module motor_flange(){
    
    difference(){
        motor_flange_base();
        motor_flange_cutout();
    }

};
