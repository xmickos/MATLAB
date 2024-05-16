function [bits_output] = demapping(IQ_RX, Constellation)
% Make the different dictionary for BPSK, QPSK, 8PSK, 16QAM constellations
% calculate the Bit_depth for each contellation
% write  the function of mapping from IQ vector to bit vector

decs = Metric(IQ_RX, Constellation);

% Bit = str2num(dec2bin(decs - 1)); % Счёт в созвездиях с нуля, счёт в массивах матлаба с единицы - поэтому -1

Bit = dec2bin(decs - 1);

shape = size(Bit);

% bits_output = reshape(Bit, [1, shape(1) * shape(2)]);

bits_output = zeros(1, size(Bit, 1) * size(Bit, 2));

for i = 1 : shape(1)
  for j = 1 : shape(2)

    bits_output( (i - 1) * shape(2) + j ) = double(Bit(i, j)) - double('0');

  end
end



% bits_output = double(bits_output) - double('0');

end

