
use <../helper/base_plate.scad>
include <../helper/connector_a.scad>

include <../shells/m_skrew.scad>
include <../shells/linear_slider.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Mount Plate to (Linear Support Wagon) HGH20CA
*/


BASE_THICKNESS = 13.5;
BASE_CORNER = 2.5;

M_SKREW_SINK = 7;
M_SKREW_DIST_X = 40.7-M_SKREW_SHAFT_DIA;
M_SKREW_DIST_Y = 37.0-M_SKREW_SHAFT_DIA;





module HGH20CA_screws(bottom=true, top=true, left=true, right=true){

    for (shift_x=concat(bottom?[-1]:[], top?[1]:[]))
        for (shift_y=concat(right?[-1]:[], left?[1]:[]))
            translate([shift_x*M_SKREW_DIST_Y/2,
                       shift_y*M_SKREW_DIST_X/2,
                       -M_SKREW_SINK])
                m_skrew();

}


module HGH20CA_plate(overhang=0, connector_left=true, connector_right=true){
    
    difference(){
        translate([overhang/2,0,0])
            base_plate(BASE_WIDTH,BASE_HEIGHT+overhang,BASE_THICKNESS,BASE_CORNER);
        
        HGH20CA_screws();

        if (connector_right)
            connector(0,-BASE_WIDTH/2,0);

        if (connector_left)
            connector(0,BASE_WIDTH/2,180);
    }
}



// Sample Usage
//HGH20CA_plate($fn=120);

// Sample Usage
linear_slider(length=300, pos=60)
    HGH20CA_plate($fn=120);