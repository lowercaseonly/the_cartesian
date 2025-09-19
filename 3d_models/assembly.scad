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

// Printing Area
SPACE_Y = 600;
SPACE_X = 600;
SPACE_Z = 300;
PORTAL_HEIGHT = 110; // TODO resolve by SPACE_Z based Formula

// Printer Head Position
POS_X = 250;
POS_Y = 200;
POS_Z = 100;

// Counter Axis (Slider/Profile/Component) Dimensions
OFFSET_Y = 90;



// frame
for (rail=[0,1])
    translate([rail*(SPACE_X+80),SLOT_PROF_HEIGHT,0])
        rotate([90,0,180])
            NUT8_45x2(length=SPACE_Y-2*SLOT_PROF_HEIGHT,
                      inventorize=true);

// portal
for (rail=[0,1])
    translate([-MOTOR_SPACE,rail*(SPACE_Y-SLOT_PROF_HEIGHT)])
        union(){
            rotate([90,0,90])
                    NUT8_45x2(length=SPACE_X+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE,
                              inventorize=true);

            translate([MOTOR_SPACE,0,SLOT_PROF_WIDTH-20])
                rotate([90,90,0])
                    linear_slider(length=SPACE_X, pos=POS_X)
                        portal();

            translate([SPACE_X+MOTOR_SPACE,SLOT_PROF_HEIGHT,SLOT_PROF_WIDTH-20])
                rotate([-90,90,0])
                    linear_slider(length=SPACE_X, pos=SPACE_X-POS_X-BASE_WIDTH)
                        portal();

        };

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
               SLOT_PROF_HEIGHT+20])
        rotate([90,270,0])
            color([0.6,0.6,0.4])
                wagon_connector(spacing=10);

    translate([POS_X+BASE_WIDTH+PORTAL_REINFORCEMENT_SPACING-10,
               SPACE_Y+SLIDER_HEIGHT,
               SLOT_PROF_HEIGHT+19])
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
                       SPACE_Y+70])
                rotate([-90,0,-90])
                    union(){
                        motor();
                        motor_mount(double_t_slot=true);
                        for (y_shift=[70,SPACE_Y+20])
                            translate([28.2,y_shift,0])
                                rotate([0,0,180])
                                    bearing_mount(double_t_slot=true);
                    }

            translate([SLOT_PROF_HEIGHT/2,SLOT_PROF_WIDTH,OFFSET_Y])
                rotate([90,0,180])
                    linear_slider(length=SPACE_Y-130, pos=POS_Y)
                        bridge(reinforcement=REINFORCEMENT);

            translate([SLOT_PROF_HEIGHT,20,OFFSET_Y])
                rotate([90,0,90])
                    linear_slider(length=SPACE_Y-130, pos=POS_Y)
                        rotate([0,0,180])
                        bridge_reinforcement();


        };


//column
for (y_shift=[5,BASE_WIDTH+15])
    translate([POS_X+2*SLIDER_HEIGHT
               +SLOT_PROF_WIDTH+BASE_THICKNESS,
               POS_Y-40+y_shift+2.5,
               POS_Z])
        rotate([90,0,-90])
            linear_slider(length=SPACE_Z, pos=-POS_Z+SPACE_Z-2*BASE_WIDTH);

translate([SLOT_PROF_WIDTH+POS_X+2*SLIDER_HEIGHT+BASE_THICKNESS,POS_Y+15,POS_Z])
    rotate([0,0,-90])
        color([0.6,0.8,0.8])
            column();
