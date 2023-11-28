function [Eb_N0] = Eb_N0_convert(SNR, Constellation)
    switch Constellation
        case 'BPSK'
            bit_depth = 1;
        case 'QPSK'
            bit_depth = 2;
        case '8PSK'
            bit_depth = 3;
        case '16QAM'
            bit_depth = 4;
    end
    
    Eb_N0 = SNR - 10*log10(bit_depth);
end

