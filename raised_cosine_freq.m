function [freq, amp] = raised_cosine_freq(Roll_off, Nsamp, Span)
    Ts = 1/Nsamp; % время дискретизации
    t = -Span*Ts:Ts:Span*Ts; % вектор времени
    
    freq = linspace(-0.5/Ts, 0.5/Ts, length(t)); % вектор частот
    
    amp = zeros(size(freq)); % инициализация вектора амплитуд
    
    for i = 1:length(freq)
        if abs(freq(i)) <= (1-Roll_off)/(2*Ts)
            amp(i) = 1;
        elseif abs(freq(i)) > (1+Roll_off)/(2*Ts)
            amp(i) = 0;
        else
            amp(i) = 0.5*(1 + cos(pi * Ts / (Roll_off)*(abs(freq(i)) - (1-Roll_off)/(2*Ts))));
        end
    end
    
 
end