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


// Sample Usage
//support_base(height=10,length=10,
//             thickness_height=1,thickness_length=1,width=10);