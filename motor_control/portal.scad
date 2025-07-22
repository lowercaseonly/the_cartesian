$fn=400;

TOLERANCE = 0.01;

// Connector to (Linear Support Block) HGH20CA
BASE_WIDTH = 75;
BASE_HEIGHT = 44;
BASE_THICKNESS = 13.5;
BASE_CORNER = 2.5;

// M Skrew
M_SKREW_HEAD_DIA = 8.3;
M_SKREW_HEAD_LEN = 4.8;
M_SKREW_SHAFT_DIA = 4.8;
M_SKREW_SHAFT_LEN = 15.8;
M_SKREW_SINK = 7;
M_SKREW_DIST_X = 40.35-M_SKREW_SHAFT_DIA;
M_SKREW_DIST_Y = 36.66-M_SKREW_SHAFT_DIA;

// Connector to mount 
CONN_THICK = 10;
CONN_HEAD_DIA = 7;
CONN_HEAD_COUNT = 3;
CONN_HEAD_DIST = 10;
CONN_SHAFT_DIA = 4;
CONN_SHAFT_THICK = 11;

// (T-Slot Aluminum Profile) Nut8 40x2
SLOT_PROF_WIDTH = 90;
SLOT_PROF_HEIGHT = 90;
SLOT_PROF_LEN = 100;    // Virtual
SLOT_PROF_CORNER = 2.5;
SLOT_WIDTH = 8;
SLOT_DEPTH = 6;
SLOT_DIST = 40;

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
            for (head=[-1:1])
                translate([head*CONN_HEAD_DIST, 5, BASE_THICKNESS-CONN_THICK+0.01])
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
            for (shift_x=[-1:2:2])
                for (shift_y=[-1:2:1])
                    translate([BASE_HEIGHT/2+(shift_x)*M_SKREW_DIST_Y/2,
                               BASE_WIDTH/2+(shift_y)*M_SKREW_DIST_X/2,
                               -M_SKREW_SINK])
                        m_skrew();
            connector(BASE_HEIGHT/2,0,0);
            connector(BASE_HEIGHT/2,BASE_WIDTH,180);
        }
    }
}

module bridge(){
    translate([BASE_HEIGHT-BASE_CORNER,0,0])
        linear_extrude(height=BASE_THICKNESS)
            polygon([[0, 0],
                     [2, BASE_WIDTH/2], // Avoid Overlap with Base Skrew Holes
                     [0, BASE_WIDTH],
                     [18.5, SLOT_PROF_WIDTH-(SLOT_PROF_WIDTH-BASE_WIDTH)/2],
                     [18.5, -(SLOT_PROF_WIDTH-BASE_WIDTH)/2]]);
}

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

module NUT8_mount(){
    linear_extrude(height=SLOT_PROF_WIDTH)
        polygon([[0,0],
                 [0,40+BASE_THICKNESS],
                 [10,40+BASE_THICKNESS],
                 [10+40,BASE_THICKNESS],
                 [10+40+10, BASE_THICKNESS],
                 [10+40+10,0]]);
}

module NUT8_mount_complete(){
    translate([120,-(SLOT_PROF_WIDTH-BASE_WIDTH)/2,0])
        difference(){
            rotate([0,0,-180])
                rotate([90,0,0])
                    NUT8_mount();
            translate([-2,0,-TOLERANCE])
                NUT8_45x2();
            for (y_shift=[0,42])
                union(){
                    translate([-60,10+y_shift,BASE_THICKNESS+2+TOLERANCE])
                        minkowski(){
                            cube([55-2*2,
                                  40-2*(2+2),
                                  100-2*2]);
                            sphere(r=2);
                        };
                    translate([10,25+y_shift,10+BASE_THICKNESS+2+TOLERANCE])
                        rotate([0,-90,0])
                            m_skrew();
                    }

        }
}
HGH20CA_plate();
color(c=[255,0,0])
    bridge();

//NUT8_45x2();

translate([150,-10,0])
rotate([0,0,-180])
rotate([90,0,0])
NUT8_mount();