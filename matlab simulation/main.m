clear all; close all;
addpath("./functions")

load handel;
% y = audioresample(y,InputRate=Fs,OutputRate=16000);
audio_base = y;
% Fs = 16000;

N = 4;
d = 1;

mic_mesh = genMicMesh(N, d/N*0.5);
test_points = genTestPointMesh(0.05, 0.05);
delays = calcDelays(mic_mesh, test_points, Fs, 4*d);

audio = simulateAudioSource(2*pi/3, 0, 4, audio_base, Fs, mic_mesh);

packet_size = 400 - 1;

j = 0;

for i = 1:100:size(audio_base, 1) - packet_size

    audio_packets(:, :) = audio(:, i:i+packet_size);

    frame = beamFormDAS(audio_packets, delays);

    s = sqrt(size(frame, 2));
    frame = reshape(frame, [s s]);

    % clims = [1.5 3];
    % nexttile(1);
    imagesc(-180:1:0, -90:1:90, frame);    
    colormap(jet);
    colorbar;
    % nexttile(2);
    % plot(audio_packets(1, :));
    xlabel(i/Fs);
    % axis image;
    frameFileName = sprintf('./frames_2fs/frame_%04d.png', j); % Example filename format
    print(gcf, frameFileName, '-dpng');
    % drawnow;'

    j = j + 1;


end