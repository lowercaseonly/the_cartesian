$fn=100;

include <../helper/motor_flange.scad>
include <../helper/t_slot.scad>



translate([0,MOTOR_FLANGE_THICKNESS,0])
    rotate([90,0,0])
        motor_flange();

difference(){
    translate([SLOT_PROF_HEIGHT/2+MOTOR_FLANGE_WIDTH/2,0,-2])
        rotate([-90,90,0])
            NUT8_mount_complete(thickness=0.0, double_size=false,
                                height=40, length=20);
    translate([MOTOR_FLANGE_WIDTH/2,0,MOTOR_FLANGE_HEIGHT/2])
        rotate([90,0,0])
            cylinder(h=100,d=MOTOR_FLANGE_INNER_DIA,center=true);
};