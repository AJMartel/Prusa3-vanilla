include <gear_script.scad>;

module big_gear() {
	difference() {
		translate ([0,0,0])
			gear(number_of_teeth=26,
				 circular_pitch=300,
				 rim_thickness=5,
				 bore_diameter=6.2
				 );
		translate ([0,0,6]) cylinder(r=10.2/2, h=5, $fn=6);
	}
}

big_gear();
