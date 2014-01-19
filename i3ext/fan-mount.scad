// PRUSA iteration3
// Fan mount
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

module fan_mount_base(){
 translate([0,0,0]) rotate([0,0,0]) cube([11,10, 4]);
 translate([0,0,0]) rotate([0,45,0]) translate([-10,0,0]) cube([10,10, 4]);
}

module fan_mount_holes(){
 translate([6,5,-1]) rotate([0,0,0]) cylinder(h=30, r=2.2, $fn=10);
 translate([6,5,2.5]) rotate([0,0,0]) cylinder(h=30, r=5.7/2, $fn=10);

 translate([0,5,0]) rotate([0,45,0]) translate([-5.5,0,-1]) cylinder(h=30, r=2.2, $fn=10);
 translate([0,5,0]) rotate([0,45,0]) translate([-5.5,0,2.5]) cylinder(h=30, r=5.7/2, $fn=10);
}

// Final part
module fan_mount(){
 difference(){
  fan_mount_base();
  fan_mount_holes();
 }
}

fan_mount();

