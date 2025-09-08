$fn=100;

include <../helper/motor_flange.scad>
include <../helper/t_slot.scad>



module motor_mount(){

    translate([MOTOR_FLANGE_WIDTH,0,0])
        rotate([90,0,180])
            motor_flange();

    difference(){
        translate([SLOT_PROF_HEIGHT/2+MOTOR_FLANGE_WIDTH/2,
                   0,
                   -SLOT_PROF_CORNER])
            rotate([-90,90,0])
                NUT8_mount(length=25,
                           thickness_length=5,
                           thickness_height=MOTOR_FLANGE_THICKNESS,
                           double_size=false);
        translate([MOTOR_FLANGE_WIDTH,0,0])
            rotate([90,0,180])
                motor_flange_cutout();
    };

}

motor_mount();