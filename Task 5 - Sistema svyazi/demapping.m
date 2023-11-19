function bits = demapping(symbols)
    bits_bpsk =  demapping_func(symbols, 'BPSK');
    bits_qpsk =  demapping_func(symbols, 'QPSK');
    bits_8psk =  demapping_func(symbols, '8PSK');
    bits_16qam = demapping_func(symbols, '16QAM');
end
