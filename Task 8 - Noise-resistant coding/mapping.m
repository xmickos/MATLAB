function [IQ] = mapping(Bit_Tx, Constellation)
    % Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
    % calculate the Bit_depth for each contellation
    
    [Dictionary, Bit_depth_Dict] = constellation_func(Constellation);
    
    IQ = zeros(1, length(Bit_Tx)/Bit_depth_Dict);
    fprintf('Dictionary:\nDictionary(1) = %d + %d j,\nDictionary(2) = %d + %d j,\n', ...
        real(Dictionary(1)), imag(Dictionary(1)), real(Dictionary(2)), imag(Dictionary(2)));
    fprintf('Dictionary(3) = %d + %d j,\nDictionary(4) = %d + %d j,\n', ...
        real(Dictionary(3)), imag(Dictionary(3)), real(Dictionary(4)), imag(Dictionary(4)));
    
    switch Constellation
        case 'BPSK'
            fprintf('BPSK case!\n');
    %         IQ = zeros(2, length(Bit_Tx)/Bit_depth_Dict);
            for i = 1 : length(Bit_Tx)                    % for -> parfor
    %             fprintf('mod = %d\n', mod(i, 2) + 1);
                IQ(i) = Dictionary(mod(i, 2) + 1);
            end
        case 'QPSK'
            fprintf('QPSK case!\nlength(Bit_Tx) = %d\n', length(Bit_Tx));
            q = 1;
            for i = 1 : length(Bit_Tx) - 1                % for -> parfor
                str = '';
                str(1) = num2str(Bit_Tx(i));
                str(2) = num2str(Bit_Tx(i + 1));
    
    %             strcat(str, num2str(Bit_Tx(i : i + 3)));
%                 fprintf("str: %s, str2num(str) = %d, bin2dec(str) + 1 = %d, Dictionary(...) = %d + %d j\n", ...
%                     str, str2num(str), bin2dec(str) + 1, real(Dictionary(bin2dec(str) + 1)), imag(Dictionary(bin2dec(str) + 1)));
                IQ(q) = Dictionary(bin2dec(str) + 1);
%                 fprintf("IQ(%d) = %d + %d j\n", q, real(IQ(q)), imag(IQ(q)));
                q = q + 1;
                i = i + 1;
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
                
%                 fprintf('bin2dec(Str)+1 = %d, q = %d\n', bin2dec(str) + 1, q);

                IQ(q) = Dictionary(bin2dec(str) + 1);
                i = i + 4;
                q = q + 1;
            end
    end

    fprintf("Output: IQ_(1) = %d + %d j\n", real(IQ(1)), imag(IQ(1)));
    fprintf("Output: IQ_(2) = %d + %d j\n", real(IQ(2)), imag(IQ(2)));
end
