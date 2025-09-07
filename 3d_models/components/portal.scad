$fn=120;

include <../helper/t_slot.scad>
include <../helper/linear_wagon.scad>
include <../helper/nut_mount_connector.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects Linear Rail Support Wagon to main CNC Portal Bridge T-Slot Profile
*/

TOLERANCE = 0.01;

module intermediate(){
    
    translate([BASE_HEIGHT-BASE_CORNER, BASE_WIDTH/2, 0])
        difference(){
            linear_extrude(height=BASE_THICKNESS)
                polygon([[0,    -BASE_WIDTH/2],
                         [2,     0], // Avoid Overlap with Base Skrew Holes
                         [0,     BASE_WIDTH/2],
                         [18.5,  SLOT_PROF_WIDTH/2],
                         [18.5, -SLOT_PROF_WIDTH/2]]);
            translate([10,0,-TOLERANCE])
                nut_mount_connector();
        }
}


module portal(){

    HGH20CA_plate();
    intermediate();
    translate([110,-(SLOT_PROF_WIDTH-BASE_WIDTH)/2,0])
        NUT8_mount(thickness=BASE_THICKNESS);

}

portal();