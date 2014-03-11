
module endstop() {
	rod_diameter = 8;
	outer_radius = rod_diameter/2 + 3.3;
	switch_holes_spacing = 6.5;

	opening_size = rod_diameter - 0.5; //openingsize

	difference() {
		union() {
			translate([outer_radius, outer_radius, 0]) cylinder(h = 10, r = outer_radius, $fn = 40);
			translate([outer_radius, 0, 0]) cube([12.5, outer_radius * 2, 10]);
			translate([-18, 0, 0]) cube([28, 4, 10]);
		}

		translate([14, 18, 5]) rotate([90, 0, 0]) #cylinder(h =5, r = 3.2, $fn = 6);

		translate([9, outer_radius - opening_size/2, 0]) cube([18, opening_size, 20]);
		translate([outer_radius, outer_radius, 0]) cylinder(h =20, r = rod_diameter/2 + 0.5, $fn = 18);

		// Securing hole
		translate([14, 17, 5]) rotate([90, 0, 0]) cylinder(h = 20, r = 3.3/2, $fn = 20);
		translate([14, 21.5, 5]) rotate([90, 0, 0]) #cylinder(h = 5, r = m3_nut_diameter_horizontal/2, $fn = 6);

		translate([14, 17, 5]) rotate([90, 0, 0]) #cylinder(h =20, r = 3.3/2, $fn = 20);

		// Switch
		translate([-15, 2, 4]) cube([13.2, 5.9, 10]);

		// tie holes
		translate([-16.5, -3.5, 4]) cube([1.7, 10, 3]);
		translate([-15+13.2, -3.5, 4]) cube([1.7, 10, 3]);
	}

}

endstop();