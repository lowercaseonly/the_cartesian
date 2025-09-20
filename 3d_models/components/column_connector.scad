include <../helper/bom.scad>
use <wagon_connector.scad>
include <../helper/linear_wagon.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects the Bridge's Linear Rail Wagons with the Column's Thread Nut
*/

BRIDGE_SPACING = 7;
NUT_DIA = 14.5;
NUT_LEN = 80.0;
NUT_DIST = 16;
COL_CON_WIDTH = 40;
COL_CON_DEPTH = 25;
COL_CON_HEIGHT = 35;



module column_connector(){

    color([0.6,0.8,0.8]){
        wagon_connector(spacing=BRIDGE_SPACING,$fn=120);

        difference(){
            translate([-COL_CON_WIDTH/2,-COL_CON_DEPTH/2,BASE_THICKNESS])
                cube([COL_CON_WIDTH, COL_CON_DEPTH, COL_CON_HEIGHT]);

            translate([-NUT_LEN/2+10,0,BASE_THICKNESS+NUT_DIA/2+NUT_DIST])
                rotate([0,90,0])
                    rotate([0,0,30])
                        cylinder(h=NUT_LEN,d=NUT_DIA,$fn=6);
        }

    }

}

column_connector();