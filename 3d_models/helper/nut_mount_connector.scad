
/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connector between Portal and Trapezoidal Thread Nut Mount
*/

SPIND_CON_SQUARE_SIDE = 5;
SPIND_CON_DIST = 20;
TIGHT_FIT = 0.2;

module nut_mount_connector(length=100, male=false){

    edge_len = SPIND_CON_SQUARE_SIDE - (male?TIGHT_FIT:0);

    for (shift=[-SPIND_CON_DIST,0,SPIND_CON_DIST])
        translate([0, shift-edge_len/2, 0])
            cube([edge_len, edge_len, length]);

}

// Sample Usage
//nut_mount_connector();
