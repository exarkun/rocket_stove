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
		// Because we're in a weird coordinate space we need to push
		//the flue *down* and over.  Zero here is at the *top* of the
		//bench.  Thus the very weird, complex expression for the x
		//value of the translation.

                translate([
                    10,
                    BENCH_WIDTH - FLUE_RADIUS - FLUE_DEPTH,
                   0,
                ])
                    circle(r=FLUE_RADIUS, $fn=60);
            };
        };
};
