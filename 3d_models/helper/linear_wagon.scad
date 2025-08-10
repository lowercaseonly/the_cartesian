
use <../helper/base_plate.scad>
include <../helper/connector_a.scad>
include <../helper/m_skrew.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Mount Plate to (Linear Support Wagon) HGH20CA
*/

BASE_WIDTH = 75;
BASE_HEIGHT = 44;
BASE_THICKNESS = 13.5;
BASE_CORNER = 2.5;

M_SKREW_SINK = 7;
M_SKREW_DIST_X = 40.35-M_SKREW_SHAFT_DIA;
M_SKREW_DIST_Y = 36.66-M_SKREW_SHAFT_DIA;


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