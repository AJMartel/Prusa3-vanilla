
PARTS= x-carriage x-end-motor x-end-idler \
	   y-corners y-motor y-idler \
	   z-axis-top z-axis-bottom \
	   extruder-small-gear extruder-big-gear extruder-idler \
	   belt-guide

OPENSCAD=openscad

OUTPUT_DIR=build

STLS = $(foreach part, $(PARTS),$(OUTPUT_DIR)/$(part).stl)

all: $(STLS)

clean:
	-rm -f $(OUTPUT_DIR)/*.stl
	-rm -f $(OUTPUT_DIR)/*.stl.deps

$(OUTPUT_DIR)/%.stl : src/%.scad
	mkdir -p $(OUTPUT_DIR)
	$(OPENSCAD) -m make -o $@ -d $@.deps $<


