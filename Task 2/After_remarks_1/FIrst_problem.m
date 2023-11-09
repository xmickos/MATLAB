clear all;
clc;
close all;

[data, Fs] = audioread("/MATLAB Drive/KMTT_Task2/task/file2.wav");
data = data.'; 
L = 2000;

% Спектр считанного сигнала
y_freqs = fft(data);

% Поскольку спектр возвращается симметричный, искать максимумы будем
% только в первой половине.

[argmaxs, maxs] = maxk(y_freqs(1:end/2), 3);
fprintf("Three main harmonics are: %3.f Hz," + ...
    " %3.f Hz and %3.f Hz\n", maxs(1), maxs(2), maxs(3));

% Отфильтруем сигнал, исключив из него все гармоники кроме трёх искомых:

filtered_y = zeros(1, Fs, "double");
filtered_y(maxs) = y_freqs(maxs);
filtered_y(Fs - maxs + 1) = y_freqs(maxs);


% Сравнение спектров изначального и отфильтрованного сигналов
figure;
subplot(2, 1, 1)
plot(abs(y_freqs(1:end/2)));
title("Unfiltered signal spectrum.");
xlabel("f (Hz)")
ylabel("Amplitude")

subplot(2, 1, 2)
plot(abs(filtered_y(1:end/2)))
title("Filtered signal spectrum.");
xlabel("f (Hz)");
ylabel("Amplitude");

filtered_signal = ifft(filtered_y);

% Сравнение графиков изначального и отфильтрованного сигналов

figure;
subplot(2, 1, 1)
plot(data)
title("Unfiltered signal in time domain")
xlabel("f (Hz)")
ylabel("Amplitude");
ylim([-1.5 1.5])

subplot(2, 1, 2)
plot(abs(filtered_signal(1:end/2)))
title("Filtered signal in time domain.");
xlabel("f (Hz)");
ylabel("Amplitude");
ylim([-1.5 1.5])

