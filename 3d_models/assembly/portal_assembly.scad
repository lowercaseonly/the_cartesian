include <parameter.scad>

include <../helper/linear_wagon.scad>
include <../helper/t_slot.scad>

include <../shells/motor.scad>
include <../shells/threaded_rod.scad>
include <../shells/t_slot.scad>

use <../components/portal.scad>
use <../components/portal_reinforcement.scad>
use <../components/nut_mount.scad>
use <../components/thread_nut_mount.scad>
use <../components/wagon_connector.scad>
use <../components/motor_mount.scad>
use <../components/motor_coupling.scad>
use <../components/bearing_mount.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: X-Axis (Portal) Assembly
*/



module portal_rail(){

    NUT8_45x2(length=SPACE_X+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE,
              inventorize=true,
              child_slots=[3,3]){
        translate([0,115,0])
            motor_mount()
                motor()
                    motor_coupling()
                        threaded_rod(length=SPACE_X);
        for (shift=[MOTOR_SPACE,MOTOR_SPACE+SPACE_X])
            translate([0,shift,0])
                bearing_mount();
    }

}


module portal_assembly(){

    // frame
    for (rail=[0,1])
        translate([rail*(SPACE_X+80),SLOT_PROF_HEIGHT,0])
            rotate([90,0,180])
                NUT8_45x2(length=SPACE_Y-2*SLOT_PROF_HEIGHT,
                          inventorize=true);

    // main rails
    for (rail=[0,1]){
        translate([-MOTOR_SPACE,rail*(SPACE_Y-SLOT_PROF_HEIGHT)]){
            rotate([90,0,90])
                portal_rail();

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
                                    wagon_connector(spacing=PORTAL_SPACING);

                                translate([0,
                                           side*(BASE_WIDTH+PORTAL_SPACING),
                                           0])
                                    portal_reinforcement();
                            }
                        }

            };

        if (REINFORCEMENT)
            for (y_shift=[0,PORTAL_SPACING+BASE_WIDTH])
                translate([POS_X+37.3+y_shift,
                           -SLIDER_HEIGHT+rail*(SPACE_Y-SLOT_PROF_HEIGHT)+50,
                           94.3])
                    rotate([180,0,90])
                        nut_mount()
                            thread_nut_mount()
                                thread_nut();
    }

}

portal_assembly();