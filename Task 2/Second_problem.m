clear all;
clc;

Fs = 2500; % частота дискретизации (Гц)
t = 0:1/Fs:3; % вектор времени (сек)
f = 1000; % частота синусоиды (Гц)
A = 3; % амплитуда синусоиды

x = A * sin(2*pi*f*t); % синусоида

x_clipped = x;
x_max = 2;
max_idx = x >= x_max;
min_idx = x <= -x_max;

x_clipped(max_idx) = x_max;
x_clipped(min_idx) = -x_max;

Y = fft(x);
Y_clipped = fft(x_clipped);
L = 7500;

P2 = abs(Y);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

P2_ = abs(Y_clipped);
P1_ = P2_(1:L/2+1);
P1_(2:end-1) = 2*P1_(2:end-1);

f = Fs/L*(0:(L/2));

subplot(2, 1, 1)
f1 = plot(f, P1, "LineWidth", 3, 'Color', [26/255 105/255 239/255 0.3]);
title("Amplitude Spectrum of x(t) without clipping");
xlabel("f (Hz)")
savefig("/MATLAB Drive/KMTT_Task2/spectrum_noclipping")

subplot(2, 1, 2)
f2 = plot(f, P1_, "LineWidth", 3, "DisplayName", ...
    char('With clipping'), 'Color',[19/255 100/255 45/255 0.3]);
title("Amplitude Spectrum of x(t) with clipping");
xlabel("f (Hz)")
savefig("/MATLAB Drive/KMTT_Task2/spectrum_clipped")

fprintf("As you can see, clipping led to the appearance of an" + ...
    " additional harmonic at half the frequency, as well as to a " + ...
    "weakening of the amplitude of the main harmonic")
