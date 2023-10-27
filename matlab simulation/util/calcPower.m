function power = calcPower(waveform, numSample)
    % Calculates the power of a given waveform

    power = 0; % Initialize power to zero

    % Iterate through the waveform samples
    for i = 1:numSample
        power = power + waveform(1, i)^2; % Accumulate the squared value of each sample
    end

    power = power / numSample; % Calculate the average power

end
