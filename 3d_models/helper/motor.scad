include <../helper/bom.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: NEMA 23 Stepper Motor
*/


MOTOR_BLOCK_WIDTH = 56.25;
MOTOR_BLOCK_HEIGHT = 56.25;
MOTOR_BLOCK_LENGTH = 112.0;
MOTOR_CON_DIA = 38.1;
MOTOR_CON_LEN = 1.5;
MOTOR_SHAFT_DIA = 10;
MOTOR_SHAFT_LEN = 22.5;
MOTOR_SHAFT_CUT_DIA = 9.5;
MOTOR_SHAFT_CUT_LEN = 20.0;



module motor_shaft(){

    difference(){
            rotate([-90,0,0])
                cylinder(h=MOTOR_SHAFT_LEN+MOTOR_CON_LEN,
                         d=MOTOR_SHAFT_DIA);

        translate([-MOTOR_SHAFT_DIA/2,
                   MOTOR_SHAFT_LEN+MOTOR_CON_LEN-MOTOR_SHAFT_CUT_LEN,
                   MOTOR_SHAFT_DIA/2-MOTOR_SHAFT_DIA+MOTOR_SHAFT_CUT_DIA])
            cube([MOTOR_SHAFT_DIA,MOTOR_SHAFT_CUT_LEN,MOTOR_SHAFT_DIA]);
    }

}


module motor(){

    bom_item("NEMA_23_STEPPER_MOTOR");

    color([0.8,0.15,0.15]){

        translate([0,-MOTOR_BLOCK_LENGTH,0])
            cube([MOTOR_BLOCK_WIDTH,
                  MOTOR_BLOCK_LENGTH,
                  MOTOR_BLOCK_HEIGHT]);

        translate([MOTOR_BLOCK_WIDTH/2,0,MOTOR_BLOCK_HEIGHT/2]){

            rotate([-90,0,0])
                cylinder(h=MOTOR_CON_LEN,d=MOTOR_CON_DIA);

            motor_shaft();
        }

    }

    translate([MOTOR_BLOCK_WIDTH/2,
               MOTOR_SHAFT_LEN+MOTOR_CON_LEN,
               MOTOR_BLOCK_HEIGHT/2])
        rotate([-90,0,0])
            children();

};

// Sample Usage
// motor($fn=400);