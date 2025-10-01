include <../helper/bom.scad>

use <../helper/base_plate.scad>


/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: T-Slot Aluminum Profile (Nut8 40x2)
*/


SLOT_PROF_WIDTH = 79.80;
SLOT_PROF_HEIGHT = 40;
SLOT_PROF_LEN = 100;    // Virtual
SLOT_PROF_CORNER = 2.5;
SLOT_WIDTH = 8;
SLOT_DEPTH = 3.96;
SLOT_DIST = 31.75;

NOTHING = 0.01;



module NUT8_45x2(length=SLOT_PROF_LEN, inventorize=false){

    if (inventorize)
        bom_item("T-SLOT_PROFILE_NUT_8_45x2", "length", length);

    difference(){
        translate([SLOT_PROF_HEIGHT/2,SLOT_PROF_WIDTH/2,0])
            color([0.8,0.8,0.8])
                base_plate(SLOT_PROF_WIDTH, SLOT_PROF_HEIGHT, length,
                           corner_radius=SLOT_PROF_CORNER);

        // T-Slots along longer Side
        for (x_shift=[0,SLOT_PROF_HEIGHT-SLOT_DEPTH+NOTHING])
            for (y_shift=[-SLOT_DIST/2- (SLOT_WIDTH/2),
                           SLOT_DIST/2+ (SLOT_WIDTH/2)])
                translate([-NOTHING+x_shift,
                           (SLOT_PROF_WIDTH/2) - (SLOT_WIDTH/2) + y_shift,
                           -NOTHING])
                    cube([SLOT_DEPTH+NOTHING,
                          SLOT_WIDTH,
                          length+2*NOTHING]);

         // T-Slots along shorter Side
         for (y_shift=[0,1])
             translate([SLOT_PROF_HEIGHT/2-SLOT_WIDTH/2,
                        -NOTHING+y_shift*(SLOT_PROF_WIDTH-SLOT_DEPTH+NOTHING),
                        -NOTHING])
                    cube([SLOT_WIDTH,
                          SLOT_DEPTH+NOTHING,
                          length+2*NOTHING]);
    }

}

// Sample Usage
//NUT8_45x2($fn=120);
