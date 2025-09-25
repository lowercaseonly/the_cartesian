$fn=20;

use <portal_assembly.scad>
use <bridge_assembly.scad>
use <column_assembly.scad>

/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Overall CNC Machine Assembly Illustration
*/



portal_assembly()
    bridge_assembly()
        column_assembly();