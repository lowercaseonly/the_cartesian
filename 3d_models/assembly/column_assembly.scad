include <parameter.scad>

include <../helper/linear_wagon.scad>
include <../helper/motor.scad>
include <../helper/threaded_rod.scad>

use <../components/column.scad>
use <../components/column_connector.scad>
use <../components/motor_coupling.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Z-Axis (Column) Assembly
*/



module column_assembly(){

    for (y_shift=[0,-BASE_WIDTH-BRIDGE_SPACING])
        translate([120.2+POS_Z, y_shift, WAGON_HEIGHT+WAGON_OFFSET])
            rotate([0,180,90])
                linear_slider(length=SPACE_Z,
                              pos=POS_Z,
                              spacing=COLUMN_SPACING);

    translate([-12.0, -BASE_WIDTH/2-BRIDGE_SPACING/2, -BASE_THICKNESS])
        column_connector();

    translate([POS_Z-180,-41,WAGON_HEIGHT+WAGON_OFFSET])
        rotate([90,0,90]){
            column_upper()
                motor()
                    motor_coupling()
                        threaded_rod(length=SPACE_Z);
            column_lower();
        }

}


column_assembly();