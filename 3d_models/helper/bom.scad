/*
  Author: Johannes Bayer, 2025
  License: MIT
  Description: Helper Function to generate the Bill of Material (BOM) automatically
*/


module bom_item(component_name, mod_type="",mod_val=0){

    echo(str("BOM_ITEM: ", component_name, ", ", mod_type, ", ", mod_val));

}


// Sample Usage
//bom_item("Motor");
//bom_item("T-SLOT 45x2", "length", "300");