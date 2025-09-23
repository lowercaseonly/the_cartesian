include <../helper/bom.scad>
include <../helper/t_slot.scad>
include <../helper/linear_wagon.scad>
include <../helper/nut_mount_connector.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects Linear Rail Support Wagon to main CNC Portal Bridge T-Slot Profile
*/

TOLERANCE = 0.01;
PORTAL_HEIGHT = 110;  // Lower Wagon Edge to T-Slot Edge



module intermediate(spacing){
    
    translate([BASE_HEIGHT/2-BASE_CORNER, 0, 0])
        difference(){
            linear_extrude(height=BASE_THICKNESS)
                polygon([[0,       -BASE_WIDTH/2],
                         [2,        0], // Avoid Overlap with Base Skrew Holes
                         [0,        BASE_WIDTH/2],
                         [spacing,  SLOT_PROF_WIDTH/2],
                         [spacing, -SLOT_PROF_WIDTH/2]]);
            translate([10,0,-TOLERANCE])
                nut_mount_connector();
        }
}


module portal(){

    bom_item("PORTAL_BRIDGE_CONNECTOR");

    HGH20CA_plate();
    intermediate(spacing=PORTAL_HEIGHT-(BASE_HEIGHT-BASE_CORNER)-SLOT_MOUNT_LENGTH);
    translate([PORTAL_HEIGHT-BASE_HEIGHT/2,-(SLOT_PROF_WIDTH)/2,0])
        NUT8_mount(thickness_height=BASE_THICKNESS)
            children();

}

portal($fn=120);