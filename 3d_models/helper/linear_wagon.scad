
use <../helper/base_plate.scad>
include <../helper/connector_a.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connector to (Linear Support Block) HGH20CA
*/

BASE_WIDTH = 75;
BASE_HEIGHT = 44;
BASE_THICKNESS = 13.5;
BASE_CORNER = 2.5;


module HGH20CA_plate(){
    
    difference(){
        base_plate(BASE_WIDTH,BASE_HEIGHT,BASE_THICKNESS,BASE_CORNER);
        union(){
            for (shift_x=[-1:2:2])
                for (shift_y=[-1:2:1])
                    translate([BASE_HEIGHT/2+(shift_x)*M_SKREW_DIST_Y/2,
                               BASE_WIDTH/2+(shift_y)*M_SKREW_DIST_X/2,
                               -M_SKREW_SINK])
                        m_skrew();
            connector(BASE_HEIGHT/2,0,0);
            connector(BASE_HEIGHT/2,BASE_WIDTH,180);
        }
    }
}

// Samples Usage
//HGH20CA_plate();