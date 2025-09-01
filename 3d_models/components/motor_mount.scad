$fn=100;

include <../helper/motor_flange.scad>
include <../helper/t_slot.scad>



translate([MOTOR_FLANGE_WIDTH,0,0])
    rotate([90,0,180])
        motor_flange();

difference(){
    translate([SLOT_PROF_HEIGHT/2+MOTOR_FLANGE_WIDTH/2,0,-2])
        rotate([-90,90,0])
            NUT8_mount_complete(thickness=0.0, double_size=false,
                                height=40, length=20);
    translate([MOTOR_FLANGE_WIDTH,0,0])
        rotate([90,0,180])
            motor_flange_cutout();
};