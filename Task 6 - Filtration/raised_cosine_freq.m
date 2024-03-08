function [freq, amp] = raised_cosine_freq(Roll_off, Nsamp, Span)
    Ts = 1/Nsamp; 
    t = -Span*Ts:Ts:Span*Ts;
    
    freq = linspace(-0.5/Ts, 0.5/Ts, length(t)); 
    
    amp = zeros(size(freq)); 
    
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