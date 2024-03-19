function frame = beamFormDAS(audio_packets, delays);

n = size(delays, 2);

parfor i = 1:1:n
    frame(i) = rms(sum(delayAudioPackets(audio_packets, delays(:, i)),2));
end

%frame = normalize(frame, "range");

end


function audio = delayAudioPackets(audio_packets, delays)

audio = delayseq(audio_packets', delays);

end

