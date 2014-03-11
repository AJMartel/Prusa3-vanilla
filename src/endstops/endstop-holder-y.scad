// ePoxi's Mechanical Y-Endstop Mount for Prusa i3
// 24-Feb-2014
// GNU GPL v3
// poxirave@gmail.com

RodDistance = 24.8;

module m10rod(){
	difference(){
		union() {
			cylinder(r=16/2, h=10, center=true, $fn=32);
			translate([-16/4,0,0]) cube(size=[16/2, 16, 10], center=true);
			translate([-16/2,0,0]) rotate([90, 0, 0]) cylinder(r=5, h=16, center=true, $fn=42);
			translate([-16/2,-1,0]) rotate([90, 0, 0]) cylinder(r=5, h=16, center=true, $fn=6);
		}
		translate([-10,0,0]) cube(size=[20, 9, 11], center=true);
		translate([-16/2,-14,0]) rotate([90, 0, 0]) cylinder(r=3.5, h=16, center=true, $fn=6);
		translate([-16/2,0,0]) rotate([90, 0, 0]) cylinder(r=1.6, h=18, center=true, $fn=16);

	}
}


module m8rod(){
	union() {
		difference(){
			cylinder(r=14/2, h=10, center=true, $fn=32);
			rotate([0,0,45]) translate([0, 4, 0]) cube(size=[20, 8, 15], center=true);
		}
		rotate([0,0,45]) translate([-11/2,0,0]) cylinder(r=1.5, h=10, center=true, $fn=16);
		rotate([0,0,45]) translate([11/2,0,0]) cylinder(r=1.5, h=10, center=true, $fn=16);
	}
}

module SwitchCutout() {
	// Switch
	translate([-15, 2, 4]) cube([13.2, 5.9, 10]);

	// tie holes
	translate([-16.5, -3.5, 4]) cube([1.7, 10, 3]);
	translate([-15+13.2, -3.5, 4]) cube([1.7, 10, 3]);
}

module MSwitchMount(){
	difference() {
		translate([2,0,5]) cube(size=[6, 20, 20], center=true);
		translate([-1, -7.5, 6]) rotate([0, 0, -90]) SwitchCutout();	
	}
}

module yEndstop(){
	union(){
		difference(){
			union() {
				m10rod();
				translate([0, RodDistance, 0]) m8rod();
				translate([4, RodDistance/2, 0]) MSwitchMount();
			}
			cylinder(r=5+0.1, h=50, center=true);
			translate([0, RodDistance, 0]) cylinder(r=4+0.1, h=50, center=true);
		}
	}
}


yEndstop();

//mirror() yEndstop();
