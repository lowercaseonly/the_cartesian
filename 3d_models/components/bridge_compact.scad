include <../helper/linear_wagon.scad>
include <../helper/support.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects Y-Axis Linear Rail Support Wagon to a Z-Axis Linear Support Wagon
*/

Z_SHIFT = 10;  // [0-13]
BRIDGE_SUPPORT_WIDTH = 23;



module bridge_compact(){

    HGH20CA_plate(overhang=BASE_THICKNESS);

    translate([BASE_HEIGHT/2,
               BRIDGE_SUPPORT_WIDTH/2,
               BASE_THICKNESS])
        rotate([0,-90,90])
            support_base(height=BASE_HEIGHT,
                         length=Z_SHIFT+BASE_WIDTH/2-BASE_THICKNESS,
                         thickness_height=0, thickness_length=0,
                         width=BRIDGE_SUPPORT_WIDTH);

    translate([BASE_HEIGHT/2+BASE_THICKNESS, 0, Z_SHIFT])
        rotate([-90,0,90])
            HGH20CA_plate(connector_right=false);

};


bridge_compact($fn=100);
