
BRICK_SIZE = [2.25, 4, 8];
BRICK_PADDED = BRICK_SIZE + [0.25, 0.25, 0.25];
echo(BRICK_PADDED);

red = [1, 0, 0];

module upright() {
       child();
}

module edge() {
       rotate(90, [1, 0, 0]) child();
}

module flat() {
       rotate(90, [0, 1, 0]) child();
}

module orthogonal() {
       rotate(90, [0, 0, 1]) child();
}

module brick() {
    color(red) cube(BRICK_SIZE);
}

module course(direction, bricks) {
    for (x = [0:bricks - 1]) {
        translate(direction * x) flat() brick();
    }
}

module wall(position, direction, length, height) {
    for (z = [0:height - 1]) {
        course(position + [0, z % 2 * 2, 3 * z], direction, length);
    }
}

// for (x = [0:9]) {
//     translate([x * (2.25 + 0.25), 0, 0]) upright() brick();
// }

// for (x = [0:5]) {
//     translate([x * (4.25 + 0.25), 10, 0]) orthogonal() upright() brick();
// }

// for (x = [0:9]) {
//     translate([x * (2.25 + 0.25), 24, 0]) edge() brick();
// }

// for (x = [0:4]) {
//     translate([x * (4 + 0.25), 34, 0]) orthogonal() flat() brick();
// }

// wall([0, 0, 0], [0, BRICK_SIZE[1] + 0.25, 0], 10, 10);

function course_length(bricks) = [8, 0, 0] * bricks + [0.25, 0, 0] * (bricks - 1);

module course_offset(length) {
   translate(course_length(length)) rotate(90, [0, 0, 1]) translate([4.25, 0, 0]) child();
}

module square_course(length) {
    course([8.25, 0, 0], length);
    translate(course_length(length)) rotate(90, [0, 0, 1]) translate([4.25, 0, 0]) {
        course([8.25, 0, 0], length);
        translate(course_length(length)) rotate(90, [0, 0, 1]) translate([4.25, 0, 0]) {
            course([8.25, 0, 0], length);
            translate(course_length(length)) rotate(90, [0, 0, 1]) translate([4.25, 0, 0]) {
                course([8.25, 0, 0], length);
            }
        }
    }
}

for (z = [0:2]) {
    translate([0, 0, z]) course_offset(4) square_course(4);
}
