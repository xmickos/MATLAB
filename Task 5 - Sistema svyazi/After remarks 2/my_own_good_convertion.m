function output = my_own_good_constellation(Bit, constellation)
    
    bit_len = length(Bit);
    [~, depth] = constellation_func(constellation);
    output = zeros(1, depth * bit_len);
    
    output_ind = 1;
    bits_ind = 1;
    
    while(bits_ind < bit_len)
        value = Bit(bits_ind);
        str = num2str(value);
        while(length(str) < depth)
            str = strcat('0', str);
        end
    
        for k=1:depth
            output(output_ind) = str(k);
            output_ind = output_ind + 1;
        end
        bits_ind = bits_ind + 1;
    end
end