$fn=100;

include <../helper/motor_flange.scad>
include <../helper/t_slot.scad>


MOTOR_MOUNT_THICKNESS = 25.0;
MOTOR_MOUNT_LENGTH = 5.0;



module motor_mount(){

    translate([MOTOR_FLANGE_WIDTH,0,0])
        rotate([90,0,180])
            motor_flange();

    difference(){
        translate([SLOT_PROF_HEIGHT/2+MOTOR_FLANGE_WIDTH/2,
                   0,
                   -SLOT_PROF_CORNER])
            rotate([-90,90,0])
                NUT8_mount(length=MOTOR_MOUNT_THICKNESS,
                           thickness_length=MOTOR_MOUNT_LENGTH,
                           thickness_height=MOTOR_FLANGE_THICKNESS,
                           double_size=false);
        translate([MOTOR_FLANGE_WIDTH,0,0])
            rotate([90,0,180])
                motor_flange_cutout();
    };

}

motor_mount();