$fn=100;

use <../helper/base_plate.scad>
include <../helper/t_slot.scad>


// Motor Flage
MOTOR_FLANGE_INNER_DIA = 38.1;
MOTOR_FLANGE_WIDTH = 56.0;
MOTOR_FLANGE_HEIGHT = 56.0;
MOTOR_FLANGE_CORNER = 3.25;
MOTOR_FLANGE_MOUNT_HOLE_DIA = 5.25;
MOTOR_FLANGE_MOUNT_HOLE_BORDER_DIST = 2.0;
MOTOR_FLANGE_THICKNESS = 5.0;

// Base Plate
BASE_THINKNESS = 5.0;


module motor_flange(){
    difference(){
        base_plate(MOTOR_FLANGE_HEIGHT,
                   MOTOR_FLANGE_WIDTH,
                   MOTOR_FLANGE_THICKNESS,
                   MOTOR_FLANGE_CORNER);
        union(){
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
                        cylinder(h=100,
                                 d=MOTOR_FLANGE_MOUNT_HOLE_DIA,
                                 center=true);
                    
        }
    }
};


translate([0,MOTOR_FLANGE_THICKNESS,0])
    rotate([90,0,0])
        motor_flange();
difference(){
    translate([48,0,-2])
        rotate([-90,90,0])
            NUT8_mount_complete(thickness=-NOTHING, double_size=false,
                                height=40, length=20);
    translate([MOTOR_FLANGE_WIDTH/2,0,MOTOR_FLANGE_HEIGHT/2])
        rotate([90,0,0])
            cylinder(h=100,d=MOTOR_FLANGE_INNER_DIA,center=true);
};
