include <../helper/bom.scad>

use <../helper/base_plate.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Linear Slider (Rail and Support Wagon) HGH20CA
*/

BASE_WIDTH = 75;
BASE_HEIGHT = 44;
BASE_CORNER = 2.5;

RAIL_WIDTH = 21.0;
RAIL_HEIGHT = 18.0;
WAGON_HEIGHT = 25.0;
WAGON_OFFSET = 5.0;

SLIDER_HEIGHT = WAGON_OFFSET + WAGON_HEIGHT;



module HGH20CA(){

    bom_item("HGH20CA");

    color([0.22,0.22,0.22])
        base_plate(BASE_WIDTH,BASE_HEIGHT,WAGON_HEIGHT,BASE_CORNER);

}


module HGH20(length){

    bom_item("HGH20", "length", length);

    color([0.22,0.22,0.22])
        translate([-RAIL_WIDTH/2,0,0])
            cube([RAIL_WIDTH,length,RAIL_HEIGHT]);

}


module linear_slider(length, pos, invert=false, spacing=-1){

    HGH20(length=length);

    pos_internal = invert?length-pos-BASE_WIDTH/2:pos+BASE_WIDTH/2;

    translate([0,pos_internal,WAGON_OFFSET])
        HGH20CA();

    if (spacing>0)
        translate([0,pos_internal+(invert?-1:1)*(BASE_WIDTH+spacing),WAGON_OFFSET])
            HGH20CA();

    translate([0,pos_internal,SLIDER_HEIGHT])
        rotate([0,0,180])
            children();

}


// Sample Usage
//linear_slider(length=300, pos=60);
