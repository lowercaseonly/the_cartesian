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


module bridge_mount(){

    difference(){
        HGH20CA_plate(overhang=30);
        translate([-2.5,15,13.5])
            rotate([180,0,90])
                union(){
                    HGH20CA_screws();
                    for (shift=[6,38])
                        translate([shift,19.6,-7])
                            m_skrew_eject();
                };
    }

};

bridge_mount();
