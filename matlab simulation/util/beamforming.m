function pointValues = beamforming(numMics,numPoints,delays,samples, sampleSize)
    % Perform beamforming to calculate the values at each point in the grid

    pointValues = zeros(numPoints, numPoints); % Matrix to store values at each point

    for x = 1:numPoints
        for y = 1:numPoints  
            % Matrix to store the sum of delayed signals
            waveSum = zeros(1, sampleSize+1);

            % Summation of signals
            for mic = 1:numMics
                % Shift the signal by the corresponding delay
                temp = circshift(samples{1, mic}, -delays(mic, x, y));
                temp(1, end-delays(mic, x, y)+1:end) = 0;
                % Accumulate the signals
                waveSum(1, :) = waveSum(1, :) + temp;
            end

            % Calculate the value at the point using the power of the summed signal
            pointValues(x, y) = sqrt(calcPower(waveSum , sampleSize));
        end
    end
end
