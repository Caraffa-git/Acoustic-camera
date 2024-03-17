% Calculate signal delays between each microphone and each test point
function delays = calcDelays(mic_mesh, test_points, fs, distance)
    c = 343; % Speed of sound 343 m/s

    [x y z] = sph2cart(test_points(1, :), test_points(2, :), distance);

    delays = zeros(size(mic_mesh, 2), size(test_points, 2));

    for i = 1:size(mic_mesh, 2)
        delays(i, :) = sqrt(sum((mic_mesh(1:3, i) - [x; y; z]).^2, 1));
        delays(i, :) = round(delays(i, :) ./ c .* fs);
        delays(i, :) = delays(i, :) - min(delays(i, :));
    end

end