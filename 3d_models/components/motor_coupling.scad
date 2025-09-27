include <../helper/bom.scad>
include <../helper/motor.scad>
include <../helper/threaded_rod.scad>



MOTOR_COUPLING_DIA = 20;
MOTOR_COUPLING_LEN = 20;
MOTOR_COUPLING_ROD_ATTACH = 10.0;
MOTOR_COUPLING_SHAFT_ATTACH = 5.0;



module motor_coupling(){

    bom_item("MOTOR_COUPLING");

    difference(){

        translate([0,0,-MOTOR_COUPLING_SHAFT_ATTACH])
            cylinder(h=MOTOR_COUPLING_LEN,d=MOTOR_COUPLING_DIA);

        union(){

            translate([0,0,-MOTOR_SHAFT_LEN-MOTOR_CON_LEN])
                motor_shaft();
            translate([0,0,MOTOR_COUPLING_LEN-MOTOR_COUPLING_SHAFT_ATTACH
                           -MOTOR_COUPLING_ROD_ATTACH+NOTHING])
                cylinder(h=MOTOR_COUPLING_ROD_ATTACH, d=THEADED_ROD_DIA_OUTER);

        }

    }

    translate([0,0,MOTOR_COUPLING_LEN-MOTOR_COUPLING_SHAFT_ATTACH
                   -MOTOR_COUPLING_ROD_ATTACH+NOTHING])
        children();

}


motor_coupling($fn=400);