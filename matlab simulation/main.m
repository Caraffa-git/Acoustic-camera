addpath('./util');

% Define the positions of 9 microphones in 3D space
micNum = 9; 
micPos = [  0.8, 0.8, 0;     % Coordinates of each microphone
            1.0, 0.8, 0;
            1.2, 0.8, 0;
            0.8, 1.0, 0;
            1.0, 1.0, 0;
            1.2, 1.0, 0;
            0.8, 1.2, 0;
            1.0, 1.2, 0;
            1.2, 1.2, 0];
fs = 44100;                 % Sampling frequency
srcPos = [1.5, 1.5, 3];     % Position of the sound source

scanDist = 3;               % Scanning distance
pointNum = 40;              % Number of points in scan area (n x n)
pointStep = 0.05;           % Distance between each point in scan area

% Calculate delays for sound propagation from microphones to points
delays = calcDelays(fs, micNum, micPos, pointNum, pointStep, scanDist);

% Initialize a cell array to store audio samples for each microphone
audio = cell(1, micNum);

% Load and generate audio for each microphone
for mic=1:micNum
    % audio{1, mic} = genAudio("./audio/white noise.wav", srcPos,micPos(mic, :));
    audio{1, mic} = genAudio("./audio/Lady Pank - Zamki na piasku.wav", srcPos,micPos(mic, :));
end

sampleSize = 500; % Define the size of audio chunks for processing

% Check if sampleSize is large enough to accommodate maximum delays
if (sampleSize < max(delays, [], [1 2]))
    fprintf("SampleSize is too small\n");
    return;
end

heatMap = zeros(pointNum, pointNum);    % Initialize a matrix for the heatmap
figure;                                 % Create a new figure
imagesc(heatMap);                       % Display the initial heatmap
colorbar;                               % Add a colorbar for reference

% Iterate through the audio signal in chunks to simulate real-time processing
for sample = 1:sampleSize:size(audio{1, mic}, 2)-sampleSize
    samples = cell(1, micNum);

    % Extract audio chunk for each microphone
    for mic = 1:micNum
        samples{1, mic} = audio{1, mic}(sample:sample+sampleSize);
    end

    % Perform sum-and-delay beamforming to create the heatmap
    heatMap = beamforming(micNum, pointNum, delays, samples, sampleSize);

    % Display the updated heatmap
    imagesc(heatMap);
    set(gca, 'YDir', 'normal'); 
    colorbar;
    drawnow;

    % Display the current time
    fprintf("%.2f\n", sample/fs);

    % Pause for a short interval to control the display rate
    pause(0.05);
end
