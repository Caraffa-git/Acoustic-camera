clear all; close all;

load handel;
audio = y;

micMesh = genMicMesh(2, 0.1);
plot3(micMesh(1, :), micMesh(2, :), micMesh(3, :), ".");

% Generate simple microphone mesh on X-Z plane
function mesh = genMicMesh(n, dist)
    [X, Z] = meshgrid(-n:n, -n:n);
    Y = zeros(size(X));
    mesh = [X(:), Y(:), Z(:)]' .* dist;
end