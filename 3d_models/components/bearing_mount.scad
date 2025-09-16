include <../helper/motor_flange.scad>
include <../helper/t_slot.scad>
include <../helper/m_skrew.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connects a Pedestal Bearing to a T-Slot
*/


BEARING_MOUNT_OFFSET = 13.5;
BASE_THICKNESS = 9;

BEARING_MOUNT_PEDESTAL_LEN = 55.0;
BEARING_MOUNT_PEDESTAL_WIDTH = 13.2;
BEARING_MOUNT_PEDESTAL_THICK = 5.0;
BEARING_MOUNT_PEDESTAL_HOLE_DIST = 44.65;

BEARING_MOUNT_LEN = 36.0;
BEARING_MOUNT_WIDTH = 61.0;
BEARING_MOUNT_HEIGHT = 18.0;

module bearing_mount(double_t_slot=false){

    difference(){
        union(){

            translate([SLOT_PROF_HEIGHT/2,-BEARING_MOUNT_LEN/2,0])
                rotate([-90,90,0])
                    NUT8_mount(length=BEARING_MOUNT_OFFSET,
                               height=BEARING_MOUNT_LEN,
                               thickness_length=BEARING_MOUNT_OFFSET,
                               thickness_height=BEARING_MOUNT_LEN,
                               double_size=double_t_slot);

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

        // Screw Holes for T-Slot Mount
        for (shift_x=[-1,1])
            translate([0,12*shift_x,-10])
                m_skrew(extend=10);

        // Screw Holes for Pedestal Bearing
        for (shift_y=[-1,1])
            translate([BEARING_MOUNT_PEDESTAL_HOLE_DIST/2*shift_y,0,5])
                cylinder(h=60,d=3);

    }

}

bearing_mount($fn=100, double_t_slot=false);
