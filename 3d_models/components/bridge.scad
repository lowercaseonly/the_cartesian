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
REINFORCEMENT_OVERHANG = 35.0;
WAGON_OFFSET = 12.0;
WAGON_SPACING = 5.0;



module bridge(reinforcement=true){

    difference(){
        HGH20CA_plate(overhang=BASE_WIDTH-BASE_HEIGHT
                               +(reinforcement?REINFORCEMENT_OVERHANG:0));

        translate([BASE_WIDTH-BASE_HEIGHT/2-8.5+(reinforcement?REINFORCE_SHIFT:0),
                   0,
                   -TOLERANCE])
            nut_mount_connector();

        for (x_shift=[WAGON_OFFSET,BASE_WIDTH+WAGON_SPACING+WAGON_OFFSET])
            translate([x_shift,0,BASE_THICKNESS])
                rotate([180,0,90])
                    HGH20CA_screws();

        for (y_shift=[-1,1])
            translate([-6,y_shift*M_SKREW_DIST_Y/2,BASE_THICKNESS+M_SKREW_SINK])
                rotate([180,0,90])
                    m_skrew_eject();

    }

    translate([WAGON_OFFSET,0,BASE_THICKNESS])
        children();

};


bridge($fn=400);