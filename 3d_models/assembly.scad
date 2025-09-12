$fn=20;

include <helper/t_slot.scad>
include <helper/linear_wagon.scad>
include <helper/motor_flange.scad>
include <helper/motor.scad>

use <components/portal.scad>
use <components/portal_reinforcement.scad>
use <components/bridge.scad>
use <components/bridge_reinforcement.scad>
use <components/motor_mount.scad>
use <components/bearing_mount.scad>


/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Overall CNC Machine Assembly Illustration
*/


REINFORCEMENT = true;
PORTAL_REINFORCEMENT_SPACING = 10;

MOTOR_SPACE=200;

SPACE_Y = 600;
SPACE_X = 600;
PORTAL_HEIGHT = 110;

POS_X = 250;
POS_Y = 200;

// frame
for (rail=[0,1])
    translate([-MOTOR_SPACE,rail*(SPACE_Y-SLOT_PROF_HEIGHT)])
        rotate([90,0,90])
            NUT8_45x2(length=SPACE_X+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE);

for (rail=[0,1])
    translate([rail*(SPACE_X+80),SLOT_PROF_HEIGHT,0])
        rotate([90,0,180])
            NUT8_45x2(length=SPACE_Y-2*SLOT_PROF_HEIGHT);


for (rail=[0,1])
    translate([-80,MOTOR_FLANGE_WIDTH-(MOTOR_FLANGE_WIDTH-SLOT_PROF_HEIGHT)/2+rail*(SPACE_Y-SLOT_PROF_HEIGHT),SLOT_PROF_WIDTH])
        union(){
            rotate([0,0,-90])
                motor_mount();
            rotate([0,0,-90])
                motor();
            for (x_shift=[60,SPACE_X+100])
            translate([x_shift,-28,0])
                rotate([0,0,-90])
                    bearing_mount();
            };


translate([BASE_WIDTH+POS_X,0,SLOT_PROF_HEIGHT])
    rotate([90,270,0])
        portal();

translate([POS_X,SPACE_Y,SLOT_PROF_HEIGHT])
    rotate([90,270,180])
        portal();

if (REINFORCEMENT){
    translate([BASE_WIDTH+POS_X+BASE_WIDTH+PORTAL_REINFORCEMENT_SPACING,0,SLOT_PROF_HEIGHT])
        rotate([90,270,0])
            portal_reinforcement();

    translate([POS_X+BASE_WIDTH+PORTAL_REINFORCEMENT_SPACING,SPACE_Y,SLOT_PROF_HEIGHT])
        rotate([90,270,180])
            portal_reinforcement();
}

//bridge
translate([-SLOT_PROF_CORNER+POS_X,-SLOT_MOUNT_HEIGHT,PORTAL_HEIGHT+SLOT_PROF_HEIGHT])
    rotate([270,270,0])
        NUT8_45x2(length=SPACE_Y+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE-100);


translate([SLOT_PROF_WIDTH+POS_X,POS_Y,PORTAL_HEIGHT+SLOT_PROF_HEIGHT])
        union(){
            rotate([0,270,180])
                bridge(reinforcement=REINFORCEMENT);
            if (REINFORCEMENT)
                translate([-113,-75,70.5])
                    bridge_reinforcement();
        }

