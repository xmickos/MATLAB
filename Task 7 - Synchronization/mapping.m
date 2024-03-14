function [IQ] = mapping(Bit_Tx, Constellation)
    % Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
    % calculate the Bit_depth for each contellation
    
    [Dictionary, Bit_depth_Dict] = constellation_func(Constellation);
    
    IQ = zeros(1, length(Bit_Tx)/(2^Bit_depth_Dict));

   switch Constellation
        case 'BPSK'
            for i = 1 : length(Bit_Tx)                    % for -> parfor
                % IQ(i) = Dictionary(mod(num2str(Bit_Tx(i)), 2) + 1);
                IQ(i) = 2*Bit_Tx(i) - 1;
            end
        case 'QPSK'
            q = 1;
            for i = 1 : 2 : length(Bit_Tx) - 1                % for -> parfor
                str = '';
                str(1) = num2str(Bit_Tx(i));
                str(2) = num2str(Bit_Tx(i + 1));

                IQ(q) = Dictionary(bin2dec(str) + 1);
                % fprintf("srt: %s, IQ: %d %d\n", str, real(IQ(q)), imag(IQ(q)));

                q = q + 1;
            end
        case '8PSK'
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
