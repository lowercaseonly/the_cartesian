$fn=120;

include <../helper/linear_wagon.scad>
include <../helper/connector_a.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects two Linear Rail Support Wagons
*/

TOLERANCE = 0.01;



module wagon_connector(spacing=5){

    connector(shift_x=0, shift_y=spacing, angle=0, shaft_len=10);
    connector(shift_x=0, shift_y=0, angle=180, shaft_len=10);

    translate([BASE_CORNER-BASE_HEIGHT/2,0,0])
        cube([BASE_HEIGHT-2*BASE_CORNER,
              spacing,
              BASE_THICKNESS]);

}

wagon_connector();
