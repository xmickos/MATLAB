function [norm_arr] = norming(arr, QAM_num)

norm_arr = 1;

    if length(arr) ~= 2^QAM_num
        disp('NORMING: Wrong number of elements in norming func!\n');
        return
    end
    
    norm_arr = sqrt(sum(arr.*conj(arr)) / 2^QAM_num);
    %norm_arr = arr/n;
end

