function index = Metric(vecs, Constellation)
    switch Constellation
        case 'BPSK'
            index = zeros(1, length(vecs));
            [Dictionary, ~] = constellation_func('BPSK');

            [~, trash] = min([abs(vecs(1) - Dictionary(1)), abs(vecs(1) - Dictionary(2))]);
            fprintf('output index: %d\n', trash);
            for i = 1 : length(vecs)
                 [~, index(i)] = min([abs(vecs(i) - Dictionary(1)), abs(vecs(i) - Dictionary(2))]);
            end
        case 'QPSK'
            index = zeros(1, round(length(vecs) / 2));
            [Dictionary, ~] = constellation_func('QPSK');

            for i = 1 : round(length(vecs) / 2)
                rho_array = zeros(1, 4);
                for j = 1 : 4
                    rho_array(j) = abs(vecs(i) - Dictionary(j));
                end
                [~, index(i)] = min(rho_array);
            end
            
        case '8PSK'
            index = zeros(1, round(length(vecs) / 3));
            [Dictionary, ~] = constellation_func('8PSK');
            rho_array = zeros(1, 8);
            for i = 1 : round(length(vecs) / 3)
                for j = 1 : 8
                    rho_array(j) = abs(vecs(i) - Dictionary(j));
                end
                [~, index(i)] = min(rho_array);
            end
        case '16QAM'
            index = zeros(1, round(length(vecs) / 4));
            [Dictionary, ~] = constellation_func('16QAM');
            rho_array = zeros(1, 16);
            for i = 1 : round(length(vecs) / 4)
                for j = 1 : 16
                    rho_array(j) = abs(vecs(i) - Dictionary(j));
                end
                [~, index(i)] = min(rho_array);
            end
    end
end