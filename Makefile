
PARTS= x-carriage x-end-motor x-end-idler \
	   y-corners y-motor y-idler y-belt-holder \
	   z-axis-top z-axis-bottom \
	   belt-guide \
	   i3ext/small_gear i3ext/big_gear \
       i3ext/main_block_v2 i3ext/idler

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


