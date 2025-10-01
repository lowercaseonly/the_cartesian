include <../helper/bom.scad>
include <../helper/nut_mount_connector.scad>
include <../helper/pillow_block.scad>

include <../shells/threaded_nut.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Mount for the actual 
*/

MOUNT_HEIGHT = 9;
THREAD_NUT_BLOCK_WIDTH = 60;
THREAD_NUT_WALL_THICK = 6;
THREAD_NUT_PLAIN_DIST = 2.33;



module thread_nut_mount(){

    bom_item("THREAD_NUT_MOUNT");

    translate([0,0,-MOUNT_HEIGHT])
        rotate([0,0,-90])
            nut_mount_connector(length=MOUNT_HEIGHT, male=true);

    rotate([90,0,0])
        restricted_pillow_block(thickness=THREAD_NUT_LEN_TOTAL,
                                length=THREAD_NUT_BLOCK_WIDTH,
                                center_dist=THREAD_NUT_DIA_OUTER/2
                                            +THREAD_NUT_PLAIN_DIST,
                                diameter=THREAD_NUT_DIA_OUTER,
                                wall_thick=THREAD_NUT_WALL_THICK,
                                restrict_dia=THREAD_NUT_DIA_OUTER-
                                             THREAD_NUT_DIA_INNER,
                                restrict_thick=THREAD_NUT_LEN_TOTAL-
                                               THREAD_NUT_LEN_OUTER);

    translate([0,-15,13.4])
        rotate([-90,0,0])
            children();
}

thread_nut_mount($fn=120);
//    thread_nut($fn=120);
