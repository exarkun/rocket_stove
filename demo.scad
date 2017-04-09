use <bricks.scad>;

for (x = [0:9]) {
    translate([x * (2.25 + 0.25), 0, 0]) upright() brick();
}

for (x = [0:5]) {
    translate([x * (4.25 + 0.25), 10, 0]) orthogonal() upright() brick();
}

for (x = [0:9]) {
    translate([x * (2.25 + 0.25), 24, 0]) edge() brick();
}

for (x = [0:4]) {
    translate([x * (4 + 0.25), 34, 0]) orthogonal() flat() brick();
}
