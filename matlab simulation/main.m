clear all; close all;
addpath("./functions")

load handel;
audio = y;

mic_mesh = genMicMesh(2, 1);
testPoints = genTestPointMesh(0.1, 0.1);

figure;
plot3(mic_mesh(1, :), mic_mesh(2, :), mic_mesh(3, :), ".");
hold on;
[x y z] = sph2cart(testPoints(1, :),  testPoints(2, :), 2);
plot3(x, y, z, ".");