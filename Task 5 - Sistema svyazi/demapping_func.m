function bits = demapping_func(symbols, modulation)
    if strcmp(modulation, 'BPSK')
        threshold = 0;
        bits = real(symbols) > threshold;
    elseif strcmp(modulation, 'QPSK')
        bits = [real(symbols) > 0; imag(symbols) > 0];
    elseif strcmp(modulation, '8PSK')
        angles = angle(symbols);
        bits = de2bi(mod(floor((angles + pi) / (2 * pi) * 8), 8), 3, 'left-msb');
    elseif strcmp(modulation, '16QAM')
        bits = [real(symbols) > 0; abs(real(symbols)) == 1; imag(symbols) < 0; abs(imag(symbols)) == 1];
    else
        fprintf('Wrong modulation type\nExiting...\n');
        return;
    end
end
