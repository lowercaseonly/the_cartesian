include <../helper/motor_flange.scad>
include <../helper/t_slot.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects a Bearing to a T-Slot
*/


BEARING_MOUNT_OFFSET = 13.5;
BASE_THICKNESS = 9;

BEARING_MOUNT_PEDESTAL_LEN = 55.0;
BEARING_MOUNT_PEDESTAL_WIDTH = 13.2;
BEARING_MOUNT_PEDESTAL_THICK = 5.0;

BEARING_MOUNT_LEN = 36.0;
BEARING_MOUNT_WIDTH = 61.0;
BEARING_MOUNT_HEIGHT = 18.0;

module bearing_mount(){

    difference(){
        union(){

            translate([SLOT_PROF_HEIGHT/2,-BEARING_MOUNT_LEN/2,0])
                rotate([-90,90,0])
                    NUT8_mount(length=BEARING_MOUNT_OFFSET,
                               height=BEARING_MOUNT_LEN,
                               thickness_length=BEARING_MOUNT_OFFSET,
                               thickness_height=BEARING_MOUNT_LEN,
                               double_size=false);

            translate([0,0,BEARING_MOUNT_HEIGHT/2])
                cube([BEARING_MOUNT_WIDTH,
                      BEARING_MOUNT_LEN,
                      BEARING_MOUNT_HEIGHT],
                      center=true);

        }
        translate([0,0,
                   (BEARING_MOUNT_PEDESTAL_THICK/2)+BEARING_MOUNT_OFFSET])
            cube([BEARING_MOUNT_PEDESTAL_LEN,
                  BEARING_MOUNT_PEDESTAL_WIDTH,
                  BEARING_MOUNT_PEDESTAL_THICK], center=true);
    }

}

bearing_mount($fn=100);
