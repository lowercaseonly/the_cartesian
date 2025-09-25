include <parameter.scad>

include <../helper/t_slot.scad>
include <../helper/linear_wagon.scad>
include <../helper/motor_flange.scad>
include <../helper/motor.scad>

use <../components/portal.scad>
use <../components/portal_reinforcement.scad>
use <../components/nut_mount.scad>
use <../components/wagon_connector.scad>
use <../components/motor_mount.scad>
use <../components/bearing_mount.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: X-Axis (Portal) Assembly
*/



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

portal_assembly();