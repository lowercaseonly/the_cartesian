include <../helper/m_skrew.scad>

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

NOTHING = 0.01;
FITTING = 0.1;


module effector_mount(){
    
    difference(){
        hull(){
            linear_extrude(height=EFFECTOR_MOUNT_LEN)
                polygon([[-COLUMN_BASE_WIDTH/2, 0],
                         [-EFFECTOR_MOUNT_DIA/2-EFFECTOR_MOUNT_WALL_THICK,
                          EFFECTOR_MOUNT_BASE_DIST],
                         [+EFFECTOR_MOUNT_DIA/2+EFFECTOR_MOUNT_WALL_THICK,
                          EFFECTOR_MOUNT_BASE_DIST],
                         [COLUMN_BASE_WIDTH/2, 0]]);
            translate([0,EFFECTOR_MOUNT_BASE_DIST,0])
                cylinder(h=EFFECTOR_MOUNT_LEN,
                         d=EFFECTOR_MOUNT_DIA+2*EFFECTOR_MOUNT_WALL_THICK);
        }
        union(){
            translate([0,EFFECTOR_MOUNT_BASE_DIST,-NOTHING])
                cylinder(h=EFFECTOR_MOUNT_LEN+2*NOTHING,
                         d=EFFECTOR_MOUNT_DIA+FITTING);
            translate([0,EFFECTOR_MOUNT_BASE_DIST,-NOTHING])
                cube([0.2,40,40]);
            
        }
    }

}


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
        effector_mount();

};



column($fn=400);
