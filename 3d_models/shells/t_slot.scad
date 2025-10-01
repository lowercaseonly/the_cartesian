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



module t_slot_trans(slot_nbr){
    
    if (slot_nbr==0)
        translate([SLOT_PROF_HEIGHT/2,0,0])
            rotate([180,0,0])
                children();

    if (slot_nbr==1)
        translate([SLOT_PROF_HEIGHT,SLOT_PROF_WIDTH/2-SLOT_DIST/2-(SLOT_WIDTH/2),0])
            rotate([180,0,90])
                children();

    if (slot_nbr==2)
        translate([SLOT_PROF_HEIGHT,SLOT_PROF_WIDTH/2+SLOT_DIST/2+(SLOT_WIDTH/2),0])
            rotate([180,0,90])
                children();

    if (slot_nbr==3)
        translate([SLOT_PROF_HEIGHT/2,SLOT_PROF_WIDTH,0])
            rotate([180,0,180])
                children();

    if (slot_nbr==4)
        translate([0,SLOT_PROF_WIDTH/2+SLOT_DIST/2+(SLOT_WIDTH/2),0])
            rotate([180,0,-90])
                children();

    if (slot_nbr==5)
        translate([0,SLOT_PROF_WIDTH/2-SLOT_DIST/2-(SLOT_WIDTH/2),0])
            rotate([180,0,-90])
                children();

}


module NUT8_45x2(length=SLOT_PROF_LEN, inventorize=false, child_slots=[]){

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

    for (child_nbr=[0:len(child_slots)-1])
        t_slot_trans(child_slots[child_nbr])
            children(child_nbr);

}

module coord_marker(msg){

    text(msg);

}


// Sample Usage
/*NUT8_45x2($fn=120, child_slots=[0,1,2,3,4,5]){
    coord_marker("0");
    coord_marker("1");
    coord_marker("2");
    coord_marker("3");
    coord_marker("4");
    coord_marker("5");
}*/