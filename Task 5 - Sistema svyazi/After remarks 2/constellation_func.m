function [Dictionary, Bit_depth_Dict] = constellation_func(Constellation)


    switch Constellation
        case "BPSK"   
%             Dictionary = zeros(2, 2);
%             Dictionary = [[-1, 0], [1, 0]];
%             Dictionary(1) = [-1, 0];
%             Dictionary(2) = [1,  0];
            Dictionary(1) = -1 + 1i * 0;
            Dictionary(2) =  1 + 1i * 0;
            Bit_depth_Dict = 1;
        case "QPSK"
%             Dictionary = zeros(2, 4);
%             Dictionary(1) = [-1, -1];
%             Dictionary(2) = [-1,  1];
%             Dictionary(3) = [1,  -1];
%             Dictionary(4) = [1,   1];
%             Dictionary = [[-1, -1], [-1, 1], [1, -1], [1, 1]];

            Dictionary(1) = -1 + 1i * (-1);
            Dictionary(2) = -1 + 1i *   1;
            Dictionary(3) =  1 + 1i * (-1);
            Dictionary(4) =  1 + 1i *   1;
            Bit_depth_Dict = 2;
        case "8PSK"
            Dictionary = [];
            Dictionary(1) = -1/sqrt(2) + 1i * (-1/sqrt(2));
            Dictionary(2) = -1 + 1i * 0;
            Dictionary(3) =  0 + 1i * 1;
            Dictionary(4) = -1/sqrt(2) + 1i * 1/sqrt(2);
            Dictionary(5) =  0 + 1i * (-1);
            Dictionary(6) =  1/sqrt(2) + 1i * (-1/sqrt(2));
            Dictionary(7) =  1/sqrt(2) + 1i * 1/sqrt(2);
            Dictionary(8) =  1 + 1i * 0;
            Bit_depth_Dict = 3;
        case "16QAM"
%             Dictionary = zeros(2, 16);
%             Dictionary(1)  = [-3,  3];
%             Dictionary(2)  = [-3,  1];
%             Dictionary(3)  = [-3,  3];
%             Dictionary(4)  = [-3, -1];
%             Dictionary(5)  = [-1,  3];
%             Dictionary(6)  = [-1,  1];
%             Dictionary(7)  = [-1, -3];
%             Dictionary(8)  = [-1, -1];
%             Dictionary(9)  = [3,   3];
%             Dictionary(10) = [3,   1];
%             Dictionary(11) = [3,  -3];
%             Dictionary(12) = [3,  -1];
%             Dictionary(13) = [1,   3];
%             Dictionary(14) = [1,   1];
%             Dictionary(15) = [1,  -3];
%             Dictionary(16) = [1,  -1];

            Dictionary(1) = -3 + 1i *  3;
            Dictionary(2) = -3 + 1i *  1;
            Dictionary(3) = -3 + 1i *  3;
            Dictionary(4) = -3 + 1i * (-1);
            Dictionary(5) = -1 + 1i *  3;
            Dictionary(6) = -1 + 1i *  1;
            Dictionary(7) = -1 + 1i * (-3);
            Dictionary(8) = -1 + 1i * (-1);
            Dictionary(9) =  3 + 1i *  3;
            Dictionary(10) = 3 + 1i *  1;
            Dictionary(11) = 3 + 1i * (-3);
            Dictionary(12) = 3 + 1i * (-1);
            Dictionary(13) = 1 + 1i *  3;
            Dictionary(14) = 1 + 1i *  1;
            Dictionary(15) = 1 + 1i * (-3);
            Dictionary(16) = 1 + 1i * (-1);
            
            Bit_depth_Dict = 4;
    end
    
    % Normalise the constellation.
    % Mean power of every constellation must be equel 1.
    % Make the function to calculate the norm, 
    % which can be applied for every constellation
    norm = sqrt(sum(Dictionary.*(conj(Dictionary)))/length(Dictionary));
    Dictionary = Dictionary./norm;

end

