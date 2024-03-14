function result = my_xcorr(x, y)
    
    len1 = length(x);
    len2 = length(y);

    result = zeros(len1 + len2);

    for i = 1:len1 + len2
        result(i) = dot(x, circshift(y, i - 1));
    end
    result = result / max(result);
end