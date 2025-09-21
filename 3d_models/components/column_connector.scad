use <wagon_connector.scad>
include <../helper/linear_wagon.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects the Bridge's Linear Rail Wagons with the Column's Thread Nut
*/

BRIDGE_SPACING = 7;

NUT_DIA = 14.5;
NUT_DIA_INNER = 11;
NUT_LEN = 30.0;
NUT_DIST = 10;

COL_CON_WIDTH = 40;
COL_CON_DEPTH = 37;
COL_CON_HEIGHT = 30;

FITTING = 0.2;



module column_connector(){

    color([0.8,0.6,0.6]){
        wagon_connector(spacing=BRIDGE_SPACING, attachment="COLUMN");

        difference(){
            translate([-BASE_HEIGHT/2+BASE_CORNER,
                       -COL_CON_DEPTH/2,
                       BASE_THICKNESS])
                cube([COL_CON_WIDTH, COL_CON_DEPTH, COL_CON_HEIGHT]);

            translate([-NUT_LEN/2+5.6,0,BASE_THICKNESS+NUT_DIA/2+NUT_DIST])
                rotate([0,90,0])
                    rotate([0,0,30]){
                        cylinder(h=NUT_LEN, d=NUT_DIA+FITTING, $fn=6);
                        translate([0,0,-20])
                            cylinder(h=NUT_LEN+200,d=NUT_DIA_INNER);
                    }
        }

    }

}

column_connector($fn=100);