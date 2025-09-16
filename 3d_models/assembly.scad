$fn=20;

include <helper/t_slot.scad>
include <helper/linear_wagon.scad>
include <helper/motor_flange.scad>
include <helper/motor.scad>

use <components/portal.scad>
use <components/portal_reinforcement.scad>
use <components/nut_mount.scad>
use <components/wagon_connector.scad>
use <components/bridge.scad>
use <components/bridge_reinforcement.scad>
use <components/motor_mount.scad>
use <components/bearing_mount.scad>
use <components/column.scad>


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
        union(){
            rotate([90,0,90])
                    NUT8_45x2(length=SPACE_X+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE,
                              inventorize=true);

            translate([MOTOR_SPACE,0,SLOT_PROF_WIDTH-20])
                rotate([90,90,0])
                    linear_slider(length=SPACE_X, pos=POS_X);

            translate([SPACE_X+MOTOR_SPACE,SLOT_PROF_HEIGHT,SLOT_PROF_WIDTH-20])
                rotate([-90,90,0])
                    linear_slider(length=SPACE_X, pos=SPACE_X-POS_X-BASE_WIDTH);

        };

for (rail=[0,1])
    translate([rail*(SPACE_X+80),SLOT_PROF_HEIGHT,0])
        rotate([90,0,180])
            NUT8_45x2(length=SPACE_Y-2*SLOT_PROF_HEIGHT,
                      inventorize=true);


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


translate([BASE_WIDTH+POS_X,-SLIDER_HEIGHT,SLOT_PROF_HEIGHT])
    rotate([90,270,0])
        portal();

translate([POS_X,SPACE_Y+SLIDER_HEIGHT,SLOT_PROF_HEIGHT])
    rotate([90,270,180])
        portal();

if (REINFORCEMENT){
    translate([BASE_WIDTH+POS_X+BASE_WIDTH+PORTAL_REINFORCEMENT_SPACING,
               -SLIDER_HEIGHT,SLOT_PROF_HEIGHT])
        rotate([90,270,0])
            portal_reinforcement();

    translate([POS_X+BASE_WIDTH+PORTAL_REINFORCEMENT_SPACING,
               SPACE_Y+SLIDER_HEIGHT,SLOT_PROF_HEIGHT])
        rotate([90,270,180])
            portal_reinforcement();

    translate([POS_X+37,-SLIDER_HEIGHT,97])
        rotate([180,0,90])
            color([0.6,0.6,0.4])
                nut_mount();

    translate([POS_X+BASE_WIDTH+PORTAL_REINFORCEMENT_SPACING,
               -SLIDER_HEIGHT,
               SLOT_PROF_HEIGHT+22])
        rotate([90,270,0])
            color([0.6,0.6,0.4])
                wagon_connector(spacing=10);

    translate([POS_X+BASE_WIDTH+PORTAL_REINFORCEMENT_SPACING-10,
               SPACE_Y+SLIDER_HEIGHT,
               SLOT_PROF_HEIGHT+22])
        rotate([90,270,180])
            color([0.6,0.6,0.4])
                wagon_connector(spacing=10);

}


//bridge
translate([-SLOT_PROF_CORNER+POS_X,
           -SLOT_MOUNT_HEIGHT-SLIDER_HEIGHT,
           PORTAL_HEIGHT+SLOT_PROF_HEIGHT])
    rotate([270,270,0])
        union(){
            NUT8_45x2(length=SPACE_Y+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE-100,
                      inventorize=true);
            translate([SLOT_PROF_HEIGHT,
                       2*SLOT_PROF_HEIGHT+SLOT_WIDTH,
                       SPACE_Y+50])
                rotate([-90,0,-90])
                    union(){
                        motor();
                        motor_mount(double_t_slot=true);
                    }

            translate([SLOT_PROF_HEIGHT/2,SLOT_PROF_WIDTH,0])
                rotate([90,0,180])
                    linear_slider(length=SPACE_Y, pos=POS_Y);

            translate([SLOT_PROF_HEIGHT,20,0])
                rotate([90,0,90])
                    linear_slider(length=SPACE_Y, pos=POS_Y);



        };

translate([SLOT_PROF_WIDTH+POS_X+SLIDER_HEIGHT,POS_Y,PORTAL_HEIGHT+SLOT_PROF_HEIGHT])
        union(){
            rotate([0,270,180])
                bridge(reinforcement=REINFORCEMENT);
            if (REINFORCEMENT)
                translate([-113,-75,70.5])
                    bridge_reinforcement();
        }


//column
translate([SLOT_PROF_WIDTH+POS_X+SLIDER_HEIGHT+BASE_THICKNESS,POS_Y+15,PORTAL_HEIGHT+SLOT_PROF_HEIGHT])
    rotate([0,0,-90])
        color([0.6,0.8,0.8])
            column();
