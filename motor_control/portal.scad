$fn=400;


BASE_WIDTH = 75;
BASE_HEIGHT = 44;
BASE_THICKNESS = 13.5;
BASE_CORNER = 2.5;


M_SKREW_HEAD_DIA = 8.3;
M_SKREW_HEAD_LEN = 4.8;
M_SKREW_SHAFT_DIA = 4.8;
M_SKREW_SHAFT_LEN = 15.8;
M_SKREW_SINK = 7;
M_SKREW_DIST_X = 40.35-M_SKREW_SHAFT_DIA;
M_SKREW_DIST_Y = 36.66-M_SKREW_SHAFT_DIA;

CONN_THICK = 10;
CONN_HEAD_DIA = 7;
CONN_SHAFT_DIA = 4;
CONN_SHAFT_THICK = 11;


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

module connector(shift_x, shift_y, angle){
    translate([shift_x, shift_y, 0])
        rotate([0,0,angle])
            for (tooth=[-1:1])
                translate([tooth*10, 5, BASE_THICKNESS-CONN_THICK+0.01])
                    union(){
                        cylinder(d=CONN_HEAD_DIA, h=CONN_THICK);
                        translate([-CONN_SHAFT_DIA/2, -30, 0])
                            cube([CONN_SHAFT_DIA, 30, CONN_THICK]);
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
            connector(BASE_HEIGHT/2,0,0);
            connector(BASE_HEIGHT/2,BASE_WIDTH,180);
        }
    }
}

module bridge(){
    translate([100,100,0])
        rotate([0,0,45])
            cube([20,20,BASE_THICKNESS]);
}


HGH20CA_plate();
//bridge();

