arm_odiam = 25; //mm
arm_length = 150; //mm
arm_thickness = 4; //mm
motor_cup_idiam = 30; //mm

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

module arm_shaft(odiameter, length, thickness) {
    difference() {
        arm_shaft_profile(odiameter, length);
        translate([0,-0.5,0]) // extend subtractor beyond subtractee's bounds
        arm_shaft_profile(odiameter-thickness, length+1);
    }
    arm_internal_rib(odiameter, length, 2);
}

module motor_cup(idiameter, height, thickness) {
    translate ([0,0,-height/2])
    difference() {
        difference() {
            union() {
                cylinder(h=height, r=(idiameter+thickness)/2, $fn=100);
                translate([0, -(idiameter+thickness)/2, height/2]) arm_shaft(height, thickness*2, thickness);
            }
            translate([0,0,thickness]) cylinder(h=height, r=idiameter/2, $fn=100);
        }
        translate([0, -(idiameter+thickness)/2, height/2]) arm_shaft_profile(height-thickness, thickness*2);
    }
}

module arm(height, length, motor_cup_idiam, thickness) {
    arm_shaft(height, length-motor_cup_idiam-thickness, thickness);
    translate([0,150-(motor_cup_idiam+thickness)/2,0]) motor_cup(motor_cup_idiam, height, thickness);
}

arm(arm_odiam, arm_length, motor_cup_idiam, arm_thickness);
