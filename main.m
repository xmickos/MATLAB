close all;

Roll_off_values = [0.2, 0.5, 0.8];
Nsamp_values = [4, 8, 16];
Span_values = [4, 8, 12];

%%
figure;

subplot(2, 1, 1);
hold on;

for i = 1:length(Roll_off_values)
    Roll_off = Roll_off_values(i);
    Nsamp = 8; 
    Span = 8;
    
    h = raised_cosine(Roll_off, Nsamp, Span);
  
    plot(h);
end

% Изменение числа выборок на символ

for i = 1:length(Nsamp_values)
    Roll_off = 0.5; % Значение по умолчанию
    Nsamp = Nsamp_values(i);
    Span = 8; % Значение по умолчанию

    h = raised_cosine(Roll_off, Nsamp, Span);

    plot(h);
end

% Изменение длины импульсной характеристики в символьных интервалах

for i = 1:length(Span_values)
    Roll_off = 0.5; % Значение по умолчанию
    Nsamp = 8; % Значение по умолчанию
    Span = Span_values(i);

    h = raised_cosine(Roll_off, Nsamp, Span);

    plot(h);
end

xlabel('Время');
ylabel('Значение');
title('Импульсная характеристика');
legend('Roll-off = 0.2', 'Roll-off = 0.5', 'Roll-off = 0.8', ...
    'Nsamp = 4', 'Nsamp = 8', 'Nsamp = 16', ...
    'Span = 4', 'Span = 8', 'Span = 12');

hold off;


subplot(2, 1, 2);
hold on;
% Изменение параметра Roll_off
for i = 1:length(Roll_off_values)
    % subplot(length(Roll_off_values), 1, i);
    [freq, amp] = raised_cosine_freq(Roll_off_values(i), 16, 4);
    % title(['Roll-off = ', num2str(Roll_off_values(i))]);
    plot(freq, amp); % построение графика
end


% Изменение параметра Nsamp
for i = 1:length(Nsamp_values)
    % subplot(length(Nsamp_values), 1, i);
    [freq, amp] = raised_cosine_freq(0.5, Nsamp_values(i), 4);
    plot(freq, amp); % построение графика
end

% Изменение параметра Span
for i = 1:length(Span_values)
    % subplot(length(Span_values), 1, i);
    [freq, amp] = raised_cosine_freq(0.5, 16, Span_values(i));
    plot(freq, amp); % построение графика
end
xlabel('Частота');
ylabel('Амплитуда');
title("Амплитудно-частотная характеристика");
ylim([0.8, 1.05]);
hold off;

% savefig("RC_fig.fig");








%%

figure;

subplot(2, 1, 1);
hold on;
% Изменение параметра Roll-off
for i = 1:length(Roll_off_values)
    rrc = root_raised_cosine(Roll_off_values(i), Nsamp_values(2), Span_values(2));
    plot(rrc);
end

% Изменение параметра Nsamp
for i = 1:length(Nsamp_values)
    rrc = root_raised_cosine(Roll_off_values(2), Nsamp_values(i), Span_values(2));
    plot(rrc);
end

% Изменение параметра Span
for i = 1:length(Span_values)
    rrc = root_raised_cosine(Roll_off_values(2), Nsamp_values(2), Span_values(i));
    plot(rrc);
end
title('Импульсная характеристика');
xlabel('Время');
ylabel('Значение');

legend('Roll-off = 0.2', 'Roll-off = 0.5', 'Roll-off = 0.8,', ...
    'Nsamp = 4', 'Nsamp = 8', 'Nsamp = 16,', ...
    'Span = 4', 'Span = 8', 'Span = 12');
hold off;


subplot(2, 1, 2);
hold on;
% Параметры функции rootRaisedCosineFreq
Roll_off_values = [0.2, 0.5, 0.8];
Nsamp_values = [4, 8, 12];
Span_values = [10, 20, 30];

% Изменение параметра alpha
for i = 1:length(Roll_off_values)
    % subplot(3, 1, i);
    [f, rrc_freq] = root_raised_cosine_freq(Roll_off_values(i), Nsamp_values(2), Span_values(2));
    plot(f, abs(rrc_freq)); % Выводим амплитудно-частотную характеристику
end

% Изменение параметра Fs
for i = 1:length(Nsamp_values)
    % subplot(3, 1, i);
    [f, rrc_freq] = root_raised_cosine_freq(Roll_off_values(2), Nsamp_values(i), Span_values(2));
    plot(f, abs(rrc_freq)); % Выводим амплитудно-частотную характеристику
end


% Изменение параметра span
for i = 1:length(Span_values)
    % subplot(3, 1, i);
    [f, rrc_freq] = root_raised_cosine_freq(Roll_off_values(2), Nsamp_values(2), Span_values(i));
    plot(f, abs(rrc_freq)); % Выводим амплитудно-частотную характеристику
end
xlabel('Частота (Гц)');
ylabel('Амплитуда');
hold off;
title('Амплитудно-частотная характеристика');

savefig("RRC_fig.fig");

%% 

filter_impulse_response = root_raised_cosine(Roll_off_values(2), Nsamp_values(2), Span_values(2));
filter_impulse_response = filter_impulse_response(1);
fs = 1000;
t = 0:1/fs:1;
TX_bit = randi([0 1], 1, 8000);
TX_IQ = mapping (TX_bit, "QPSK");

% фильтр
filtered_signal = filterIQSignal(TX_IQ, filter_impulse_response);

% АЧХ до фильтрации
% [f_before, mag_before] = freqz(TX_IQ(:, 1) + 1i*TX_IQ(:, 2));
[f_before, mag_before] = freqz(TX_IQ);

% АЧХ после фильтрации
[f_after, mag_after] = freqz(filtered_signal(:, 1) + 1i*filtered_signal(:, 2));

figure;
hold on;
plot(mag_before, abs(f_before), 'b', 'LineWidth', 2);
plot(mag_after, abs(f_after), 'r', 'LineWidth', 2);
hold off;
grid on;
xlabel('Частота (Гц)');
ylabel('Амплитуда');
legend('До фильтрации', 'После фильтрации');
title('АЧХ сигнала до и после фильтрации');

savefig("filtering.fig");
