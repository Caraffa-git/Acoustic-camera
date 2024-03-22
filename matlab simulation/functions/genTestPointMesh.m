function [mesh k l] = genTestPointMesh(az_start, az_stop, az_n, el_start, el_stop, el_n)
% Generate mesh of test points in spherical system.
%
% Returns:
%   mesh: A matrix where each row represents the azimuth and elevation angles of a test point in spherical coordinates.
    %[az el] = meshgrid(0:az_step:pi, -pi/2:el_step:pi/2);
    [az el] = meshgrid(linspace(az_start, az_stop, az_n), linspace(el_start, el_stop, el_n));
    mesh = [az(:) el(:)]';
    k = size(az, 1);
    l = size(az, 2);
end