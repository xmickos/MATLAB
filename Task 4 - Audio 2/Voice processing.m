clc;
[data, Fs] = audioread("/MATLAB Drive/My_voice.wav");
L = length(data);
boundfreq = 3000;
filtord = 7;


bpFilt = designfilt('bandpassfir', 'CutoffFrequency1', 80, ...
    'CutoffFrequency2', 700, 'SampleRate', Fs, 'FilterOrder', filtord);

data = filter(bpFilt, data);
freq_data = fft(data);

P2 = abs(freq_data/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs/L*(0:(L/2));

fig1 = figure;
subplot(2, 1, 1)
p1 = plot(f,P1,"LineWidth",3);
title("Single-Sided Amplitude Spectrum of voice")
xlim([0 boundfreq]);
xlabel("f (Hz)")
ylabel("|P1(f)|")

subplot(2, 1, 2)
p2 = plot(f, 10*log(P1), "LineWidth",3);
title("Voice logarithmic spectrum")
xlabel("f (Hz)")
ylabel("log(X(f))")
xlim([0 boundfreq])
% ylim([-20 0])

fprintf("As we can see, the two main harmonics have frequencies " + ...
    "of approximately 128 and 255 Hertz, respectively")

savefig(fig1, "Amp and log spectrum of voice.fig");
