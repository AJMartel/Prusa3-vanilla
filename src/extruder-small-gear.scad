// PRUSA iteration3
// NEMA 17 extruder small gear
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org


include <external_gear_script.scad>;

module small_gear()
{
	translate([0,0,0])
	{

		translate ([30,0,0])
		difference(){
			rotate ([0,0,360*-1/20]) 
				gear (number_of_teeth = 8,
					  circular_pitch = 335,
					  rim_thickness = 15,
                       bore_diameter = 5.2,
                       hub_diameter = 20,
                       hub_thickness = 17,
					  gear_thickness = 8);

			translate([-3.25,4.25,9]) 
                 cube([6.5,3.2,9]);
			translate([0,0,9+3.5]) rotate([-90,0,0]) 
				cylinder(r=1.75, h=20, $fn=10);
		}
	}
}

small_gear();