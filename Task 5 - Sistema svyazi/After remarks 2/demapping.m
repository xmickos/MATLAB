function [bits_output] = demapping(IQ_RX, Constellation)
% Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
% calculate the Bit_depth for each contellation
[Dictionary, Bit_depth_Dict] = constellation_func(Constellation);

% for k = 1 : 5
%     fprintf("IQ_RX(k) = %d + %d j\n", real(IQ_RX(k)), imag(IQ_RX(k)));
% end

% write  the function of mapping from IQ vector to bit vector

decs = Metric(IQ_RX, Constellation);
% fprintf('decs(1 : 4) = %d\n', decs(1 : 4));

[~, bit_depth] = constellation_func(Constellation);

% fprintf("\nbit_depth = %d\n", bit_depth);

Bit = str2num(dec2bin(decs - 1));
% Счёт в созвездиях с нуля, счёт в созвездиях с единицы - поэтому -1

% fprintf("Bit length: %d %d\n", size(Bit));

Bit = transpose(Bit);
% 
% bits_len = length(Bit);
% bits_output = zeros(1, 3 * bits_len);
% for i=1:3:bits_len
%     received = my_own_convertion(Bit(i), Constellation);
%     bits_output(i : i + 2) = received - 48;
% end

bits_output = my_own_good_convertion(Bit, Constellation) - 48;

% fprintf("bits_output.shape: %d %d\n", size(bits_output));
% Bit = bits_output;


end

