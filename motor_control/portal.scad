$fn=400;


BASE_WIDTH = 100;
BASE_HEIGHT = 60;
BASE_THICKNESS = 10;
BASE_CORNER = 5;


M_SKREW_HEAD_DIA = 7;
M_SKREW_HEAD_LEN = 5;
M_SKREW_SHAFT_DIA = 5;
M_SKREW_SHAFT_LEN = 12;
M_SKREW_SINK = 5;
M_SKREW_DIST_X = 30;
M_SKREW_DIST_Y = 20;

module base_plate(width, depth, thickness, corner_radius=0){
    translate([corner_radius,corner_radius,0])
        minkowski(){
            cube([depth-corner_radius*2,
                  width-corner_radius*2,
                  thickness-1]);
            cylinder(r=corner_radius,h=1);
            }
}

module m_skrew(){
    union(){
        cylinder(d=M_SKREW_SHAFT_DIA,h=M_SKREW_SHAFT_LEN+M_SKREW_HEAD_LEN);
        translate([0, 0, M_SKREW_SHAFT_LEN])
            cylinder(d=M_SKREW_HEAD_DIA,h=M_SKREW_HEAD_LEN);
    }
}

module HGH20CA_plate(){
    difference(){
        base_plate(BASE_WIDTH,BASE_HEIGHT,BASE_THICKNESS,BASE_CORNER);
        union(){
            translate([BASE_HEIGHT/2-M_SKREW_DIST_Y/2,
                       BASE_WIDTH/2-M_SKREW_DIST_X/2,
                       -M_SKREW_SINK])
                m_skrew();
            translate([BASE_HEIGHT/2+M_SKREW_DIST_Y/2,
                       BASE_WIDTH/2-M_SKREW_DIST_X/2,
                       -M_SKREW_SINK])
                m_skrew();
            translate([BASE_HEIGHT/2-M_SKREW_DIST_Y/2,
                       BASE_WIDTH/2+M_SKREW_DIST_X/2,
                       -M_SKREW_SINK])
                m_skrew();
            translate([BASE_HEIGHT/2+M_SKREW_DIST_Y/2,
                       BASE_WIDTH/2+M_SKREW_DIST_X/2,
                       -M_SKREW_SINK])
                m_skrew();
            }
        }
}

HGH20CA_plate();
