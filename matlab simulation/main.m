clear all; close all;
addpath("./functions")

load handel;
audio_base = y;

N = 2;
d = 1;

% number of test points in x and z direction
k = 64;
l = 64;

mic_mesh = genMicMesh(N, d/N*0.5);
test_points = genTestPointMesh(4, k, 4, l, 2);
delays = calcDelays(mic_mesh, test_points, Fs);

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