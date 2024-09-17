function index = Metric(vecs, Constellation)
    
    index = zeros(1, length(vecs));
    [Dictionary, depth] = constellation_func(Constellation);
    
    for i = 1 : length(vecs)
        rho_array = zeros(1, 2 ^ depth);
    
        for j = 1 : 2 ^ depth
            rho_array(j) = abs(vecs(i) - Dictionary(j));
        end
    
        [~, index(i)] = min(rho_array);
    end


end