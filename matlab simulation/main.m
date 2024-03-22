clear all; close all;
addpath("./functions")

load handel;
audio_base = y;

N = 2;
d = 1;

mic_mesh = genMicMesh(N, d/N*0.5);
[test_points k l] = genTestPointMesh(0+pi/8, pi-pi/8, 32, -pi/2 + pi/6, pi/2 - pi/6, 32);
delays = calcDelays(mic_mesh, test_points, Fs, 4*d);

audio = simulateAudioSource(pi/2, 0, 4, audio_base, Fs, mic_mesh);

packet_size = round(Fs/100);
audio_packets = zeros(size(mic_mesh, 2), packet_size);

for i = 1:round(Fs/100):size(audio_base, 1) - packet_size
    audio_packets = audio(:, i:i+packet_size);
    frame = beamFormDAS(audio_packets, delays);
    frame = reshape(frame, [k l]);
   
    imagesc([180 0], [-90 90], frame);    
    colormap(jet);
    colorbar;

    xlabel(i/Fs);

    drawnow;
end