clear all;
clc;
% close all;

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
x_writeable = x / max(abs(x));  % Нормировка для корректной записи.
x_writeable = x_writeable.';
x_clipped_writeable = x_clipped / max(abs(x_clipped));
audiowrite("nonclipped_sin.wav", x_writeable, Fs);
audiowrite("clipped_sin.wav", x_clipped_writeable, Fs);

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
subplot(2, 1, 1)

hold on;

plot(abs(y(1:round(end/2))), 'color', '#FFA500', 'LineWidth', 2);
title("Unclipped signal in frequency domain.")
xlabel("f (Hz)")
ylabel("Amplitude")

subplot(2, 1, 1)
plot(abs(y_clipped(1:round(end/2))), 'color', 'blue', 'LineWidth', 1.5);
title("Clipped signal in frequency domain.")
xlabel("f (Hz)")
ylabel("Amplitude")
legend('unclipped', 'clipped');

hold off;

subplot(2, 1, 2)

hold on;
plot(10*log10(abs(y(1:round(end/2)))))
title("Unclipped signal in frequency log domain.")
xlabel("f (Hz)")
ylabel("10*log10(Amplitude)")

subplot(2, 1, 2)
plot(10*log10(abs(y_clipped(1:round(end/2)))))
title("Clipped signal in frequency log domain.")
xlabel("f (Hz)")
ylabel("10*log10(Amplitude)")
legend('unclipped', 'clipped');

hold off;
savefig("Frequency_domain.fig");

