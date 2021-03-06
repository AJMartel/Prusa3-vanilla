/*
bearing diameter 16mm
*/

$fn = 32;

hobb = 7; 					// use 6 if using Prusa's hobbed pulley - DOES NOT WORK!
//mount_spacing = 30; 		// use 30 if using the newer, 30mm hole x-carriage
mount_spacing = 24; 			// use 30 if using the newer, 30mm hole x-carriage

jhead_mount = true; 		// set to false if using prusanozzle or stacking
jhead_groove = "both";		// 'front', 'back', 'both', in case you
							// want to use a prusanozzle for 1 of 2 hotends
filament = 1.75;			// set to 3mm or 1.75mm or custom
							// note: a 1.5" gap is added to a filament channel
drive = "both";	  		    // 'front' = front filament drive
							// 'back' = back filament drive
							// 'both' = both front and back
dual = false;				// dual extruder stacking?  ** EXPERIMENAL!!!!! **

// uncomment if printing
//rotate([0,0,-90]) translate([-45,7,0]) idler();
//rotate([0,0,0]) translate([45,-24,0]) idler();

// set filament radius
// add 1.5mm gap around filament holes through extruder body
filament_rad = filament/2 + 0.75; 

use <inc/jhead.scad>;		// http://www.thingiverse.com/thing:45379
use <inc/mk7.scad>; 		// TrinityLabs hobbed pulley
use <idler.scad>;           // idler
use <gears.scad>;           // gears
use <inc/nema17.scad>;		// NEMA17 stepper motor

if (dual==true) {
	translate([48.9,0,0]) import("STLs/main_block_top.stl");
	//translate([41.9,0,0]) import("STLs/main_block_top_kliment.stl");
}

// jhead mounting groove
module jhead() {
	%translate([2,0,12]) rotate([0,-90,0]) hotend_jhead(); 
	%translate([2,0,-13]) rotate([0,-90,0]) hotend_jhead(); 

	// jhead mount groove
	difference() {
		translate([-2,0,0]) cube(size=[9.5,24,52], center=true);
		cube(size=[5.6,16.5,52.1], center=true);
		translate([-4.8,0,0]) cube(size=[4.1,12.5,52.1], center=true);

		// M3 jhead clamping holes
		// front jhead hotend
		translate([-4.2,0,4.5]) rotate([90,90,0]) 
			cylinder(r=2, h=30, center=true);
		translate([-4.2,0,19.5]) rotate([90,90,0]) 
			cylinder(r=2, h=30, center=true);
		// back jhead hotend
		translate([-4.2,0,-20.5]) rotate([90,90,0]) 
			cylinder(r=2, h=30, center=true);
		translate([-4.2,0,-5.5]) rotate([90,90,0]) 
			cylinder(r=2, h=30, center=true);
	}
	// bottom bracing
	translate([-7.5,10,0]) cube(size=[2,4,52], center=true);
	translate([-7.5,-10,0]) cube(size=[2,4,52], center=true);
}

// filament path and prusanozzle mounting holes
module nozzlemount(){
	rotate([0,90,0]) translate([0,2,0]) cylinder(r=filament_rad, h=70); // filament cutout
	%rotate([0,90,0]) translate([0,2,-100]) 
		cylinder(r=filament_rad-0.75, h=200, $fn=30); // filament visual path
	// slightly coned filament entrance after MK7 hobbed pulley:
	rotate([0,90,0]) translate([0,2,17]) cylinder(r1=1, r2=3.5, h=8);
	//translate([1,0+2,0]) rotate([0,90,0]) cylinder(r1=4, r2=2, h=3);
	translate([0,15+2,0]) rotate([0,90,0]) cylinder(r=2, h=70);
	translate([10-2.8,15+2,0]) rotate([0,90,0]) cylinder(r=3.3, h=70,$fn=6);
	translate([0,-25+2,0]) rotate([0,90,0]) cylinder(r=2, h=70);
	translate([10-2.8,-25+2,0]) rotate([0,90,0]) cylinder(r=3.3, h=70,$fn=6);
}

// mk7 hobbed pulley - for visualization
if (drive=="back" || drive=="both") {
	%translate([21,9,36]) mk7();
}
if (drive=="front" || drive=="both") {
	%translate([21,9,15.5]) rotate([0,180,0]) mk7();
}

// idler - for visualization
if (drive=="back" || drive=="both") {
	%translate([0.5,30.5,50]) rotate([0,90,-90]) idler();
}
if (drive=="front" || drive=="both") {
	%translate([0.5,30.5,25]) rotate([0,90,-90]) idler();
}

// gears - for visualization
%rotate([0,180,90]) translate([-8,-21,2]) {
	big_gear();
	translate([0,0,-2]) small_gear();
	translate([0,0,-22]) cylinder(r=5/2, h=75, center=true); // M5 bolt
}
if (dual==true) {
	%rotate([0,180,90]) translate([-8,-70,2]) {
		big_gear();
		translate([0,0,-2]) small_gear();
		translate([0,0,-22]) cylinder(r=5/2, h=75, center=true); // M5 bolt
	}
}

// NEMA17 - for visualization
%translate([21,-21,3]) rotate([0,180,0]) nema17();
if (dual==true) {
	%translate([70,-21,3]) rotate([0,180,0]) nema17();
}

// construct the extruder body
difference(){
	union(){
		cube([42,19,52]);  							// drivetrain block
		translate([0,-42,0]) cube([42,42+3,3]);  		// NEMA17 motor mount
		translate([-7.99,-42,0]) cube([8,80,52]);  	// base
		translate([-1,31,0]) cube([6, 7, 52]);		// idler stop
		translate([-1,15,50]) cube([6, 20, 2]);		// back idler stop
		//translate([-1,15,22]) cube([6, 20, 2]);		// front idler stop

		// jhead mount
		if (jhead_mount) translate([-10.5,13+2,52/2]) jhead();
	} 

	// M5 bolt
	if (drive != "both") {
		translate([21,9-1,27]) cylinder(r=7/2, h=45, center=true, $fn=50);
	}

	// antiwarpagenation: angled corners
	if (dual==false) {
		translate([46,-91,-1]) rotate([0,0,45]) cube(40); // top left NEMA mount corner
		translate([46,13,-1]) rotate([0,0,45]) cube([40,40,60]); // top-right corner
	}
	translate([-11,-91,-1]) rotate([0,0,45]) cube([40,40,60]);
	translate([-12,31,-1]) rotate([0,0,45]) cube([20,20,60]);
	translate([6,33,-1]) rotate([0,0,45]) cube([40,40,60]);

	// NEMA 17 motor circle cutout and mounting holes
	translate([21,-21,-1]) cylinder(r=12, h=5);
	translate([21+15.5,-21+15.5,-1]) cylinder(r=2, h=5);
	translate([21+15.5,-21-15.5,-1]) cylinder(r=2, h=5);
	translate([21-15.5,-21+15.5,-1]) cylinder(r=2, h=5);
	translate([21-15.5,-21-15.5,-1]) cylinder(r=2, h=5);

	// idler bearing cutout from drivetrain block
	// may not be needed - at least for 3mm filament!
	// problems pushing filament into bottom hole w/ this cutout there
	if (drive=="back" || drive=="both") {
		translate([21,24+3,25.5]) cylinder(r=12, h=25);
	}
	if (drive=="front" || drive=="both") {
		translate([21,24+3,5.5]) cylinder(r=12, h=20);
	}

	// hobbed pulley cutout from drivetrain block
	if (drive=="back" || drive=="both") {
		translate([21,8.1,25.5]) cylinder(r=hobb, h=25); 
		translate([-6+20,8,25.5]) cube([14,12,25]); 
		translate([21,8.1,5.5]) cylinder(r=hobb, h=2); // support for bearing
		translate([-6+20,8,5.5]) cube([14,12,2]); // support for back bearing 
	}
	if (drive=="front" || drive=="both") {
		translate([21,8.1,5.5]) cylinder(r=hobb, h=20); 
		translate([-6+20,8,5.5]) cube([14,12,20]);  
		translate([21,8.1,41.5]) cylinder(r=hobb, h=2); // support for bearing
		translate([-6+20,8,41.5]) cube([14,12,5]); // support for back bearing
	}

	// remove excess jhead mounting rails
	if (jhead_groove=="front") {
		translate([-20,0,26]) cube(size=[12,30,27]);
	} else if (jhead_groove=="back") {
		translate([-20,0,-5]) cube(size=[12,30,27]);
		translate([-15,0,12]) rotate([0,-55,0]) cube(size=[12,30,15]);
	} 

	// FIXME: had to add 0.01 for stl export to stop complaining!
	// 625zz filament drive bearing cutouts from drivetrain block
	translate([21, 9 - 0.9 + 0.01, -1]) cylinder(r=8.1, h=6); 
		%translate([21,9-0.9,-1]) cylinder(r=8.1, h=5); // visualize it
	translate([21, 9 - 0.9 + 0.01 , -5 + 52 - 4]) cylinder(r=8.1, h=8.5); 
		%translate([21,9-0.9,-5+52-4]) cylinder(r=8.1, h=5); // visualize it

	// filament drive bearing insert cutouts from drivetrain block
	translate([13,8,43]) cube([16.2,20,8.5]);
	translate([-6+21,8,-50+5]) cube([12,12,50]);

	//mounting holes for x-carriage mount from base
	translate([-4,22+(mount_spacing-24)/2,-28]){
		translate([0,0,0]) rotate([0,0,0]) 
			cylinder(r=3.3, h=70, $fn=15);
		translate([0,0-mount_spacing,0]) rotate([0,0,0]) 
			cylinder(r=3.3, h=70, $fn=15);
		translate([0,0,30]) rotate([0,0,0]) 
			cylinder(r=3.3/2, h=70, $fn=15);
		translate([0,0-mount_spacing,30]) rotate([0,0,0]) 
			cylinder(r=3.3/2, h=70, $fn=15);
	}

	// idler nuts and filament channels from drivetrain block and base
	translate([0,0,-2]){
		// PrusaNozzle mount holes
		translate([-10,2+8+4-1,52-12]) nozzlemount();
		translate([-10,2+8+4-1,52-12-25]) nozzlemount();

		// idler nuts
		if (drive=="back" || drive=="both") {
			translate([37,12,52-12-7]) rotate([90,0,0]) cylinder(r=3.3, h=12.1,$fn=6);
			translate([37,12,52-5]) rotate([90,0,0]) cylinder(r=3.3, h=12.1,$fn=6);
		}
		if (drive=="front" || drive=="both") {
			translate([37,12,52-12-7-25]) rotate([90,0,0]) cylinder(r=3.3, h=12.1,$fn=6);
			translate([37,12,52-5-25]) rotate([90,0,0]) cylinder(r=3.3, h=12.1,$fn=6);
		}

		// idler bolts
		if (drive=="back" || drive=="both") {
			translate([5+32,-1,52-12+7]) rotate([0,90,90]) 
				rotate([0,0,30]) cylinder(r=2, h=40, $fn=32);
			translate([5+32,-1,52-12-7]) rotate([0,90,90]) 
				rotate([0,0,30]) cylinder(r=2, h=40, $fn=32);
		}
		if (drive=="front" || drive=="both") {
			translate([5+32,-1,52-12-25+7]) rotate([0,90,90]) 
				rotate([0,0,30]) cylinder(r=2, h=40, $fn=32);
			translate([5+32,-1,52-12-25-7]) rotate([0,90,90]) 
				rotate([0,0,30]) cylinder(r=2, h=40, $fn=32);
		}

		// pretty cutout - angled idler area corners
		translate([-10,30,0]) rotate([-23,0,0]) cube([20,12,50]);
		translate([0,27,-3]) rotate([0,23,0]) cube([20,12,50]);

		// pretty cutout - angled base underneath NEMA17 motor
		translate([-10,-66,0]) rotate([-23,0,0]) cube([12,20,90]);
	}
}

// M5 bolt support
if (drive != "both") {
	difference() {
		translate([21,9-1,13]) cylinder(r=7.5/2, h=26, center=true, $fn=50);
		translate([21,9-1,13]) cylinder(r=7/2, h=27, center=true, $fn=50);
	}
}