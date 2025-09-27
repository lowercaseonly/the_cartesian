include <../helper/bom.scad>
include <../helper/motor.scad>
include <../helper/threaded_rod.scad>


THEADED_ROD_LEN_ATTACH = 16.0;
MOTOR_COUPLING_SHAFT_ATTACH = 10.0;
THEADED_ROD_MOTOR_DIST = 8.0;
MOTOR_COUPLING_DIA = 25;
MOTOR_COUPLING_LEN = 40;



module motor_coupling(){

    bom_item("MOTOR_COUPLING");

    difference(){

        translate([0,0,-MOTOR_COUPLING_SHAFT_ATTACH])
            cylinder(h=MOTOR_COUPLING_LEN,d=MOTOR_COUPLING_DIA);

        union(){

            translate([0,0,-MOTOR_SHAFT_LEN-MOTOR_CON_LEN])
                motor_shaft();

            cylinder(h=THEADED_ROD_LEN_ATTACH+200, d=THEADED_ROD_DIA_OUTER);

        }


    }

}


motor_coupling($fn=100);