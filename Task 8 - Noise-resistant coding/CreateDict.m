function dict = CreateDict(H)
    output = {};
    for i = 1:size(H, 1)
        row = [];
        for j = 1:size(H, 2)
            if(H(i, j) == 1)
                row = [row, j];
            end
        end
        output = [output, row];
    end
    dict = output;
end