include <../helper/motor.scad>


THEADED_ROD_DIA_OUTER = 8.0;
THEADED_ROD_LEN_ATTACH = 16.0;
THEADED_ROD_MOTOR_DIST = 8.0;



module motor_coupling(){

    difference(){
        translate([MOTOR_BLOCK_WIDTH/2,
                       MOTOR_CON_LEN+MOTOR_SHAFT_LEN+THEADED_ROD_MOTOR_DIST-25,
                       MOTOR_BLOCK_HEIGHT/2])
            rotate([-90,0,0])
                cylinder(h=40,d=25);
        union(){
            motor();
            translate([MOTOR_BLOCK_WIDTH/2,
                       MOTOR_CON_LEN+MOTOR_SHAFT_LEN+THEADED_ROD_MOTOR_DIST,
                       MOTOR_BLOCK_HEIGHT/2])
                rotate([-90,0,0])
                    cylinder(h=THEADED_ROD_LEN_ATTACH, d=THEADED_ROD_DIA_OUTER);
        }
    }

}


motor_coupling($fn=100);