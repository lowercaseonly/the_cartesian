$fn=20;

include <helper/t_slot.scad>
include <helper/linear_wagon.scad>
use <components/portal.scad>
use <components/bridge.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Overall CNC Machine Assembly Illustration
*/


SPACE_Y = 500;
SPACE_X = 500;
PORTAL_HEIGHT = 110;

POS_X = 100;
POS_Y = 200;

// frame
for (rail=[0,1])
    color([0.8,0.8,0.8])
        translate([0,rail*(SPACE_Y-SLOT_PROF_HEIGHT),-SLOT_PROF_HEIGHT])
            rotate([90,0,90])
                NUT8_45x2(length=SPACE_X+2*SLOT_MOUNT_HEIGHT);

translate([BASE_WIDTH,0,0])
    rotate([90,270,0])
        portal();

translate([0,SPACE_Y,0])
    rotate([90,270,180])
        portal();




color([0.8,0.8,0.8])
    translate([-SLOT_PROF_CORNER,-SLOT_MOUNT_HEIGHT,PORTAL_HEIGHT])
        rotate([270,270,0])
            NUT8_45x2(length=SPACE_Y+2*SLOT_MOUNT_HEIGHT);

translate([SLOT_PROF_WIDTH,POS_Y,PORTAL_HEIGHT])
    rotate([0,270,180])
        bridge();
