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
use <components/column_connector.scad>


/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Overall CNC Machine Assembly Illustration
*/


REINFORCEMENT = true;
PORTAL_SPACING = 8;
BRIDGE_SPACING = 7;
COLUMN_SPACING = 10;

MOTOR_SPACE=200;

// Printing Area
SPACE_X = 600;
SPACE_Y = 600;
SPACE_Z = 300;
PORTAL_HEIGHT = 110; // TODO resolve by SPACE_Z based Formula

// Printer Head Position
POS_X = 250;
POS_Y = 200;
POS_Z = 100; // 110/300: [65-135]

// Counter Axis (Slider/Profile/Component) Dimensions
OFFSET_Y = 90;



module portal_assembly(){

    // frame
    for (rail=[0,1])
        translate([rail*(SPACE_X+80),SLOT_PROF_HEIGHT,0])
            rotate([90,0,180])
                NUT8_45x2(length=SPACE_Y-2*SLOT_PROF_HEIGHT,
                          inventorize=true);

    // main rails
    for (rail=[0,1])
        translate([-MOTOR_SPACE,rail*(SPACE_Y-SLOT_PROF_HEIGHT)]){
                rotate([90,0,90])
                        NUT8_45x2(length=SPACE_X+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE,
                                  inventorize=true);

                for (side=[-1,1])
                    translate([MOTOR_SPACE+(side==1?SPACE_X:0),
                               (side==1?SLOT_PROF_HEIGHT:0),
                               SLOT_PROF_WIDTH-20])
                        rotate([-side*90,90,0])
                            linear_slider(length=SPACE_X, pos=POS_X,
                                          invert=(side==1),
                                          spacing=PORTAL_SPACING){

                                if ((rail==0)&&(side==-1)){
                                    portal()
                                        children();
                                } else {
                                    portal();
                                }

                                if (REINFORCEMENT){
                                    translate([0,
                                               side*(BASE_WIDTH+PORTAL_SPACING)/2,
                                               0])
                                        color([0.6,0.6,0.4])
                                            wagon_connector(spacing=PORTAL_SPACING);

                                    translate([0,
                                               side*(BASE_WIDTH+PORTAL_SPACING),
                                               0])
                                        portal_reinforcement();
                                }
                            }

            };

    for (rail=[0,1])
        translate([-80,
                   MOTOR_FLANGE_WIDTH
                   -(MOTOR_FLANGE_WIDTH-SLOT_PROF_HEIGHT)/2
                   +rail*(SPACE_Y-SLOT_PROF_HEIGHT),
                   SLOT_PROF_WIDTH]){
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

        translate([POS_X+37,-SLIDER_HEIGHT,97])
            rotate([180,0,90])
                color([0.6,0.6,0.4])
                    nut_mount();

    }

}


module bridge_assembly(){

    NUT8_45x2(length=SPACE_Y+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE-100,
              inventorize=true);

    translate([SLOT_PROF_HEIGHT,
               2*SLOT_PROF_HEIGHT+SLOT_WIDTH,
               SPACE_Y+70])
        rotate([-90,0,-90]){
            motor();
            motor_mount(double_t_slot=true);
            for (y_shift=[70,SPACE_Y+20])
                translate([28.2,y_shift,0])
                    rotate([0,0,180])
                        bearing_mount(double_t_slot=true);
            }

    translate([SLOT_PROF_HEIGHT/2,SLOT_PROF_WIDTH,OFFSET_Y])
        rotate([90,0,180])
            linear_slider(length=SPACE_Y-130,
                          pos=POS_Y, spacing=BRIDGE_SPACING)
                for (y_shift=[0,-BASE_WIDTH-BRIDGE_SPACING])
                    translate([0,y_shift,0])
                        bridge(reinforcement=REINFORCEMENT);

    translate([SLOT_PROF_HEIGHT,20,OFFSET_Y])
        rotate([90,0,90])
            linear_slider(length=SPACE_Y-130,
                          pos=POS_Y, spacing=BRIDGE_SPACING)
                rotate([0,0,180]){
                    for (y_shift=[0,-BASE_WIDTH-BRIDGE_SPACING])
                        translate([0,-y_shift,0])
                            bridge_reinforcement();
                    translate([0,BASE_WIDTH/2+BRIDGE_SPACING/2,0])
                        color([0.6,0.6,0.4])
                            wagon_connector(spacing=BRIDGE_SPACING);
                };

}


module column_assembly(){
    
    for (y_shift=[0,BASE_WIDTH+BRIDGE_SPACING])
        translate([POS_X+2*SLIDER_HEIGHT
                   +SLOT_PROF_WIDTH+BASE_THICKNESS-2.5,
                   POS_Y-40+y_shift+100-2.5,
                   POS_Z])
            rotate([90,0,-90])
                linear_slider(length=SPACE_Z,
                              pos=-POS_Z+SPACE_Z-2*BASE_WIDTH,
                              spacing=COLUMN_SPACING);

    translate([POS_X+SLOT_PROF_WIDTH+2*SLIDER_HEIGHT+BASE_THICKNESS-2.5,
               POS_Y+101,
               100])
        rotate([0,0,-90])
            translate([2.5,-46+2.5,70])
                rotate([0,90,90])
                    column_connector();

    translate([POS_X+SLOT_PROF_WIDTH+2*SLIDER_HEIGHT+BASE_THICKNESS-2.5,
               POS_Y+101,
               POS_Z])
        rotate([0,0,-90])
            translate([2.5,0,0])
                column();

}


portal_assembly()
    bridge_assembly();
column_assembly();