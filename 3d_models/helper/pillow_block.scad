/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Connector for Mounting a Bearing to a Parallel Plane
*/


NOTHING = 0.2;
FITTING = 0.1;


module pillow_block(thickness, length, center_dist, diameter, wall_thick, gap){
    
    difference(){
        hull(){
            linear_extrude(height=thickness)
                polygon([[-length/2             , 0],
                         [-diameter/2-wall_thick, center_dist],
                         [+diameter/2+wall_thick, center_dist],
                         [length/2              , 0]]);
            translate([0,center_dist,0])
                cylinder(h=thickness, d=diameter+2*wall_thick);
        }
        
        union(){
            translate([0,center_dist,-NOTHING])
                cylinder(h=thickness+2*NOTHING,
                         d=diameter+FITTING);
            
            // Gap for simpler fitting/pressing
            if (gap)
                translate([0,center_dist,-NOTHING])
                    cube([0.2,40,40]);
           
        }
    }

}


// Sample Usage
//$fn=200;
//pillow_block(thickness=3, length=60, center_dist=25, diameter=15, wall_thick=12.5, gap=true);
//pillow_block(thickness=10, length=60, center_dist=25, diameter=20, wall_thick=10, gap=true);