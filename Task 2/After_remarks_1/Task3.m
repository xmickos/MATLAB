clear all; clc; close all;
[data, Fs] = audioread("/Users/xmickos/Desktop/MIPT/КМТТ/task/task3.wav");
L = length(data);

% Перезапись с выбором каждого второго отcчёта 

data_lower = ones(round(L/2), 2);
for i = 1:round(L/2) - 1
    data_lower(i, :) = data(2*i, :);
end

% Длительность аудиофайла осталась прежней - 34 секунды.

audiowrite("/Users/xmickos/Desktop/MIPT/КМТТ/Task 3 - Audio 1/lower_frequency.wav", data_lower, Fs/2);

fprintf("После понижения частоты дискретизации сигнал стал на слух более" + ...
    " приглушённым, высокие звуки стали звучать ниже.\n")

data_higher = ones(2*L, 2);
for i = 1:L
    data_higher(2*i, :) = data(i, :);
end

data_higher(1, :) = data_higher(2, :) / 2;
for i = 3:L - 1
    data_higher(i, :) = (data_higher(i - 1, :) + data_higher(i + 1, :)) / 2;
    i = i + 1;
end

audiowrite("/Users/xmickos/Desktop/MIPT/КМТТ/Task 3 - Audio 1/higher_frequency.wav", data_higher, 2*Fs);

fprintf("После увеличения частоты дискретизации сигнал" + ...
    "на слух стал более 'звонким', высокие звуки стали" + ...
    "слышаться чётче и ярче, в то время как \nнизкие," + ...
    "наоборот, оказались приглушены.\n");

% Вычисление спектров трёх исследуемых сигналов

P_data = calculatePower(data);
P_lower_data = calculatePower(data_lower);
P_higher_data = calculatePower(data_higher);

data = data / P_data;
data_lower = data_lower / P_lower_data;
data_higher = data_higher / P_higher_data;

freq_data = fft(data);
freq_lower_data = fft(data_lower);
freq_higher_data = fft(data_higher);


figure;
subplot(2, 1, 1)
plot(abs(freq_data(1:end/2)));
title("Amplitude Spectrum of a given signal.");
xlabel("f (Hz)")

subplot(2, 1, 2)
plot(10*log10(abs(freq_data(1:end/2))));
title("Logarithm scale spectrum of a given signal.");
xlabel("f (Hz)")

savefig("/Users/xmickos/Desktop/MIPT/КМТТ/Task 3 - Audio 1/spectrum_initial.fig")


figure;
subplot(2, 1, 1)
plot(abs(freq_lower_data(1:end/2)));
title("Amplitude Spectrum of a downsampled signal");
xlabel("f (Hz)")

subplot(2, 1, 2)
plot(10*log10(abs(freq_lower_data(1:end/2))));
title("Logarithm scale spectrum of a downsampled signal.");
xlabel("f (Hz)");
savefig("/Users/xmickos/Desktop/MIPT/КМТТ/Task 3 - Audio 1/spectrum_downsampled.fig")

figure;
subplot(2, 1, 1)
plot(abs(freq_higher_data(1:end/2)));
title("Amplitude Spectrum of signal with increased frequency rate");
xlabel("f (Hz)")

subplot(2, 1, 2)
plot(10*log10(abs(freq_higher_data(1:end/2))))
title("Logarithm spectrum of a upsampled signal.");
savefig("/Users/xmickos/Desktop/MIPT/КМТТ/Task 3 - Audio 1/spectrum_upsampled.fig")


fprintf("Как можно видеть, при увеличении частоты дискретизации спектр сигнала сжимается вдвое по оси частоты," + ...
    "это позволяет обнаружить более \nвысокие частоты т.к. спектр сигнала расширяется.\nУменьшение же частоты дискрети" + ...
    "зации вдвое приводит к 'растяжению' спектра в два раза, что может привести к потере высокочастотной информации.\n")
fprintf("Cледовательно, в случае увеличения частоты дискретизации полученный спектр совпадает с исходным в первой половине.\n" + ...
    "В случае с уменьшением – первая половина спектра изначального сигнала совпадает со спектром полученного после" + ...
    "уменьшения частоты\n дискретизации.\n");


function power = calculatePower(signal)
    power = sum(signal.^2) / length(signal);
end



