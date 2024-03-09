function filtered_signal = filterIQSignal(iq_signal, filter_impulse_response, nsamp, UpSample)
    if(UpSample == 1)
        iq_signal = upsample(iq_signal, nsamp);
    end

    filtered_i = conv(iq_signal(:, 1), filter_impulse_response);
    
    filtered_q = conv(iq_signal(:, 2), filter_impulse_response);
    
    filtered_signal = [filtered_i, filtered_q];
end