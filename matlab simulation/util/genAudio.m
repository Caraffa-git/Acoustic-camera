function audio = genAudio(audio_source, srcPos, micPos)
    % Generates audio with appropriate delay for a given microphone position

    % Read audio file
    [audio, fs] = audioread(audio_source); % Load audio file and get its sampling frequency

    % Calculate phase difference based on the distance between source and microphone
    distance = norm(micPos - srcPos); % Calculate Euclidean distance
    speed_of_sound = 340; % Speed of sound in m/s
    phase_diff = round(fs * distance / speed_of_sound); % Calculate phase difference in samples

    % Apply phase difference to the signal to simulate sound propagation
    audio = shiftAudio(audio, phase_diff);

    audio = audio'; % Transpose the audio for consistent format

end