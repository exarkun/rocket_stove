upright = [0, 0, 0];
edge = [1, 0, 0];
flat = [0, 1, 0];

size = [2.25, 4, 8];
red = [1, 0, 0];

module brick(position, orientation) {
    color(red) translate(position) rotate(90, orientation) cube(size);
}

module course(position, orientation, direction, bricks) {
    for (x = [0:bricks - 1]) {
        brick(position + (direction * x), orientation);
    }
}

module wall(position, orientation, direction, length, height) {
    for (z = [0:height - 1]) {
        course(position + [0, z % 2 * 2, 3 * z], orientation, direction, length);
    }
}