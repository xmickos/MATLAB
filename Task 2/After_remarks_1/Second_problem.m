clear all;
clc;
close all;

Fs = 2500; % частота дискретизации (Гц)
t = 0:1/Fs:3; % вектор времени (сек)
f = 1000; % частота синусоиды (Гц)
A = 3; % амплитуда синусоиды

x = A * sin(2*pi*f*t); % синусоида

x_clipped = x;

x_max = 2;
max_idx = (x > x_max);
min_idx = (x < -x_max);

x_clipped(max_idx) = x_max;
x_clipped(min_idx) = -x_max;

audiowrite("nonclipped_sin.wav", x, Fs);
audiowrite("clipped_sin.wav", x_clipped, Fs);

figure;
subplot(2, 1, 1)

plot(x(1:100))
xlabel("t, с")
ylabel("Amplitude")
title("Unclipped signal in time domain.")

subplot(2, 1, 2)

plot(x_clipped(1:100))
xlabel("t, с")
ylabel("Amplitude")
title("Clipped signal in time domain.")

savefig("Time_domain.fig");

y = fft(x);
y_clipped = fft(x_clipped);

figure;

subplot(2, 1, 2)
plot(abs(y(1:round(end/2))))
title("Unclipped signal in frequency domain.")
xlabel("f (Hz)")
ylabel("Amplitude")

subplot(2, 1, 1)
plot(abs(y_clipped(1:round(end/2))))
title("Clipped signal in frequency domain.")
xlabel("f (Hz)")
ylabel("Amplitude")

savefig("Frequency_domain.fig")

figure;

subplot(2, 1, 2)
plot(10*log10(abs(y(1:round(end/2)))))
title("Unclipped signal in frequency log domain.")
xlabel("f (Hz)")
ylabel("10*log10(Amplitude)")

subplot(2, 1, 1)
plot(10*log10(abs(y_clipped(1:round(end/2)))))
title("Clipped signal in frequency log domain.")
xlabel("f (Hz)")
ylabel("10*log10(Amplitude)")

savefig("Log_frequency_domain.fig");

