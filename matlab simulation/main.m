clear all; close all;

load handel;
audio = y;

mic_mesh = genMicMesh(2, 1);
testPoints = genTestPointMesh(0.1, 0.1);

figure;
plot3(mic_mesh(1, :), mic_mesh(2, :), mic_mesh(3, :), ".");
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

% Simulates audio arrival at microphones by calculating delay based on distance and applying it to the source audio.
function audio = simulateAudioSource(az, el, r, src_audio, fs, mic_mesh)
    audio = zeros(size(mic_mesh, 2), size(src_audio, 1));

    [x y z] = sph2cart(az, el, r);

    dist_to_mic = sqrt(sum((mic_mesh - [x; y; z]).^2, 1));

    c = 343; % Speed of sound 343 m/s
    delay = round(dist_to_mic ./ c .* fs); 
    delay = delay - min(delay);


    for i = 1:size(mic_mesh, 2)
        audio(i, delay(i)+1:end) = src_audio(1:end-delay(i))';
    end
end