function [f, rrc_freq] = root_raised_cosine_freq(Roll_off, Nsamp, Span)
    % Ts = 1/Nsamp;
    Ts = 1;
    t = -Span*Ts:Ts:Span*Ts;
    
    f = linspace(-0.5/Ts, 0.5/Ts, length(t));

    rrc_freq = zeros(length(t));
    
    for i = 1:length(f)
        if abs(f(i)) <= (1 - Roll_off) / ( 2 * Ts)
            rrc_freq(i) = Ts;
        elseif (abs(f(i)) >= (1 - Roll_off) / ( 2 * Ts ) && abs(f(i)) <= (1 + Roll_off) / (2 * Ts))
            rrc_freq(i) = Ts/2 * (1 + cos(pi * Ts / (Roll_off) * (abs(f(i)) - (1-Roll_off)/(2*Ts))));
        else
            rrc_freq(i) = 0;
        end
    end
end