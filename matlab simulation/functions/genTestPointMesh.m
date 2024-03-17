function mesh = genTestPointMesh(az_step, el_step)
% Generate mesh of test points in spherical system.
%
% Parameters:
%   az_step: Step size for azimuth angle in radians.
%   el_step: Step size for elevation angle in radians.
%
% Returns:
%   mesh: A matrix where each row represents the azimuth and elevation angles of a test point in spherical coordinates.
    [az el] = meshgrid(0:az_step:pi, -pi/2:el_step:pi/2);
    mesh = [az(:) el(:)]';
end