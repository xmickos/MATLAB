clear global; clc;
dims = 128;
Fs = 1e3;
SNR = 37;
S = zeros(1, dims);
eps = 0.001;


S(5)  = 1;
S(10) = 2;
S(60) = 3;

F = ifft(S, dims);


h1 = figure;
plot(abs(F));
xlim([0 length(F) + 1]);
xlabel('Time');
ylabel('Amplitude');
title("Signal plot in time domain");
savefig(h1, "Signal_plot.fig");

Signal = F;

%                   ------Задание 2 – Noise Generation------

NoisedSignal = NoiseGenerator(SNR, Signal);

%                   ------Задание 3 – Powers of Signals------

% Расчет средней мощности сигнала, шума и зашумленного сигнала
P_Signal = PowerSignal(Signal);
P_Noise = PowerSignal(NoisedSignal - Signal);
P_NoisedSignal = PowerSignal(NoisedSignal);

%                   ------Задание 4 – Perseval Theorem------

% Вычисление спектров исходного сигнала и шума
SignalSpec = abs(fft(Signal)).^2;
NoiseSpec = abs(fft(NoisedSignal - Signal)).^2;

% Вычисление спектра результирующего сигнала
NoisedSignalSpec = abs(fft(NoisedSignal)).^2;

% Вычисление средних мощностей спектров сигналов
P_SignalSpec = PowerSignal(SignalSpec);
P_NoiseSpec = PowerSignal(NoiseSpec);
P_NoisedSignalSpec = PowerSignal(NoisedSignalSpec);

if abs(P_Signal - P_SignalSpec) <= eps && abs(P_Noise - P_NoiseSpec) <= eps && abs(P_NoisedSignal - P_NoisedSignalSpec) <= eps
    fprintf("True.\n");
else
    fprintf("False.\n");
end


FilteredNoisedSignal = FilterSignal(NoisedSignal);

%                   ------Задание 6 – SNR comparison------


snr_filtered = 10 * log10(PowerSignal(FilteredNoisedSignal) / P_Noise);
snr_unfiltered = 10 * log10(P_Signal / P_Noise);

fprintf("\nComparation of two SNRs:\nFiltered signal: %1.3f\nUnfiltered " + ...
    "Signal: %1.3f\nSNR_filtered - SNR_unfiltered: %1.3f" + ...
    "\n",snr_filtered, snr_unfiltered, snr_filtered - snr_unfiltered);
fprintf("It seems that after filtering, the signal became less " + ...
    "distinguishable, as the SNR decreased...\n");

function NoisedSignal = NoiseGenerator(SNR, Signal)
    % Зашумление сигнала
    signalPower = norm(Signal)^2;
    noisePower = signalPower / (10^(SNR/10));
    
    if isreal(Signal)
        Noise = normrnd(0, sqrt(noisePower), size(Signal));
    else
        Noise = complex(normrnd(0, sqrt(noisePower/2), size(Signal)), ...
                        normrnd(0, sqrt(noisePower/2), size(Signal)));
    end
    
    NoisedSignal = Signal + Noise;
end


function power = PowerSignal(Signal)
    % Расчет средней мощности сигнала
    power = mean(abs(Signal).^2);
end

function FilteredNoisedSignal = FilterSignal(NoisedSignal)
    % Фильтрация с помощью bandpass
    Fs = 1e3;
    FilteredNoisedSignal = bandpass(NoisedSignal,[15 55], Fs);
end

