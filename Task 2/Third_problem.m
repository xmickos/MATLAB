clear all;
[data, Fs] = audioread("/MATLAB Drive/KMTT_Task2/task/file2.wav");
L = length(data);

data_lower = ones(1, Fs/2);
for i = 1:Fs/2
    data_lower(i) = data(2*i);
end


audiowrite("/MATLAB Drive/KMTT_Task2/lower_frequency.wav", data_lower, Fs/2);

fprintf("After reducing the sampling rate by half, the signal became " + ...
    "lower by ear, less 'trembling'.\n")

data_higher = ones(1, Fs*2);
for i = 1:Fs
    data_higher(2*i) = data(i);
end

data_higher(1) = data_higher(2) / 2;
for i = 3:Fs - 1
    data_higher(i) = (data_higher(i - 1) + data_higher(i + 1)) / 2;
    i = i + 1;
end

audiowrite("/MATLAB Drive/KMTT_Task2/higher_frequency.wav", data_lower, 2*Fs);

fprintf("After increasing the sampling rate, the signal became much " + ...
    "higher, the length of the audio track decreased.\n");

freq_data = fft(data);
freq_lower_data = fft(data_lower);
freq_higher_data = fft(data_higher);

data_ticks = linspace(1, L);

P2_1 = abs(freq_data);
P1_1 = P2_1(1:L/2+1);
P1_1(2:end-1) = 2*P1_1(2:end-1);

P2_2 = abs(freq_lower_data);
P1_2 = P2_2(1:L/4);
P1_2(2:end-1) = 2*P1_2(2:end-1);

P2_3 = abs(freq_higher_data);
P1_3 = P2_3(1:L+1);
P1_3(2:end-1) = 2*P1_3(2:end-1);

subplot(3, 1, 1)
f1 = plot(P1_1, "LineWidth", 3, 'Color', [26/255 105/255 239/255 0.3]);
title("Amplitude Spectrum of given signal.");
xlim([0 1200])
xlabel("f (Hz)")
savefig("/MATLAB Drive/KMTT_Task2/spectrum_initial")

subplot(3, 1, 2)
f2 = plot(P1_2, "LineWidth", 3, 'Color', [26/255 105/255 239/255 0.3]);
title("Amplitude Spectrum of signal with reduced frequency rate");
xlim([0 600])
xlabel("f (Hz)")
savefig("/MATLAB Drive/KMTT_Task2/spectrum_downsampled")



subplot(3, 1, 3)
f3 = plot(P1_3, "LineWidth", 3, 'Color', [26/255 105/255 239/255 0.3]);
title("Amplitude Spectrum of signal with increased frequency rate");
xlim([0 2500])
xlabel("f (Hz)")
savefig("/MATLAB Drive/KMTT_Task2/spectrum_upsampled")





