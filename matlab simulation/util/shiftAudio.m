function shifted_audio = shiftAudio(audio, num_samples)    
    % Check if the specified number of samples is valid
    if num_samples < 0
        error('Number of samples to shift must be non-negative.');
    end
    
    % Pad with zeros if shifting to the right
    if num_samples > 0
        audio = [zeros(num_samples, size(audio, 2)); audio];
    end
    
    % Truncate if shifting to the left
    if num_samples < 0
        audio = audio(abs(num_samples) + 1:end, :);
    end
    
    % Save the shifted audio
    % output_file = sprintf('shifted_audio_%d_samples.wav', num_samples);
    % audiowrite(output_file, audio, fs);
    
    % Return the shifted audio
    shifted_audio = audio;
end
