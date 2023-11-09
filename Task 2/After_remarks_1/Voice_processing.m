clc;
[data, Fs] = audioread("/MATLAB Drive/My_voice.wav");
L = length(data);
Boundfreq = 3000;
filtord = 7;

bpFilt = designfilt('bandpassfir', 'CutoffFrequency1', 80, ...
    'CutoffFrequency2', 700, 'SampleRate', Fs, 'FilterOrder', filtord);

freq_data = fft(data);

P2 = abs(freq_data/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

fprintf("Т.к. частота звука буквы 'A' не превышает 3000 Гц все " + ...
    "частоты выше могут не учитываться.")


f = Fs/L*(0:(L/2));
f_length = length(f);
f1 = f(1:Boundfreq);
P1_1 = P1(1:Boundfreq);
P1_log = 10*log(P1_1);

[argvalue, argmax] = max(P1_1);
fprintf("\nОсновной тон голоса равен примерно %.2f Hz.\n", f1(argmax));


fig1 = figure;
subplot(2, 1, 1)
plot(f1, P1_log, "LineWidth", 3);
title("Logarithm spectrum of voice")
xlabel("f(Hz)")

subplot(2, 1, 2)
plot(f1, P1_1, "LineWidth",3);
title("Single-Sided Amplitude Spectrum of voice")
xlabel("f (Hz)")

savefig(fig1, "Amp_and_log_spectrum_of_voice.fig")