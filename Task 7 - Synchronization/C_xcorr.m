function result = C_xcorr(a, b)
    len1 = length(a);
    len2 = length(b);

    result = zeros(1, len1 + len2);

    for shift = 1 : len1 - len2
        c = sum(abs(a(shift : shift + len2 - 1)).^2);
        d = sum(abs(b).^2);
        result(shift) = dot(a(shift : shift + len2 - 1), conj(b)) / ...
        sqrt(sum(abs(a(shift : shift + len2 - 1)).^2)*sum(abs(b).^2));
    end

end