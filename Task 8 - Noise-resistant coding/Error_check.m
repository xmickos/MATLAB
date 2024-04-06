function [BER] = Error_check(Bit_Tx, Bit_Rx)
%     bit_rx_inversed = ~Bit_Rx(1);
%     fprintf("Bit_Tx size = %d, Bit_Rx size = %d\n", size(Bit_Tx), size(bit_rx_inversed));
%     errors_count = sum(Bit_Tx(2) .* bit_rx_inversed);
%     BER = errors_count / length(Bit_Rx(1));

    errors_count = 0;
    for i = 1:length(Bit_Rx)
        if Bit_Tx(i) ~= Bit_Rx(i)
            errors_count = errors_count + 1;
        end
    end

    fprintf("errors_count = %d\nlength = %d", errors_count, length(Bit_Rx));
    BER = errors_count / length(Bit_Rx);
    fprintf("\nBER: %d", BER);

end

