function time_delta = calcDelays(fs, numMics, micPos ,numPoints, pointStep, scanDist)
    % Calculate signal delays for different microphones

    % Matrix to store delays for each point (per microphone)
    time_delta = zeros(numMics, numPoints, numPoints); % (mic, x, y)

    % Calculate delays
    for mic = 1:numMics
        for x = 1:numPoints
            for y = 1:numPoints
                % Calculate Euclidean distance and convert to time delay
                time_delta(mic, x, y) = norm(micPos(mic, :) - [x * pointStep, y * pointStep, scanDist]) * fs / 340;
            end
        end
    end

    % "Zero out" and round the delays
    time_delta = round(time_delta - min(time_delta));

end
