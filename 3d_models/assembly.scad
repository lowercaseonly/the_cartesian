$fn=20;

include <helper/t_slot.scad>
include <helper/linear_wagon.scad>
include <helper/motor_flange.scad>

use <components/portal.scad>
use <components/bridge.scad>
use <components/motor_mount.scad>


/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Overall CNC Machine Assembly Illustration
*/


MOTOR_SPACE=150;

SPACE_Y = 500;
SPACE_X = 500;
PORTAL_HEIGHT = 110;

POS_X = 250;
POS_Y = 200;

// frame
for (rail=[0,1])
    color([0.8,0.8,0.8])
        translate([-MOTOR_SPACE,rail*(SPACE_Y-SLOT_PROF_HEIGHT)])
            rotate([90,0,90])
                NUT8_45x2(length=SPACE_X+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE);

for (rail=[0,1])
    color([0.8,0.8,0.8])
        translate([rail*(SPACE_X+80),SLOT_PROF_HEIGHT,0])
            rotate([90,0,180])
                NUT8_45x2(length=SPACE_Y-2*SLOT_PROF_HEIGHT);


for (rail=[0,1])
    translate([0,MOTOR_FLANGE_WIDTH-(MOTOR_FLANGE_WIDTH-SLOT_PROF_HEIGHT)/2+rail*(SPACE_Y-SLOT_PROF_HEIGHT),SLOT_PROF_WIDTH])
        rotate([0,0,-90])
            motor_mount();


translate([BASE_WIDTH+POS_X,0,SLOT_PROF_HEIGHT])
    rotate([90,270,0])
        portal();

translate([POS_X,SPACE_Y,SLOT_PROF_HEIGHT])
    rotate([90,270,180])
        portal();


color([0.8,0.8,0.8])
    translate([-SLOT_PROF_CORNER+POS_X,-SLOT_MOUNT_HEIGHT,PORTAL_HEIGHT+SLOT_PROF_HEIGHT])
        rotate([270,270,0])
            NUT8_45x2(length=SPACE_Y+2*SLOT_MOUNT_HEIGHT);

translate([SLOT_PROF_WIDTH+POS_X,POS_Y,PORTAL_HEIGHT+SLOT_PROF_HEIGHT])
    rotate([0,270,180])
        bridge();
