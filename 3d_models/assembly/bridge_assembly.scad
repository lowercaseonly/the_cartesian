include <parameter.scad>

include <../helper/t_slot.scad>
include <../helper/linear_wagon.scad>
include <../helper/motor_flange.scad>
include <../helper/motor.scad>
include <../helper/threaded_rod.scad>
include <../helper/threaded_nut.scad>

use <../components/motor_mount.scad>
use <../components/motor_coupling.scad>
use <../components/bearing_mount.scad>
use <../components/bridge_connector.scad>
use <../components/bridge.scad>
use <../components/bridge_reinforcement.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Y-Axis (Bridge) Assembly
*/



module bridge_assembly(){

    NUT8_45x2(length=SPACE_Y+2*SLOT_MOUNT_HEIGHT+MOTOR_SPACE-100,
              inventorize=true);

    translate([SLOT_PROF_HEIGHT,
               2*SLOT_PROF_HEIGHT+SLOT_WIDTH,
               SPACE_Y+70])
        rotate([-90,0,-90]){
            motor_mount(double_t_slot=true)
                motor()
                    motor_coupling()
                        threaded_rod(length=SPACE_Y);
            for (y_shift=[70,SPACE_Y+20])
                translate([28.2,y_shift,0])
                    rotate([0,0,180])
                        bearing_mount(double_t_slot=true);
            }

    translate([SLOT_PROF_HEIGHT/2,SLOT_PROF_WIDTH,OFFSET_Y])
        rotate([90,0,180])
            linear_slider(length=SPACE_Y-130,
                          pos=POS_Y, spacing=BRIDGE_SPACING){
                translate([0,-BASE_WIDTH-BRIDGE_SPACING,0])
                    bridge(reinforcement=REINFORCEMENT);
                translate([0,0,0])
                    bridge(reinforcement=REINFORCEMENT)
                        children();
            }

    translate([SLOT_PROF_HEIGHT,20,OFFSET_Y])
        rotate([90,0,90])
            linear_slider(length=SPACE_Y-130,
                          pos=POS_Y, spacing=BRIDGE_SPACING)
                rotate([0,0,180]){
                    for (y_shift=[0,-BASE_WIDTH-BRIDGE_SPACING])
                        translate([0,-y_shift,0])
                            bridge_reinforcement();
                    translate([0,BASE_WIDTH/2+BRIDGE_SPACING/2,0])
                        bridge_connector()
                            thread_nut();
                };

}



bridge_assembly();