# The Cartesian
**The Cartesian** is a modular CNC Mill built from low-cost standard parts (which can ve bought of the shelf) as well as 3D-printed connectors.


## Folder Structure


```
.
│   README.md                  # This File
│   bom.csv                    # Bill of Materials
└───3d_models                  # Hardware 3D Models (OpenSCAD Code)
│   └───helper                 # Helper Models (Shared between different Machine Parts)
│   └───components             # Printable Component Models
└───src                        # Source Code


## Mechanical Setup
The basic mechnical structure of the described hardware consists of three linear axis which are oriented orthogonal to each other (hence the project name).

### General Considerations
The hardware is based on standard parts around which customized connectors are built (provided as `scad` files). The exact bill of materials can be found in a dedicated file in the root directory of this repository and includes:

 - `NUT8` aluminum profiles
 - `M5` screws and nuts
 - `HGH20` linear guide blocks and rails
 - `NEMA 23` stepper motors


### The X Axis
The X axis (also referred to as the *portal*) consists of the main structural, rectangular frame on which two pairs of linear guide rails carry a common rod.
