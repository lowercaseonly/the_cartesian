
use <../helper/base_plate.scad>
include <../helper/connector_a.scad>
include <../helper/m_skrew.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Mount Plate to (Linear Support Wagon) HGH20CA
*/

RAIL_WIDTH = 21.0;
RAIL_HEIGHT = 18.0;
WAGON_HEIGHT = 25.0;
WAGON_OFFSET = 5.0;

BASE_WIDTH = 75;
BASE_HEIGHT = 44;
BASE_THICKNESS = 13.5;
BASE_CORNER = 2.5;

M_SKREW_SINK = 7;
M_SKREW_DIST_X = 40.7-M_SKREW_SHAFT_DIA;
M_SKREW_DIST_Y = 37.0-M_SKREW_SHAFT_DIA;



module HGH20CA_screws(bottom=true, top=true, left=true, right=true){

    for (shift_x=concat(bottom?[-1]:[], top?[1]:[]))
        for (shift_y=concat(right?[-1]:[], left?[1]:[]))
            translate([BASE_HEIGHT/2 + shift_x*M_SKREW_DIST_Y/2,
                       BASE_WIDTH/2 + shift_y*M_SKREW_DIST_X/2,
                       -M_SKREW_SINK])
                m_skrew();

}


module HGH20CA_plate(overhang=0, connector_left=true, connector_right=true){
    
    difference(){
        base_plate(BASE_WIDTH,BASE_HEIGHT+overhang,BASE_THICKNESS,BASE_CORNER);
        
        HGH20CA_screws();

        if (connector_right)
            connector(BASE_HEIGHT/2,0,0);

        if (connector_left)
            connector(BASE_HEIGHT/2,BASE_WIDTH,180);
    }
}


module HGH20CA(){

    color([0.22,0.22,0.22])
        translate([0,0,-WAGON_HEIGHT])
            base_plate(BASE_WIDTH,BASE_HEIGHT,WAGON_HEIGHT,BASE_CORNER);

}


module HGH20(length=300){

    color([0.22,0.22,0.22])
        translate([(BASE_HEIGHT-RAIL_WIDTH)/2,0,-WAGON_HEIGHT-WAGON_OFFSET])
            cube([RAIL_WIDTH,length,RAIL_HEIGHT]);

}


// Sample Usage
//$fn=120;
//HGH20CA_plate();
//HGH20CA();
//HGH20();
