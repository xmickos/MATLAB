function [freq, rrc_freq] = root_raised_cosine_freq(Roll_off, Nsamp, Span)
    Ts = 1/Nsamp; 
    t = -Span*Ts:Ts:Span*Ts; 
    
    freq = linspace(-0.5/Ts, 0.5/Ts, length(t));     
    rrc_freq = sqrt(raised_cosine_freq(Roll_off, Nsamp, Span));
    
end