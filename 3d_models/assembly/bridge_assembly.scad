include <parameter.scad>

include <../helper/t_slot.scad>
include <../helper/linear_wagon.scad>

include <../shells/motor.scad>
include <../shells/threaded_rod.scad>
include <../shells/threaded_nut.scad>
include <../shells/t_slot.scad>

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
              inventorize=true, child_slots=[3,1,2,2]){

        translate([0,OFFSET_Y,0])
            linear_slider(length=SPACE_Y-130,
                          pos=POS_Y, spacing=BRIDGE_SPACING){
                translate([0,-BASE_WIDTH-BRIDGE_SPACING,0])
                    bridge(reinforcement=REINFORCEMENT);
                bridge(reinforcement=REINFORCEMENT)
                    children();
            }

        translate([0,OFFSET_Y,0])
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

        translate([0,SPACE_Y+OFFSET_Y-25,0])
            rotate([0,0,180])
                motor_mount(double_t_slot=true)
                    motor()
                        motor_coupling()
                            threaded_rod(length=SPACE_Y);

        for (y_shift=[60,SPACE_Y])
            translate([0,y_shift,0])
                    bearing_mount(double_t_slot=true);

    }

}


bridge_assembly();