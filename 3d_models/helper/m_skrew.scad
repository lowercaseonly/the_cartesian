/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Envelope of the most used M Skrew
*/

M_SKREW_HEAD_DIA = 8.5;
M_SKREW_HEAD_LEN = 4.8;
M_SKREW_SHAFT_DIA = 5.0;
M_SKREW_SHAFT_LEN = 15.8;

M_NUT_HEIGHT = 3.79;
M_NUT_DIA = 8.88;

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


module m_skrew_eject(length=5){
    // Helper Function to remove material for Mounting a Tightened Skrew
    // in Reversed Position

    // Push
    translate([0,length,0])
        cylinder(d=M_SKREW_HEAD_DIA,h=M_SKREW_HEAD_LEN+M_SKREW_SHAFT_LEN);

    // Slide
    hull(){
        m_skrew_head();
        translate([0,length,0])
            m_skrew_head();
    };

    // Slide
    hull(){
        m_skrew_shaft();
        translate([0,length,0])
            m_skrew_shaft();
    };

}


module m_nut(hole=false){

    difference(){
        cylinder(h=M_NUT_HEIGHT, d=M_NUT_DIA, $fn=6);
        if (hole)
            translate([0, 0, -1])
                m_skrew_shaft();
    }

}
