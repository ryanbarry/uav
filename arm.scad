arm_diameter = 25; //mm
arm_length = 150; //mm
arm_thickness = 4; //mm

module arm_shaft_profile(diameter, length) {
    intersection() {
        translate([-diameter/2,0,-diameter/2]) // center on 0,0,0
        cube([diameter,length,diameter]);
        translate([-sqrt(pow(diameter,2)/2),0,0]) // center on 0,0,0
        rotate([0,45,0])
        cube([diameter,length,diameter]);
    }
}

module arm_internal_rib(diameter, length, thickness) {
    translate([-thickness/2,0,-diameter/2]) cube([thickness, length, diameter]);
}

module arm_shaft(diameter, length, thickness) {
    difference() {
        arm_shaft_profile(diameter, length);
        translate([0,-0.5,0]) // extend subtractor beyond subtractee's bounds
        arm_shaft_profile(diameter-thickness, length+1);
    }
    arm_internal_rib(diameter, length, 2);
}

arm_shaft(arm_diameter, arm_length, arm_thickness);
