Prusa i3 Extruder
-----------------

This is a derivative of Kliment's excellent work on his 'i3ext' project for
the Prusa i3 3D printer.

I have modified it to work with jhead hotends (potentially dual extrusion, 
if stacked vertically - option now available), MK7-compatible hobbed pulleys, and
variable mount hole spacings.  Example models are available for viewing in
the /STLs folder.

The extruder requires:

* NEMA17 stepper motor
* 625zz bearings (2 - for large gear axle)
* ~75mm M5 threaded rod (1 - for large gear axle)
* M5 nyloc (2 - for large gear axle)
* M5 nut (1 - for large gear axle)
* MK7 hobbed pulley (1 - Makerbot, TrinityLabs, etc)
* M3 nut (5 - 4-motor mount, 1-small gear)
* 6mm M3 screw (1 - small gear)

RP one of each:

* main_block_v2.scad -OR- main_block_v2_kliment.scad
* idler.scad
* large_gear, small_gear from gears.scad -OR- gears-kliment.scad
* fan_mount.scad

Kliment's variant uses smaller gear diameters, which makes the dual extruder 
less tall.

I have about 15 hours of printing with this extruder (non-Kliment) and it's been
reliable so far.

Build
=====

A great photo of how the assembly goes together can be found here:

http://www.flickr.com/photos/borgnamarco/8480383523/

Also check out the other photos in this photostream:

http://www.flickr.com/photos/borgnamarco/8481477322/in/photostream/


Large Gear:

1. Slip M5 nyloc into large gear.

2. Screw M5 threaded rod into backside of large gear and screw in until flush
with front of gear.

3. Screw M5 standard nut on other end until it butts up against large gear and tighten.

Extruder Body:

1. Slip 625zz bearings into slots at front and back of extruder body.

2. Slide M5 threaded rod assembly through front 625zz bearing.

3. Slide MK7 hobbed pulley onto M5 threaded rod.

4. Slide M5 threaded rod through back 625zz bearing.

5. Screw on M5 nyloc to the backside of the M5 threaded rod, locking the M5 threaded 
rod in place.

6. Align MK7 hobbed gear with filament channel and tighten set screw.

NEMA17 Motor: 

1. Align NEMA17 motor with motor mount holes.

2. Screw in four 6mm M3 screws to secure it to the extruder body.

Small Gear:

1. Slip M3 nut in small gear nut trap.

2. Screw in 6mm M3 nut into small gear side hole and screw through M3 nut.

3. Slide small gear on NEMA17 motor axle with teeth facing inward aligning the teeth
with the large gear.

Prusa i3 Carriage:

1. Screw extruder body into x-carriage holes.

Done!


Notes
====

* main_block_v2.scad: has config options to:

1. open up either the front, back, or both idler areas in case you want to stack and selectively use one drive area over the other (default = 'both')

2. adjust the x-carriage mount hole spacing (default = 30mm)

3. adjust the filament diameter (default = 3mm)

4. use either J-Head or Prusa Nozzle hotends (default = jhead)

5. select where you want the J-Head mount placed (default = 'both')

6. select whether you want the dual extruder (default = false)

NOTE: do NOT change the hobb diameter in the top of the config options as this
does not work right yet


