function [bits_output] = demapping(IQ_RX, Constellation)
% Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
% calculate the Bit_depth for each contellation
% write  the function of mapping from IQ vector to bit vector

decs = Metric(IQ_RX, Constellation);

Bit = dec2bin(decs - 1);

shape = size(Bit);

bits_output = reshape(Bit, [1, shape(1) * shape(2)]);

bits_output = double(bits_output) - double('0');

end