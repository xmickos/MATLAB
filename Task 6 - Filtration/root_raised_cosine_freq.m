function [freq, rrc_freq] = root_raised_cosine_freq(Roll_off, Nsamp, Span)
    % Fs = 2*Span*Nsamp; % Частота дискретизации
    % % rrc_time = sqrt(raised_cosine(Roll_off, Nsamp, Span));
    % rrc_time(isnan(rrc_time)) = 1; % Заменяем NaN значения на 1
    % 
    % % rrc_freq = fftshift(fft(rrc_time)); % Применяем преобразование Фурье и сдвигаем нулевую частоту в центр
    % f = linspace(-Fs/2, Fs/2, length(rrc_freq)); % Создаем вектор частот
    % 

    Ts = 1/Nsamp; % время дискретизации
    t = -Span*Ts:Ts:Span*Ts; % вектор времени
    
    freq = linspace(-0.5/Ts, 0.5/Ts, length(t)); % вектор частот
    
    % amp = zeros(size(freq)); % инициализация вектора амплитуд
    
    rrc_freq = sqrt(raised_cosine_freq(Roll_off, Nsamp, Span));
    
end