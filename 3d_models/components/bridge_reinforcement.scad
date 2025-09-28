include <../helper/bom.scad>
include <../helper/linear_wagon.scad>
include <../helper/nut_mount_connector.scad>
include <../helper/m_skrew.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects Y-Axis Linear Rail Support Wagon to a Z-Axis Linear Support Wagon
*/

TOLERANCE = 0.01;
DIST_WAGON_Y_WAGON_Z = 69.0;
DIST_WAGON_Y_THREAD = 17.85;
SINK_THREAD = -2;
THREAD_DIA = 13;



module bridge_reinforcement(){

    bom_item("BRIDGE_REINFORCEMENT");

    difference(){
        union(){
            HGH20CA_plate(overhang=DIST_WAGON_Y_WAGON_Z);
            translate([BASE_HEIGHT/2+DIST_WAGON_Y_WAGON_Z-TOLERANCE,0,0])
                rotate([0,-90,180])
                    nut_mount_connector(length=BASE_THICKNESS);
        }
        translate([DIST_WAGON_Y_THREAD+BASE_HEIGHT/2,0,SINK_THREAD])
            rotate([90,0,0])
                cylinder(h=300, d=THREAD_DIA, center=true);
    }

};


bridge_reinforcement($fn=400);