
//length of tension section
length = 10;


module back(){
  intersection(){
   import("Prusa_i3_Y_Idler.stl");
   translate([-10,-30,0])cube([20,20,20]);
  }
}
module front(){
  difference(){
   import("Prusa_i3_Y_Idler.stl");
   translate([-10,-30,0])cube([20,20,20]);
  }
}
module mid(){
 difference(){
  translate([-9.5,-length-10,0])cube ([19,length,16]);
  translate([-9.5,-length-10,3.75])cube ([19,length,8.5]);
 }
}

module nut_tightener()
{
  cylinder(h = 30, r=1.5, $fn=20);
  cylinder(h = 5, r=3.2, $fn=6);
}


front();
mid();
difference(){
 translate([0,-length,0])back();
 translate([0,-length-11,8])rotate([90,0,0])nut_tightener();
}