% Calculate signal delays between each microphone and each test point
function delays = calcDelays(mic_mesh, test_points, fs)
    c = 343; % Speed of sound 343 m/s

    x = test_points(1, :);
    y = test_points(2, :);
    z = test_points(3, :);

    delays = zeros(size(mic_mesh, 2), size(test_points, 2));

    for i = 1:size(mic_mesh, 2)
        delays(i, :) = sqrt(sum((mic_mesh(1:3, i) - [x; y; z]).^2, 1));
        delays(i, :) = round(delays(i, :) ./ c .* fs);
        delays(i, :) = delays(i, :) - min(delays(i, :));
    end

end