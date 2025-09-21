include <../helper/bom.scad>
include <../helper/linear_wagon.scad>
include <../helper/connector_a.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects two Linear Rail Support Wagons
*/

TOLERANCE = 0.01;



module wagon_connector(spacing=5, attachment=""){

    bom_item(str("WAGON_CONNECTOR", (attachment==""?"":str("_", attachment))),
             "SPACING", spacing);

    connector(shift_x=0, shift_y=spacing/2, angle=0, shaft_len=10, male=true);
    connector(shift_x=0, shift_y=-spacing/2, angle=180, shaft_len=10, male=true);

    translate([BASE_CORNER-BASE_HEIGHT/2,-spacing/2,0])
        cube([BASE_HEIGHT-2*BASE_CORNER,
              spacing,
              BASE_THICKNESS]);

}

wagon_connector($fn=120);
