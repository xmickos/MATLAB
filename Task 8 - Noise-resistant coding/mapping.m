function [IQ] = mapping(Bit_Tx, Constellation)
    % Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
    % calculate the Bit_depth for each contellation
    
    [Dictionary, Bit_depth_Dict] = constellation_func(Constellation);
    
    IQ = zeros(1, length(Bit_Tx) / Bit_depth_Dict);

    switch Constellation
        case 'BPSK'
            fprintf('BPSK case!\n');
            % IQ = zeros(2, length(Bit_Tx)/Bit_depth_Dict);
            for i = 1 : length(Bit_Tx)                    % for -> parfor
    %             fprintf('mod = %d\n', mod(i, 2) + 1);
                IQ(i) = Dictionary(Bit_Tx(i) + 1);
            end
        case 'QPSK'
            fprintf('QPSK case!\nlength(Bit_Tx) = %d\n', length(Bit_Tx));
            q = 1;
            i = 1;
            % for i = 1 : length(Bit_Tx) - 1                % for -> parfor
                while i < length(Bit_Tx)
                str = '';
                str(1) = num2str(Bit_Tx(i));
                str(2) = num2str(Bit_Tx(i + 1));
    
                IQ(q) = Dictionary(bin2dec(str) + 1);

                q = q + 1;
                i = i + 2;
            end
        case '8PSK'
            fprintf("8PSK case!\nlength(Bit_Tx) = %d\n", length(Bit_Tx));
            q = 1;
            i = 1;
            while i <= length(Bit_Tx) - 2
                str = '';
                str(1) = num2str(Bit_Tx(i));
                str(2) = num2str(Bit_Tx(i + 1));
                str(3) = num2str(Bit_Tx(i + 2));


                IQ(q) = Dictionary(bin2dec(str) + 1);
                i = i + 3;
                q = q + 1;
            end
    
    
        case '16QAM'
            fprintf('16QAM case!\nlength(Bit_Tx) = %d\n', length(Bit_Tx));
            q = 1;
            i = 1;
            while i <= length(Bit_Tx) - 3
                str = '';
                str(1) = num2str(Bit_Tx(i));
                str(2) = num2str(Bit_Tx(i + 1));
                str(3) = num2str(Bit_Tx(i + 2));
                str(4) = num2str(Bit_Tx(i + 3));
                
                IQ(q) = Dictionary(bin2dec(str) + 1);
                i = i + 4;
                q = q + 1;
            end
    end

end
