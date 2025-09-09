$fn=400;

include <../helper/linear_wagon.scad>
include <../helper/nut_mount_connector.scad>
include <../helper/m_skrew.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects Y-Axis Linear Rail Support Wagon to a Z-Axis Linear Support Wagon
*/

TOLERANCE = 0.01;
REINFORCE_SHIFT = 5.5;
REINFORCEMENT_OVERHANG = 40.0;
WAGON_SPACING = 5.0;

module bridge(reinforcement=true){

    difference(){
        HGH20CA_plate(overhang=BASE_WIDTH-BASE_HEIGHT
                               +(reinforcement?REINFORCEMENT_OVERHANG:0));

        translate([BASE_WIDTH-10+(reinforcement?REINFORCE_SHIFT:0),
                   BASE_WIDTH/2,
                   -TOLERANCE])
            nut_mount_connector();

        translate([0,15,13.5])
            rotate([180,0,90])
                union(){
                    HGH20CA_screws();
                    for (shift=[6,38])
                        translate([shift,19.6,-7])
                            m_skrew_eject();

                    translate([0,BASE_WIDTH+WAGON_SPACING,0])
                        HGH20CA_screws();
                };
    }

};

bridge();
