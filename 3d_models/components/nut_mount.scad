$fn=120;

include <../helper/nut_mount_connector.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects two Linear Rail Support Wagons with a Thread Nut
*/

PORTAL_DIST = 99.5;
PORTAL_THICK = 13.5;
MOUNT_WIDTH = 75;
MOUNT_HEIGHT = 10;
THREAD_ROD_DIA = 10.0;
TOLERANCE = 0.01;



translate([-PORTAL_THICK,0,0])
    rotate([0,-90,180])
        nut_mount_connector(length=PORTAL_DIST+2*PORTAL_THICK, male=true);

translate([0,-MOUNT_WIDTH/2,0])
    cube([PORTAL_DIST, MOUNT_WIDTH, MOUNT_HEIGHT]);
