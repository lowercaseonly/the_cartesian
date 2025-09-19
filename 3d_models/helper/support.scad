/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Support Structure Helper Functions
*/


module support_base(height, length, thickness_height, thickness_length, width){

    linear_extrude(height=width)
        polygon([[0,                0],
                 [0,                height],
                 [thickness_length, height],
                 [length,           thickness_height],
                 [length,           thickness_height],
                 [length,           0]]);

}


module support_cutout(trough_len,trough_width,trough_height,corner){

    translate([corner,
               corner,
               corner])
        minkowski(){
            cube([trough_len-2*corner,
                  trough_width-2*corner,
                  trough_height-2*corner]);
            sphere(r=corner);
        };

}


module support(height, length, thickness_height, thickness_length,
               width, wall_thick, corner){

    difference(){
        support_base(height, length, thickness_height, thickness_length, width);
        translate([thickness_length, thickness_height, wall_thick])
            support_cutout(trough_len=length+corner, trough_width=width+corner,
                           trough_height=width-wall_thick*2, corner=corner);
    }

}



// Sample Usage
//support(height=40, length=40, thickness_height=10, thickness_length=10,
//          width=40,wall_thick=5, corner=3, $fn=100);