/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Helper Function to generate a cuboid with rounded side corners
*/

module base_plate(width, depth, thickness, corner_radius=0){
    
    translate([corner_radius,corner_radius,0])
        minkowski(){
            cube([depth-corner_radius*2,
                  width-corner_radius*2,
                  thickness-1]);
            cylinder(r=corner_radius,h=1);
            }
}


// Sample Usage
base_plate(30,40,10,5);