/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Envelope of the most used M Skrew
*/

M_SKREW_HEAD_DIA = 8.5;
M_SKREW_HEAD_LEN = 4.8;
M_SKREW_SHAFT_DIA = 5.0;
M_SKREW_SHAFT_LEN = 15.8;


module m_skrew_head(){

    translate([0, 0, M_SKREW_SHAFT_LEN])
        cylinder(d=M_SKREW_HEAD_DIA,h=M_SKREW_HEAD_LEN);

}


module m_skrew_shaft(){

    cylinder(d=M_SKREW_SHAFT_DIA,h=M_SKREW_SHAFT_LEN+M_SKREW_HEAD_LEN);

}


module m_skrew(){

    m_skrew_head();
    m_skrew_shaft();

}
