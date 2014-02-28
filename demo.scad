include <bricks.scad>;

for (x = [0:9]) {
    color([1, 0, 0]) brick([x * (2.25 + 0.25), 0, 0], upright);
}

for (x = [0:9]) {
    color([1, 0, 0]) brick([x * (2.25 + 0.25), 20, 0], edge);
}

for (x = [0:2]) {
    color([1, 0, 0]) brick([x * (8 + 0.25), 24, 0], flat);
}
