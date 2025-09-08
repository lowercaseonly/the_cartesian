
use <../helper/base_plate.scad>
include <../helper/m_skrew.scad>

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

TROUGH_WIDTH = 32;
TROUGH_CORNER = 2;

SLOT_MOUNT_LENGTH = 40;
SLOT_MOUNT_HEIGHT = 20;

NOTHING = 0.01;

module NUT8_45x2(){
    
    difference(){
        base_plate(SLOT_PROF_WIDTH, SLOT_PROF_HEIGHT, SLOT_PROF_LEN,
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
                          SLOT_PROF_LEN+2*NOTHING]);
         
         // T-Slots along shorter Side
         for (y_shift=[0,1])
             translate([SLOT_PROF_HEIGHT/2-SLOT_WIDTH/2,
                        -NOTHING+y_shift*(SLOT_PROF_WIDTH-SLOT_DEPTH+NOTHING),
                        -NOTHING])
                    cube([SLOT_WIDTH,
                          SLOT_DEPTH+NOTHING,
                          SLOT_PROF_LEN+2*NOTHING]);
    }
}


module NUT8_mount_base(height, length, thickness_height, thickness_length, double_size){

    linear_extrude(height=double_size?SLOT_PROF_WIDTH:SLOT_PROF_HEIGHT)
        polygon([[0,                0],
                 [0,                height],
                 [thickness_length, height],
                 [length,           thickness_height],
                 [length,           thickness_height],
                 [length,           0]]);

}


module NUT8_mount(thickness=10, height=SLOT_MOUNT_HEIGHT,
                  length=SLOT_MOUNT_LENGTH, double_size=true){

    difference(){
        
        // Base Block
        rotate([90,0,-180])
            NUT8_mount_base(height+10, length+10, thickness, thickness_length=10, double_size=double_size);

        // Cut out T-Slot Profile
        if (double_size)
            translate([-2,0,-NOTHING])
                NUT8_45x2();
        else
            translate([SLOT_PROF_WIDTH-2,0,-NOTHING])
                rotate([0,0,90])
                    NUT8_45x2();
        
        // Cut out Skrew Holes and Reduce Material
        for (y_shift=[false,true]){
            translate([TROUGH_CORNER-62,
                       TROUGH_CORNER+(SLOT_PROF_WIDTH)/2+
                       (y_shift?3.9:-3.9-TROUGH_WIDTH),
                       TROUGH_CORNER+thickness])
                minkowski(){
                    cube([55-2*TROUGH_CORNER,
                          TROUGH_WIDTH-2*TROUGH_CORNER,
                          100-2*TROUGH_CORNER]);
                    sphere(r=TROUGH_CORNER);
                };
            translate([8,
                       (SLOT_PROF_WIDTH)/2+
                       (SLOT_DIST+SLOT_WIDTH)/2*(y_shift?-1:1),
                       thickness+height/2])
                rotate([0,-90,0])
                    m_skrew();
            }
    }

}


// Sample Usage
/*$fn=120;

NUT8_45x2();
color(c=[0.5,0.5,0])
    NUT8_mount();*/


// Sample Usage
/*$fn=120;

translate([SLOT_PROF_WIDTH,0,0])
    rotate([0,0,90])
        NUT8_45x2();

color(c=[0.5,0.5,0])
    NUT8_mount(thickness=-NOTHING, double_size=false,
               height=40, length=40);*/
