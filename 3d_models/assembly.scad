$fn=20;

include <helper/t_slot.scad>
include <helper/linear_wagon.scad>
include <helper/motor_flange.scad>
include <helper/motor.scad>

use <components/portal.scad>
use <components/portal_reinforcement.scad>
use <components/nut_mount.scad>
use <components/wagon_connector.scad>
use <components/bridge.scad>
use <components/bridge_reinforcement.scad>
use <components/motor_mount.scad>
use <components/bearing_mount.scad>
use <components/column.scad>
use <components/column_connector.scad>


/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Overall CNC Machine Assembly Illustration
*/


REINFORCEMENT = true;
PORTAL_SPACING = 8;
BRIDGE_SPACING = 7;
COLUMN_SPACING = 10;

MOTOR_SPACE=200;

// Printing Area
SPACE_X = 600;
SPACE_Y = 600;
SPACE_Z = 300;
PORTAL_HEIGHT = 110; // TODO resolve by SPACE_Z based Formula

// Printer Head Position
POS_X = 250;
POS_Y = 200;
POS_Z = 100; // 110/300: [65-135]

// Counter Axis (Slider/Profile/Component) Dimensions
OFFSET_Y = 90;







portal_assembly()
    bridge_assembly()
        column_assembly();