function [error_count, probability] = Error_check(bitstream1, bitsream2)

    len = min(length(bitsream1), length(bitsream2));
    errors_count = 0;
    for i = 1:len
        if(bitstream1(i) ~= bitsream2(i))
            errors_count = errors_count + 1;
        end
    end
    probability = errors_count / len;
end
