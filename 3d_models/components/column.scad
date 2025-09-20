include <../helper/bom.scad>
include <../helper/support.scad>
include <../helper/m_skrew.scad>
include <../helper/pillow_block.scad>
include <../helper/motor.scad>
include <../helper/motor_flange.scad>
include <../helper/bearing.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Z-Axis Base Plate, mounting the End Effector (e.g. a Mill Spindle) to the Linear Rails
*/

COLUMN_BASE_WIDTH = 101.0;
COLUMN_BASE_HEIGHT = 110.0;
COLUMN_BASE_THICK = 10.0;

COLUMN_BASE_DIST = 70.0;

SUPPORT_WALL_DIST = 74;
SUPPORT_WALL_THICK = 5;
SUPPORT_WALL_LEN = 42.5;
SUPPORT_CORNER = 3;

EFFECTOR_MOUNT_DIA = 43.0;
EFFECTOR_MOUNT_LEN = 22.0;
EFFECTOR_MOUNT_WALL_THICK = 10.0;
EFFECTOR_MOUNT_BASE_DIST = 40;

RAIL_MOUNT_HOLE_DIST = 65.86-5.9;
RAIL_MOUNT_HOLE_SHIFT = 30.5;
RAIL_MOUNT_HOLE_OFFSET = 9;

MOTOR_OFFSET = 13;

NOTHING = 0.05;
FITTING = 0.2;


module column_plate(){

    difference(){
        // Base Plate
        translate([-COLUMN_BASE_WIDTH/2,0])
            cube([COLUMN_BASE_WIDTH, COLUMN_BASE_THICK, COLUMN_BASE_HEIGHT]);

        // Linear Rail Mounting Drills
        for (shift_x=[-1,1])
            for (shift_y=[0,1,2])
                translate([shift_x*(COLUMN_BASE_WIDTH/2-RAIL_MOUNT_HOLE_OFFSET),
                           COLUMN_BASE_THICK+NOTHING,
                           RAIL_MOUNT_HOLE_SHIFT
                           +shift_y*RAIL_MOUNT_HOLE_DIST])
                    rotate([90,0,0])
                        union(){
                            m_skrew_shaft();
                            m_nut(fitting=FITTING);
                        }
    }

}


module column_lower(reinforcement=true){

    bom_item("COLUMN");

    column_plate();

    translate([0,COLUMN_BASE_THICK,0])
        pillow_block(thickness=EFFECTOR_MOUNT_LEN,
                     length=COLUMN_BASE_WIDTH,
                     center_dist=EFFECTOR_MOUNT_BASE_DIST,
                     diameter=EFFECTOR_MOUNT_DIA,
                     wall_thick=EFFECTOR_MOUNT_WALL_THICK,
                     gap=true);

    rotate([0,0,180])
        restricted_pillow_block(thickness=BEARING_LEN+5,
                                length=COLUMN_BASE_WIDTH-45,
                                center_dist=MOTOR_BLOCK_HEIGHT/2-MOTOR_OFFSET,
                                diameter=BEARING_DIA_OUTER,
                                wall_thick=EFFECTOR_MOUNT_WALL_THICK,
                                restrict_dia=5,
                                restrict_thick=4);

    translate([SUPPORT_WALL_DIST/2,COLUMN_BASE_THICK,EFFECTOR_MOUNT_LEN])
        rotate([0,-90,0])
            support(height=SUPPORT_WALL_LEN-COLUMN_BASE_THICK,
                    length=COLUMN_BASE_HEIGHT-EFFECTOR_MOUNT_LEN,
                    width=SUPPORT_WALL_DIST,
                    wall_thick=SUPPORT_WALL_THICK,
                    corner=SUPPORT_CORNER);

};


module column_upper(){

    translate([0,0,COLUMN_BASE_DIST+COLUMN_BASE_HEIGHT])
        column_plate();

    translate([0,0,COLUMN_BASE_DIST+COLUMN_BASE_HEIGHT*2-30])
        rotate([0,180,180])
            restricted_pillow_block(thickness=BEARING_LEN+5,
                                    length=COLUMN_BASE_WIDTH-45,
                                    center_dist=MOTOR_BLOCK_HEIGHT/2-MOTOR_OFFSET,
                                    diameter=BEARING_DIA_OUTER,
                                    wall_thick=EFFECTOR_MOUNT_WALL_THICK,
                                    restrict_dia=5,
                                    restrict_thick=4);

    translate([0,-MOTOR_FLANGE_WIDTH/2+MOTOR_OFFSET,220+COLUMN_BASE_DIST])
    rotate([180,0,0])
        motor_flange();

}


module column(){

    color([0.6,0.8,0.8]){
        column_lower();
        column_upper();
    }

}


column($fn=100);
