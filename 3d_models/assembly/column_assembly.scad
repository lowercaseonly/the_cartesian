module column_assembly(){

    for (y_shift=[0,-BASE_WIDTH-BRIDGE_SPACING])
        translate([120.2+POS_Z, y_shift, WAGON_HEIGHT+WAGON_OFFSET])
            rotate([0,180,90])
                linear_slider(length=SPACE_Z,
                              pos=POS_Z,
                              spacing=COLUMN_SPACING);

    translate([-12.0, -BASE_WIDTH/2-BRIDGE_SPACING/2, -BASE_THICKNESS])
        column_connector();

    translate([POS_Z-180,-41,WAGON_HEIGHT+WAGON_OFFSET])
        rotate([90,0,90])
                column();

}
