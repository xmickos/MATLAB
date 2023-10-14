clear all;

clear all;
[data, Fs] = audioread("/MATLAB Drive/KMTT_Task2/task/file2.wav");
L = 2000;

data = bandpass(data, [140, 360], Fs);

Y = fft(data);

P2 = abs(Y);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs/L*(0:(L/2));

plot(f,P1,"LineWidth",1)
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
savefig("/MATLAB Drive/KMTT_Task2/spectrum")

pred_answer = maxk(P1, 3);
answer = zeros(1, 3);
answer(1) = find(P1 == pred_answer(1));
answer(2) = find(P1 == pred_answer(2));
answer(3) = find(P1 == pred_answer(3));
answer = sort(answer);
fprintf("Three main harmonics are: %d Hz, %d Hz and %d Hz\n", ...
    answer(1), answer(2), answer(3))
