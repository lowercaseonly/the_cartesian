include <../helper/bom.scad>
include <../helper/motor_flange.scad>
include <../helper/t_slot.scad>


MOTOR_MOUNT_THICKNESS = 25.0;
MOTOR_MOUNT_LENGTH = 5.0;
MOTOR_MOUNT_LEFT = true;



module motor_mount(double_t_slot=false){

    bom_item("MOTOR_MOUNT",
             "T-SLOT_TYPE",double_t_slot?"double":"single");

    translate([MOTOR_FLANGE_WIDTH/2,0,MOTOR_FLANGE_HEIGHT/2])
        rotate([90,0,180])
            motor_flange();

    difference(){
        translate([SLOT_PROF_HEIGHT/2+MOTOR_FLANGE_WIDTH/2
                   +(double_t_slot&&MOTOR_MOUNT_LEFT?SLOT_DIST+SLOT_WIDTH:0),0,0])
            rotate([-90,90,0])
                NUT8_mount(length=MOTOR_MOUNT_THICKNESS,
                           thickness_length=MOTOR_MOUNT_LENGTH,
                           thickness_height=MOTOR_FLANGE_THICKNESS,
                           double_size=double_t_slot);
        translate([MOTOR_FLANGE_WIDTH/2,0,MOTOR_FLANGE_HEIGHT/2])
            rotate([90,0,180])
                motor_flange_cutout();
    };

}

motor_mount($fn=100, double_t_slot=false);