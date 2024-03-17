clear all; close all;
addpath("./functions")

load handel;
audio = y;

N = 2;
d = 0.5;

mic_mesh = genMicMesh(N, d/N*0.5);
testPoints = genTestPointMesh(0.1, 0.1);
delays = calcDelays(mic_mesh, testPoints, Fs, 4*d);