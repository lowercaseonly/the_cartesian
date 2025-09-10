include <../helper/linear_wagon.scad>
include <../helper/nut_mount_connector.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects X-Axis Linear Rail Support Wagon to Nut Mount for reinforced Portal Construction
*/

TOLERANCE = 0.01;


module portal_reinforcement(){

    difference(){
        HGH20CA_plate(overhang=20);
        translate([10+BASE_HEIGHT-BASE_CORNER, BASE_WIDTH/2, -TOLERANCE])
            nut_mount_connector();
    }

}


portal_reinforcement($fn=400);