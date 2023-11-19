function mapping(input_vector)
    % BPSK созвездие
    bpsk_symbols = 2 * input_vector - 1;
    scatterplot(bpsk_symbols);
    title('BPSK созвездия');
    
    % QPSK созвездия
    qpsk_symbols = (2 * input_vector(1:2:end) - 1) + 1i*(2 * input_vector(2:2:end) - 1);
    scatterplot(qpsk_symbols);
    title('QPSK созвездия');
    
    % 8PSK созвездия
    % Всего 8 точек <-> между любыми двумя точками угол pi/4 => точки
    % всевозможные варианты получаются поворотами точки (1, 0) на 0, pi/4,
    % pi/2 и так далее.
    phase_offsets = [0, pi/4, pi/2, 3*pi/4, pi, 5*pi/4, 3*pi/2, 7*pi/4];
    eight_psk_symbols = exp(1i * phase_offsets(input_vector + 1));
    scatterplot(eight_psk_symbols);
    title('8PSK созвездия');

    % 16-QAM созвездия
    j = 0;
    sixtenn_qam_symbols = zeros(int16(length(input_vector)/4), 2);
    if mod(length(input_vector), 4) ~= 0
        fprintf("\nInput error: bad input vector.\nExiting...\n");
        return;
    end
    i = 1;
    while(j < length(input_vector)/4)
        j = j + 1;
        var = input_vector(i:i+3);
        if var == [0 0 0 0]
            sixtenn_qam_symbols(j, 1) = -3;
            sixtenn_qam_symbols(j, 2) =  3;
        end
        if var == [0 0 0 1]
            sixtenn_qam_symbols(j, 1) = -3;
            sixtenn_qam_symbols(j, 2) =  1;
        end
        if var == [0 0 1 0]
            sixtenn_qam_symbols(j, 1) = -3;
            sixtenn_qam_symbols(j, 2) = -3;
        end
        if var == [0 0 1 1]
            sixtenn_qam_symbols(j, 1) = -3;
            sixtenn_qam_symbols(j, 2) = -1;
        end
        if var == [0 1 0 0]
            sixtenn_qam_symbols(j, 1) = -1;
            sixtenn_qam_symbols(j, 2) =  1;
        end
        if var == [0 1 0 1]
            sixtenn_qam_symbols(j, 1) = -1;
            sixtenn_qam_symbols(j, 2) =  1;
        end
        if var == [0 1 1 0]
            sixtenn_qam_symbols(j, 1) = -1;
            sixtenn_qam_symbols(j, 2) = -3;
        end
        if var == [0 1 1 1]
            sixtenn_qam_symbols(j, 1) = -1;
            sixtenn_qam_symbols(j, 2) = -1;
        end
        if var == [1 0 0 0]
            sixtenn_qam_symbols(j, 1) =  3;
            sixtenn_qam_symbols(j, 2) =  3;
        end
        if var == [1 0 0 1]
            sixtenn_qam_symbols(j, 1) = 3;
            sixtenn_qam_symbols(j, 2) = 1;
        end
        if var == [1 0 1 0]
            sixtenn_qam_symbols(j, 1) =  3;
            sixtenn_qam_symbols(j, 2) = -3;
        end
        if var == [1 0 1 1]
            sixtenn_qam_symbols(j, 1) =  3;
            sixtenn_qam_symbols(j, 2) = -1;
        end
        if var == [1 1 0 0]
            sixtenn_qam_symbols(j, 1) =  1;
            sixtenn_qam_symbols(j, 2) =  3;
        end
        if var == [1 1 0 1]
            sixtenn_qam_symbols(j, 1) =  1;
            sixtenn_qam_symbols(j, 2) =  1;
        end
        if var == [1 1 1 0]
            sixtenn_qam_symbols(j, 1) =  1;
            sixtenn_qam_symbols(j, 2) = -3;
        end
        if var == [1 1 1 1]
            sixtenn_qam_symbols(j, 1) =  1;
            sixtenn_qam_symbols(j, 2) = -1;
        end
        i = i + 4;
    end
    scatterplot(sixtenn_qam_symbols);
    title('16-QAM созвездия');

end
