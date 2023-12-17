function index = Metric(vecs, Constellation)
    switch Constellation
        case 'BPSK'
            index = zeros(1, length(vecs));
            [Dictionary, ~] = constellation_func('BPSK');


            % fprintf("first two vecs:\n");
            % fprintf('1) %d + %d j\n', real(vecs(1)), imag(vecs(1)));
            % fprintf('2) %d + %d j\n', real(vecs(2)), imag(vecs(2)));
            % fprintf('Dictionary(1): %d +  %d j,\n vecs(1) - Dictionary(1) = %d + %d j\n', ...
            %     real(Dictionary(1)), imag(Dictionary(1)), real(vecs(1) - Dictionary(1)), imag(vecs(1) - Dictionary(1)));

            [~, trash] = min([abs(vecs(1) - Dictionary(1)), abs(vecs(1) - Dictionary(2))]);
            fprintf('output index: %d\n', trash);
            for i = 1 : length(vecs)
                 [~, index(i)] = min([abs(vecs(i) - Dictionary(1)), abs(vecs(i) - Dictionary(2))]);
            end
        case 'QPSK'
            index = zeros(1, round(length(vecs) / 2));
            [Dictionary, ~] = constellation_func('QPSK');

            % fprintf("first two vecs:\n");
            % fprintf('1) %d + %d j\n', real(vecs(1)), imag(vecs(1)));
            % fprintf('2) %d + %d j\n', real(vecs(2)), imag(vecs(2)));
            % fprintf('Dictionary(1): %d +  %d j,\n vecs(1) - Dictionary(1) = %d + %d j\n', ...
                % real(Dictionary(1)), imag(Dictionary(1)), real(vecs(1) - Dictionary(1)), imag(vecs(1) - Dictionary(1)));
            % fprintf('Dictionary(2): %d +  %d j,\n vecs(1) - Dictionary(2) = %d + %d j\n', ...
                % real(Dictionary(2)), imag(Dictionary(2)), real(vecs(1) - Dictionary(2)), imag(vecs(1) - Dictionary(2)));
            % fprintf('Dictionary(3): %d +  %d j,\n vecs(1) - Dictionary(3) = %d + %d j\n', ...
                % real(Dictionary(3)), imag(Dictionary(3)), real(vecs(1) - Dictionary(3)), imag(vecs(1) - Dictionary(3)));
            % fprintf('Dictionary(4): %d +  %d j,\n vecs(1) - Dictionary(4) = %d + %d j\n', ...
                % real(Dictionary(4)), imag(Dictionary(4)), real(vecs(1) - Dictionary(4)), imag(vecs(1) - Dictionary(4)));

            for i = 1 : round(length(vecs) / 2)
                rho_array = zeros(1, 4);
                for j = 1 : 4
                    rho_array(j) = abs(vecs(i) - Dictionary(j));
                    % if mod(i, 1000) == 0
                    %     fprintf("i = %d, j = %d, vecs(i) = %d + %d j, Dictionary(i) = %d + %d j\n" + ...
                    %         "rho_array(j) = %d\n", i, j, real(vecs(i)), imag(vecs(i)), real(Dictionary(j)), ...
                    %         imag(Dictionary(j)), rho_array(j));
                    %     fprintf("\n\n");
                    % end
                end
                [~, index(i)] = min(rho_array);
                % if mod(i, 1000) == 0
                %     fprintf("index(%d) = %d\n", i , index(i));
                % end
%             return;
            end
            % fprintf("IQ(1) = %d + %d j, rho_array(1) = %d\n", real(vecs(1)), imag(vecs(1)), rho_array(1));
            % fprintf("IQ(2) = %d + %d j, rho_array(2) = %d\n", real(vecs(2)), imag(vecs(2)), rho_array(2));
            % fprintf("IQ(3) = %d + %d j, rho_array(3) = %d\n", real(vecs(3)), imag(vecs(3)), rho_array(3));
            % fprintf("IQ(4) = %d + %d j, rho_array(4) = %d\n", real(vecs(4)), imag(vecs(4)), rho_array(4));

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