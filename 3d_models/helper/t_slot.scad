
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


module NUT8_45x2(){
    
    difference(){
        
        base_plate(SLOT_PROF_WIDTH, SLOT_PROF_HEIGHT, SLOT_PROF_LEN,
                   corner_radius=SLOT_PROF_CORNER);
        
        for (shift=[-SLOT_DIST/2- (SLOT_WIDTH/2),SLOT_DIST/2+ (SLOT_WIDTH/2)]){
            translate([-TOLERANCE,
                       (SLOT_PROF_WIDTH/2) - (SLOT_WIDTH/2) + shift,
                       -TOLERANCE])
                cube([SLOT_DEPTH+TOLERANCE,
                      SLOT_WIDTH,
                      SLOT_PROF_LEN+2*TOLERANCE]);
        }
    }
}
