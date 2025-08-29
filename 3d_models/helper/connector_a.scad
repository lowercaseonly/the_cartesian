
/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Internal Connector between Linear Wagon Mount Plates
*/

// Connector to mount 
CONN_THICK = 10;
CONN_HEAD_DIA = 7;
CONN_HEAD_COUNT = 3;
CONN_HEAD_DIST = 10;
CONN_SHAFT_DIA = 4;
CONN_SHAFT_THICK = 11;

module connector(shift_x, shift_y, angle, shaft_len=30){
    translate([shift_x, shift_y, 0])
        rotate([0,0,angle])
            for (head=[-1:1])
                translate([head*CONN_HEAD_DIST, 5, BASE_THICKNESS-CONN_THICK+0.01])
                    union(){
                        cylinder(d=CONN_HEAD_DIA, h=CONN_THICK);
                        translate([-CONN_SHAFT_DIA/2, -shaft_len, 0])
                            cube([CONN_SHAFT_DIA, shaft_len, CONN_THICK]);
                    }
}