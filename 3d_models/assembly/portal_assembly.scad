include <parameter.scad>

include <../helper/t_slot.scad>

include <../shells/linear_slider.scad>
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



module motor_assembly(){

    translate([0,115,0])
        motor_mount()
            motor()
                motor_coupling()
                    threaded_rod(length=SPACE_X);

    for (shift=[MOTOR_SPACE,MOTOR_SPACE+SPACE_X])
        translate([0,shift,0])
            bearing_mount();

}


module portal_side(side_t){

    translate([0,MOTOR_SPACE,0])
        linear_slider(length=SPACE_X, pos=POS_X,
                      spacing=PORTAL_SPACING){

            rotate([0,0,side_t*180])
                portal()
                    children();

            if (side_t==1)
                    translate([-35,0,-50])
                        rotate([0,-90,180])
                            nut_mount()
                                thread_nut_mount()
                                    thread_nut();

            if (REINFORCEMENT){
                translate([0,-(BASE_WIDTH+PORTAL_SPACING)/2,0])
                    wagon_connector(spacing=PORTAL_SPACING);

                translate([0,-BASE_WIDTH-PORTAL_SPACING,0])
                    rotate([0,0,side_t*180])
                        portal_reinforcement();

                if (side_t==1)
                    translate([-35,-PORTAL_SPACING-BASE_WIDTH,-50])
                        rotate([0,-90,180])
                            nut_mount()
                                thread_nut_mount()
                                    thread_nut();

            }
        }

}


module portal_rail(){

    NUT8_45x2(length=SPACE_X+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE,
              inventorize=true,
              child_slots=[3,2,4]){
        motor_assembly();
        portal_side(1);
        portal_side(0)
            children();
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
    for (rail=[0,1])
        translate([-MOTOR_SPACE,rail*(SPACE_Y-SLOT_PROF_HEIGHT)])
            rotate([90,0,90])
                portal_rail()
                    if (rail==0)
                        children();

}

portal_assembly();