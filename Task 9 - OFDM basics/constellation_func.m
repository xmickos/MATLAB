function [Dictionary, Bit_depth_Dict] = constellation_func(Constellation)

    switch Constellation
        case "BPSK"
            Dictionary(1) = -1 + 1i*0;
            Dictionary(2) =  1 + 1i*0;
            Bit_depth_Dict = 1;

        case "QPSK"
            Dictionary(1) = -1-1i;
            Dictionary(2) = -1+1i;
            Dictionary(3) =  1-1i;
            Dictionary(4) =  1+1i;
            Bit_depth_Dict = 2;

        case "8PSK"
            Dictionary(1) = -sqrt(2)/2 -1i*sqrt(2)/2;
            Dictionary(2) = -1 + 0i;
            Dictionary(3) =  0 + 1i;
            Dictionary(4) = -sqrt(2)/2 + 1i*sqrt(2)/2;
            Dictionary(5) =  0 - 1i;
            Dictionary(6) =  sqrt(2)/2 - 1i*sqrt(2)/2;
            Dictionary(7) =  sqrt(2)/2 + 1i*sqrt(2)/2;
            Dictionary(8) =  1 + 0i;

            Bit_depth_Dict = 3;

        case "16-QAM"
            Dictionary(1)  = -3+3i;
            Dictionary(2)  = -3+1i;
            Dictionary(3)  = -3-3i;
            Dictionary(4)  = -3-1i;
            Dictionary(5)  = -1+3i;
            Dictionary(6)  = -1+1i;
            Dictionary(7)  = -1-3i;
            Dictionary(8)  = -1-1i;
            Dictionary(9)  =  3+3i;
            Dictionary(10) =  3+1i;
            Dictionary(11) =  3-3i;
            Dictionary(12) =  3-1i;
            Dictionary(13) =  1+3i;
            Dictionary(14) =  1+1i;
            Dictionary(15) =  1-3i;
            Dictionary(16) =  1-1i;
            Bit_depth_Dict = 4;
    end
     
    norm = sqrt(sum(Dictionary.*(conj(Dictionary)))/length(Dictionary));
    Dictionary = Dictionary./norm;

end

