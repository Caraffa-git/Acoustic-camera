function mesh = genMicMesh(n, dist)
% Generate simple microphone mesh on X-Z plane.
%
% Parameters:
%   n: Number of microphones along the X and Z axes.
%   dist: Distance between microphones.
%
% Returns:
%   mesh: A matrix where each row represents the 3D coordinates of a microphone.
    [X, Z] = meshgrid(-n:n, -n:n);
    Y = zeros(size(X));
    mesh = [X(:), Y(:), Z(:)]' .* dist;
end
