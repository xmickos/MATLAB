clear global; clc;
dims = 128;
Fs = 1e3;
SNR = 37;
S = zeros(1, dims);
eps = 0.001;

rng(2000);


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
fprintf("\t\t\tTask 4 - Perseval Theorem\n");

% Вычисление спектров исходного сигнала и шума
SignalSpec = abs(fft(Signal)).^2;
NoiseSpec = abs(fft(NoisedSignal - Signal)).^2;

% Вычисление спектра результирующего сигнала
NoisedSignalSpec = abs(fft(NoisedSignal)).^2;

% Вычисление средних мощностей спектров сигналов
P_SignalSpec = sum(SignalSpec) / length(SignalSpec);
P_NoiseSpec = PowerSignal(NoiseSpec);
P_NoisedSignalSpec = sum(NoisedSignalSpec) / length(NoisedSignalSpec);

p_signal = sum(abs(Signal.^2));
p_signalspec = sum(SignalSpec);

fprintf("Perseval theorem verification: ");
if abs(P_Signal * length(Signal) - P_SignalSpec) <= eps &&      ...
        abs(P_Noise * length(Signal) - P_NoiseSpec) <= eps &&   ...
        abs(P_NoisedSignal * length(NoisedSignal) - P_NoisedSignalSpec) <= eps
    fprintf("True.\n");
else
    fprintf("False.\n");
end


FilteredNoisedSignal = FilterSignal(NoisedSignal);

%                   ------Задание 6 – SNR comparison------
fprintf("\n\t\t\tTask 6 - SNR comparation.\n");

snr_filtered = 10 * log10(PowerSignal(FilteredNoisedSignal) / P_Noise);
snr_unfiltered = 10 * log10(P_Signal / P_Noise);

fprintf("Comparation of two SNRs:\nFiltered signal: %1.3f\nUnfiltered " + ...
    "Signal: %1.3f\nSNR_filtered - SNR_unfiltered: %1.3f" + ...
    "\n",snr_filtered, snr_unfiltered, snr_filtered - snr_unfiltered);
fprintf("As we can see, after filtering, the SNR increased, which " + ...
    "indicates an improvement in signal quality.\n");


function power = PowerSignal(Signal)
    % Расчет средней мощности сигнала
    power = mean(abs(Signal).^2);
end

function FilteredNoisedSignal = FilterSignal(NoisedSignal)

    abs_spectrum = abs(fft(NoisedSignal));
    abs_spectrum = abs_spectrum(1:round(end/2));

    filter = ones(1, length(abs_spectrum));
    filter(15:55) = 0;

    FilteredNoisedSignalSpectrum = abs_spectrum .* filter;
    FilteredNoisedSignal = ifft(FilteredNoisedSignalSpectrum);
end



function NoisedSignal = NoiseGenerator(SNR, Signal)
    % генерация белого шума с мощностью, заданной в SNR

    % вычисление мощности сигнала
    Psignal = sum(abs(Signal).^2)/length(Signal);

    % вычисление мощности шума
    Pnoise = Psignal / (10 ^ (SNR / 10));
    
    % генерация белого шума
    Noise = normrnd(0, sqrt(Pnoise/2), size(Signal)) + 1i*normrnd(0, sqrt(Pnoise/2), size(Signal));
    
    % сложение сигнала и шума
    NoisedSignal = Signal + Noise;
end

