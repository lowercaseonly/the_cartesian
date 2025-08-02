/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Envelope of the most used M Skrew
*/

M_SKREW_HEAD_DIA = 8.4;
M_SKREW_HEAD_LEN = 4.8;
M_SKREW_SHAFT_DIA = 4.9;
M_SKREW_SHAFT_LEN = 15.8;

module m_skrew(){
    
    union(){
        cylinder(d=M_SKREW_SHAFT_DIA,h=M_SKREW_SHAFT_LEN+M_SKREW_HEAD_LEN);
        translate([0, 0, M_SKREW_SHAFT_LEN])
            cylinder(d=M_SKREW_HEAD_DIA,h=M_SKREW_HEAD_LEN);
    }
}

m_skrew();