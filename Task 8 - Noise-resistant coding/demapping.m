function [Bit] = demapping(IQ_RX, Constellation)
% Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
% calculate the Bit_depth for each contellation
[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);

for k = 1 : 5
    fprintf("IQ_RX(k) = %d + %d j\n", real(IQ_RX(k)), imag(IQ_RX(k)));
end

% write  the function of mapping from IQ vector to bit vector

switch Constellation
    case 'BPSK'
        decs = Metric(IQ_RX, 'BPSK');
        fprintf('decs: \n\n');
        fprintf("%d\n", decs(1));
        Bit = str2num(dec2bin(decs));
%         fprintf("bit: %d\n", Bit(1:50));
    case 'QPSK'
        decs = Metric(IQ_RX, 'QPSK');
        fprintf("decs(1 : 4) = %d\n", decs(1 : 4));
        Bit = str2num(dec2bin(decs - 1));
%         fprintf("first 8 bits:\n");
    case '8PSK'
        decs = Metric(IQ_RX, "8PSK");
        fprintf('decs(1 : 4) = %d\n', decs(1 : 4));
        Bit = str2num(dec2bin(decs - 1));

    case '16QAM'
        decs = Metric(IQ_RX, '16QAM');
        fprintf("decs(1 : 4) = %d\n", decs(1 : 4));
        Bit = str2num(dec2bin(decs - 1));
end

% Bit = 0;

Bit = transpose(Bit);

end

