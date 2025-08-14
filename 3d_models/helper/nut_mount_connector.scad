
/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connector between Portal and Trapezoidal Thread Nut Mount
*/

SPIND_CON_SQUARE_SIDE = 5;
SPIND_CON_DIST = 20;

module nut_mount_connector(length=100){

    for (shift=[-SPIND_CON_DIST,0,SPIND_CON_DIST])
        translate([0,shift-(SPIND_CON_SQUARE_SIDE)/2,0])
            cube([SPIND_CON_SQUARE_SIDE,SPIND_CON_SQUARE_SIDE,length]);

}

// Sample Usage
//nut_mount_connector();
