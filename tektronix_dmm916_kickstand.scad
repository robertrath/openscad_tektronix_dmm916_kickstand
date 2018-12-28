// Tektronix DMM916 Kickstand
//
// My Tektronix digitial multimeter has a flexible plastic shock cover
// with an integrated kickstand. As the lugs had brocken off the original 
// kickstand I decided to print a new one.
//
// Depending on your printer and material you can choose to generate
// a single piece or instead print 3 pieces with no overhang which
// can be glued together.
//
// Note that as the middle part comprises three separated sections it will
// be easiest to leave them attached to the print bed and glue on part 1
// before removal from the printer.

part(); // Print in one piece if your printer can handle this,
//partial_part_1(); // otherwis print and glue together these 3 pieces.
//partial_part_2();
//partial_part_middle(); // Glue on part 1 before removing from print bed.

// Original part measurements and other constants
$fn=80;

catch_length        = 54.0;
catch_radius        =  2.0;
barrel_length       = 43.0;
barrel_radius       =  2.5;
stand_legth         = 99.5;
stand_width         = 43.0;
stand_rounding      =  2.0;
stand_rounding      =  2.0;
stand_thickness     =  5.0;
stand_end_thickness =  6.3;
stand_end_lenth_1   =  6.8;
stand_end_lenth_2   =  8.2;
stand_end_to_void_1 = 13.7;
stand_end_to_void_2 = 57.3;
stand_void_length   = 24.5;
stand_void_width    = 19.5;


module partial_part_1()
{
  partial = stand_void_width/2;
  translate([0,0,-partial])difference()
  {
    rotate([0,270,0])part();
    translate([0,0,-50+partial])cube([200,200,100],true);
  }  
}

module partial_part_2()
{
  partial = stand_void_width/2;
  translate([0,0,-partial])difference()
  {
    rotate([0,90,0])part();
    translate([0,0,-50+partial])cube([200,200,100],true);
  }  
}

module partial_part_middle()
{
  partial_middle = stand_void_width/2;

  difference()
  {
    translate([0,0,partial_middle])difference()
    {
      rotate([0,270,0])part();
      translate([0,0,-50-partial_middle])cube([200,200,100],true);
    }
    translate([0,0,partial_middle])difference()
    {
      rotate([0,270,0])part();
      translate([0,0,-50+partial_middle])cube([200,200,100],true);
    }
  }  
}

module part()
{
  union()
  {
    pin();
    stand();
    hull()
    {
      rotate([90,0,90])translate([0,0,-barrel_length/2])cylinder(barrel_length,r=catch_radius/2,true);;
      translate([0,-catch_radius,-stand_thickness/2])barrel();
    }  
  }
}

module pin(){translate([0,-catch_radius,-stand_thickness/2])union(){catch();barrel();}}
module barrel(){rotate([90,0,90])translate([0,0,-barrel_length/2])cylinder(barrel_length,r=barrel_radius,true);}
module catch(){rotate([90,0,90])translate([0,0,-catch_length/2])cylinder(catch_length,r=catch_radius,true);}

module stand()
{
  difference()
  {
    union()
    {
      translate([0,stand_end_lenth_1/2,(stand_end_thickness-stand_thickness)/2])cube([stand_width,stand_end_lenth_1,stand_end_thickness],true);
      translate([0,stand_legth/2,0])cube([stand_width,stand_legth,stand_thickness],true);
      translate([0,stand_end_lenth_1,stand_thickness/2])rotate([0,270,0])linear_extrude(height=stand_width,center=true,10, twist = 0)
        polygon(points=[[0,0],[0,stand_end_lenth_2-stand_end_lenth_1],[stand_end_thickness-stand_thickness,0]]);
    }
    translate([0,stand_end_to_void_1,0])void();  
    translate([0,stand_end_to_void_2,0])void();  
    translate([0,stand_legth,-0.001-stand_thickness/2])rotate([180,270,0])linear_extrude(height=stand_width,center=true,10, twist = 0)
      polygon(points=[[0,0],[0,stand_end_lenth_2-stand_end_lenth_1],[stand_end_thickness-stand_thickness,0]]);
    translate([stand_width/2,stand_legth+.001,0])rounding_cutter();
    translate([-stand_width/2,stand_legth+.001,0])rotate([0,0,90])rounding_cutter();

  }
}
module void()
{
  translate([0,stand_void_length/2,0])cube([stand_void_width,stand_void_length,stand_thickness],true);
}  

module rounding_cutter()
{
  translate([-stand_rounding,-stand_rounding,0])intersection()
  {
    difference()
    {
      cube([stand_rounding*2,stand_rounding*2,stand_thickness],true);
      cylinder(20,r=stand_rounding,center=true);
    }
    translate([stand_rounding/2,stand_rounding/2,0])cube([stand_rounding,stand_rounding,stand_thickness],true);
  }
  
}  
