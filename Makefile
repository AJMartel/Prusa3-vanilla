
PARTS= x-carriage x-end-motor x-end-idler \
	   y-corners y-motor y-idler \
	   z-axis-top z-axis-bottom \
	   i3ext/gears i3ext/main_block_v2 i3ext/idler

OPENSCAD=openscad

OUTPUT_DIR=build

STLS = $(foreach part, $(PARTS),$(OUTPUT_DIR)/$(part).stl)

all: $(STLS)

clean:
	-rm -Rf $(OUTPUT_DIR)

$(OUTPUT_DIR)/%.stl : src/%.scad
	mkdir -p $(OUTPUT_DIR)
	mkdir -p $(OUTPUT_DIR)/i3ext
	$(OPENSCAD) -m make -o $@ -d $@.deps $<


