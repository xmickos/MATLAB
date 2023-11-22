clc;
[data, Fs] = audioread("./My_voice.wav");
L = length(data);
Boundfreq = 3000;
filtord = 7;

bpFilt = designfilt('bandpassfir', 'CutoffFrequency1', 80, ...
    'CutoffFrequency2', 700, 'SampleRate', Fs, 'FilterOrder', filtord);

freq_data = fft(data);
one_side_spectrum = abs(freq_data(1:round(end/2)));

fprintf("Т.к. частота звука буквы 'A' не превышает 3000 Гц все " + ...
    "частоты выше могут не учитываться.")

one_side_spectrum = one_side_spectrum(1:Boundfreq);

f = Fs/L*(0:(L/2));
f1 = f(1:Boundfreq);

[argvalue, argmax] = max(10*log(one_side_spectrum));
fprintf("\nОсновной тон голоса равен примерно %.2f Hz.\n", f1(argmax));


fig1 = figure;
subplot(2, 1, 1)
plot(f1, 10*log(one_side_spectrum), "LineWidth", 3);
title("Logarithm spectrum of voice")
xlabel("f(Hz)")

subplot(2, 1, 2)
plot(f1, one_side_spectrum, "LineWidth",3);
title("Single-Sided Amplitude Spectrum of voice")
xlabel("f (Hz)")

savefig(fig1, "Amp_and_log_spectrum_of_voice.fig")