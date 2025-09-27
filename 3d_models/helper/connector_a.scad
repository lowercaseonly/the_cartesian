
/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Internal Connector between Linear Wagon Mount Plates
*/

CONN_THICK = 10;
CONN_SINK = 5;
CONN_HEAD_DIA = 7;
CONN_HEAD_COUNT = 3;
CONN_HEAD_DIST = 10;
CONN_SHAFT_DIA = 4;
CONN_SHAFT_THICK = 11;

TIGHT_FIT = 0.1;

module connector(shift_x, shift_y, angle, shaft_len=30, male=false){
    translate([shift_x, shift_y, 0])
        rotate([0,0,angle])
            for (head=[(-CONN_HEAD_COUNT/2)+.5:CONN_HEAD_COUNT/2])
                translate([head*CONN_HEAD_DIST,
                           CONN_SINK,
                           BASE_THICKNESS-CONN_THICK+0.01+(male?TIGHT_FIT:0)]){
                    cylinder(d=CONN_HEAD_DIA-(male?TIGHT_FIT:0),
                             h=CONN_THICK-(male?TIGHT_FIT:0));
                    translate([-CONN_SHAFT_DIA/2+(male?TIGHT_FIT/2:0),
                               -shaft_len,
                               0])
                        cube([CONN_SHAFT_DIA-(male?TIGHT_FIT:0),
                              shaft_len,
                              CONN_THICK-(male?TIGHT_FIT:0)]);
                }
}


// Sample Usage
//$fn=120;
//BASE_THICKNESS = 13.5;
//connector(0,0,0);
