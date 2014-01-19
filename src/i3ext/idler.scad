module extruder_idler_base(){
 translate([1.25,0,0]) cube([22,42+11,8+3]);
	
}

module extruder_idler_holes(){
 translate([12,21,0]){
  // Main cutout
  cube([9,23,25], center=true);
  // Idler shaft
  translate([-12,0,4.1+2])rotate([0,90,0])cylinder(r=4.1, h=24);
  // Screw holes
  translate([7,-16,-1]) cylinder(r=2.2, h=24);
  translate([-7,-16,-1]) cylinder(r=2.2, h=24);
  hull() {
    translate([7,17,-1]) cylinder(r=2.2, h=24);
    translate([7,17,-1]) rotate([10,0,0]) cylinder(r=2.2, h=24);
  }
  hull() {
    translate([-7,17,-1]) cylinder(r=2.2, h=24);
    translate([-7,17,-1]) rotate([10,0,0]) cylinder(r=2.2, h=24);
  }
 }
}


// Idler final part
module idler(){
 difference(){
  extruder_idler_base();
  extruder_idler_holes();
  translate([0,41,6]) cube(size=[25,20,10]);
 }
}

idler();
translate([0,-6,0]) screwholder();

module screwholder() {
	difference() {
		hull() {
			translate([4,0,0]) cylinder(r=4,h=5);
			translate([20,0,0]) cylinder(r=4,h=5);
		}
  		translate([5,0,-1])cylinder(r=2.2, h=24);
  		translate([19,0,-1])cylinder(r=2.2, h=24);
  		translate([5,0,2])cylinder(r=6/2, h=24);
  		translate([19,0,2])cylinder(r=6/2, h=24);
	}
}