function audio = simulateAudioSource(az, el, r, src_audio, fs, mic_mesh)
% Simulates audio arrival at microphones by calculating delay based on distance and applying it to the source audio.
%
% Parameters:
%   az, el: Azimuth and elevation angles of the audio source in spherical coordinates.
%   r: Distance from the source to the microphones.
%   src_audio: The audio signal from the source.
%   fs: The sample rate of the audio signal.
%   mic_mesh: A matrix representing the positions of the microphones in 3D space.
%
% Returns:
%   audio: A matrix where each row corresponds to the audio signal at a microphone,
%          with the delay applied to simulate the arrival of the sound at that microphone.
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