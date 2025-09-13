include <../helper/m_skrew.scad>
include <../helper/pillow_block.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Z-Axis Base Plate, mounting the End Effector (e.g. a Mill Spindle) to the Linear Rails
*/

COLUMN_BASE_WIDTH = 101.0;
COLUMN_BASE_HEIGHT = 110.0;
COLUMN_BASE_THICK = 10.0;

EFFECTOR_MOUNT_DIA = 43.0;
EFFECTOR_MOUNT_LEN = 22.0;
EFFECTOR_MOUNT_WALL_THICK = 10.0;
EFFECTOR_MOUNT_BASE_DIST = 40;

RAIL_MOUNT_HOLE_DIST = 65.86-5.9;
RAIL_MOUNT_HOLE_SHIFT = 26.0;
RAIL_MOUNT_HOLE_OFFSET = 7.1;

NOTHING = 0.05;
FITTING = 0.1;


module column_plate(){

    difference(){
        // Base Plate
        cube([COLUMN_BASE_WIDTH, COLUMN_BASE_THICK, COLUMN_BASE_HEIGHT]);

        // Linear Rail Mounting Drills
        for (left=[0,1])
            for (shift_y=[0,1,2])
                translate([left?RAIL_MOUNT_HOLE_OFFSET:
                           COLUMN_BASE_WIDTH-RAIL_MOUNT_HOLE_OFFSET,
                           COLUMN_BASE_THICK+NOTHING,
                           RAIL_MOUNT_HOLE_SHIFT
                           +shift_y*RAIL_MOUNT_HOLE_DIST])
                    rotate([90,0,0])
                        union(){
                            m_skrew_shaft();
                            m_nut();
                        }
    }

}


module column(reinforcement=true){

    column_plate();
    translate([COLUMN_BASE_WIDTH/2,COLUMN_BASE_THICK,0])
        pillow_block(thickness=EFFECTOR_MOUNT_LEN,
                     length=COLUMN_BASE_WIDTH,
                     center_dist=EFFECTOR_MOUNT_BASE_DIST,
                     diameter=EFFECTOR_MOUNT_DIA,
                     wall_thick=EFFECTOR_MOUNT_WALL_THICK,
                     gap=false);

};


column($fn=400);
