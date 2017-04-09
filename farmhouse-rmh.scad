// All measurements in inches.

red = [1, 0, 0];

// An 8" system can probably put out something like 300 kBTU with the duration
// of burn we want.  That's in the ballpark of our heating load.
FLUE_DIAMETER = 8;
FLUE_RADIUS = FLUE_DIAMETER / 2;

// The recommended minimum amount of masonry covering the flue for a
// comfortable seat.  We may want to go deeper.
FLUE_DEPTH = 6;


// These are comfortable couch dimensions.
BENCH_WIDTH = 36;
BENCH_HEIGHT = 18;
BACKREST_HEIGHT = 36;

// This fits the space well.
BENCH_LENGTH = 72;

color(red) {
    // The northeast corner block.
    difference() {
        cube([36, 36, BENCH_HEIGHT]);

        translate([36, 36, BENCH_HEIGHT - FLUE_RADIUS - FLUE_DEPTH])
          rotate_extrude(convexity=10, $fn=60)
            translate([FLUE_DEPTH + FLUE_RADIUS, 0, 0])
                circle(r=FLUE_RADIUS, $fn=60);
    };

    //
    // The long segment south of the northeast corner.
    //

    // extrusion is limited to making tall things so we have to rotate and
    // translate the result to get it into the right place afterwards.  The
    // rotation takes the tall thing and flops it down but it ends up below the
    // flow.  So the translate both moves it to the position to the north of
    // the northeast corner *and* drags it back up so its sits on the floor.
    translate([36, 0, BENCH_HEIGHT])
      rotate(90, [0, 1, 0])
        linear_extrude(height=BENCH_LENGTH) {
            difference() {
                square(size=[BENCH_HEIGHT, BENCH_WIDTH]);

		// We're in a weird coordinate space (mostly because of
		// limitations of extrude_linear I think).  Push the flue into
		// the mass with x and y (instead of z and y as I would have
		// thought).  Remember, the extrusion polygon is being rendered
		// as a tall thing not a long thing.
                translate([
		    // Push it in so it is FLUE_DEPTH away from the bench
		    //surface.  Recall we're going *down* from the surface of
		    //the bench here.
                    FLUE_RADIUS + FLUE_DEPTH,
		    // Push it in so it is FLUE_DEPTH away from the inner
		    //edge.  This value is pushing *away* from the outer edge.
                    BENCH_WIDTH - FLUE_RADIUS - FLUE_DEPTH,
                   0,
                ])
                    circle(r=FLUE_RADIUS, $fn=60);
            };
        };
};
