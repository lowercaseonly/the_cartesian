include <../helper/bom.scad>
include <../helper/motor.scad>
include <../helper/threaded_rod.scad>


THEADED_ROD_LEN_ATTACH = 16.0;
THEADED_ROD_MOTOR_DIST = 8.0;
MOTOR_COUPLING_DIA = 25;
MOTOR_COUPLING_LEN = 40;



module motor_coupling(){

    bom_item("MOTOR_COUPLING");

    difference(){
        translate([MOTOR_BLOCK_WIDTH/2,
                       MOTOR_CON_LEN+MOTOR_SHAFT_LEN+THEADED_ROD_MOTOR_DIST-25,
                       MOTOR_BLOCK_HEIGHT/2])
            rotate([-90,0,0])
                cylinder(h=MOTOR_COUPLING_LEN,d=MOTOR_COUPLING_DIA);
        union(){
            motor_shaft();
            translate([MOTOR_BLOCK_WIDTH/2,
                       MOTOR_CON_LEN+MOTOR_SHAFT_LEN+THEADED_ROD_MOTOR_DIST,
                       MOTOR_BLOCK_HEIGHT/2])
                rotate([-90,0,0])
                    cylinder(h=THEADED_ROD_LEN_ATTACH, d=THEADED_ROD_DIA_OUTER);
        }
    }

}


motor_coupling($fn=100);