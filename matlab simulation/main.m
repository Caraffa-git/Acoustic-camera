clear all; close all;

load handel;
audio = y;

micMesh = genMicMesh(2, 0.1);
testPoints = genTestPointMesh(0.1, 0.1);

figure;
plot3(micMesh(1, :), micMesh(2, :), micMesh(3, :), ".");
hold on;
[x y z] = sph2cart(testPoints(1, :),  testPoints(2, :), 2);
plot3(x, y, z, ".");

% Generate simple microphone mesh on X-Z plane
function mesh = genMicMesh(n, dist)
    [X, Z] = meshgrid(-n:n, -n:n);
    Y = zeros(size(X));
    mesh = [X(:), Y(:), Z(:)]' .* dist;
end

% Generate mesh of test points in spherical system
function mesh = genTestPointMesh(az_step, el_step)
    [az el] = meshgrid(0:az_step:pi, -pi/2:el_step:pi/2);
    mesh = [az(:) el(:)]';
end