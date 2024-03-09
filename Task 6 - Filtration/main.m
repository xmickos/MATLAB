close all;

Roll_off_values = [0, 0.5, 1];
Nsamp_values = [2, 8, 16];
Span_values = [10, 20, 30];

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

% Изменение параметра Nsamp

for i = 1:length(Nsamp_values)
    Roll_off = 0.5; 
    Nsamp = Nsamp_values(i);
    Span = 8;

    h = raised_cosine(Roll_off, Nsamp, Span);

    plot(h);
end

% Изменение параметра Span

for i = 1:length(Span_values)
    Roll_off = 0.5; 
    Nsamp = 8; 
    Span = Span_values(i);

    h = raised_cosine(Roll_off, Nsamp, Span);

    plot(h);
end

xlabel('Время');
ylabel('Значение');
title('Импульсная характеристика');
legend('Roll-off = 0', 'Roll-off = 0.5', 'Roll-off = 1', ...
    'Nsamp = 4', 'Nsamp = 8', 'Nsamp = 16', ...
    'Span = 10', 'Span = 20', 'Span = 30');

hold off;


subplot(2, 1, 2);
hold on;
% Изменение параметра Roll_off
for i = 1:length(Roll_off_values)
    [freq, amp] = raised_cosine_freq(Roll_off_values(i), 16, 4);
    plot(freq, amp); 
end


% Изменение параметра Nsamp
for i = 1:length(Nsamp_values)
    [freq, amp] = raised_cosine_freq(0.5, Nsamp_values(i), 4);
    plot(freq, amp); 
end

% Изменение параметра Span
for i = 1:length(Span_values)
    [freq, amp] = raised_cosine_freq(0.5, 16, Span_values(i));
    plot(freq, amp); 
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
    rrc = root_raised_cosine(Roll_off_values(i), Nsamp_values(1), Span_values(1));
    plot(rrc);
end

% Изменение параметра Nsamp
for i = 1:length(Nsamp_values)
    rrc = root_raised_cosine(Roll_off_values(2), Nsamp_values(i), Span_values(1));
    plot(rrc);
end

% Изменение параметра Span
for i = 1:length(Span_values)
    rrc = root_raised_cosine(Roll_off_values(2), Nsamp_values(1), Span_values(i));
    plot(rrc);
end
title('Импульсная характеристика');
xlabel('Время');
ylabel('Значение');

legend('Roll-off = 0', 'Roll-off = 0.5', 'Roll-off = 1', ...
    'Nsamp = 4', 'Nsamp = 8', 'Nsamp = 16', ...
    'Span = 10', 'Span = 20', 'Span = 30');
hold off;


subplot(2, 1, 2);
hold on;

for i = 1:length(Roll_off_values)
    [f, rrc_freq] = root_raised_cosine_freq(Roll_off_values(i), Nsamp_values(1), Span_values(1));
    plot(f, rrc_freq); 
end

for i = 1:length(Nsamp_values)
    [f, rrc_freq] = root_raised_cosine_freq(Roll_off_values(2), Nsamp_values(i), Span_values(1));
    plot(f, rrc_freq);
end


for i = 1:length(Span_values)
    [f, rrc_freq] = root_raised_cosine_freq(Roll_off_values(2), Nsamp_values(1), Span_values(i));
    plot(f, rrc_freq); 
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
filtered_signal = filterIQSignal(TX_IQ, filter_impulse_response, 2, 1);

% АЧХ до фильтрации
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
