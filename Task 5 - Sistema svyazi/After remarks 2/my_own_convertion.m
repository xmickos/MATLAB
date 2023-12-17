function [array] = my_own_convertion(value, constellation)

switch constellation
    case "BPSK"
        fprintf("init value: %d\n", value);
        str = num2str(value);
        while(length(str) < 4)
            str = strcat('0', str);
        end
        fprintf("str: %s\n", str);
    case "8PSK"
        array = zeros(1, 3);
        str = num2str(value);
        while(length(str) < 3)
            str = strcat('0', str);
        end
        % fprintf("final str: %s\n", str);

        for i=1:length(str)
            array(i) = str(i);
        end
end
    


end