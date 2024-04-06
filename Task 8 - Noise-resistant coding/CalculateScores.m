function scores = CalculateScores(syndrome, dict)
    scores = dictionary;
    for i = 1:size(dict, 2)
        a = size(dict{1, i}, 2);
        b = dict{1, i};
        for j = 1:size(dict{1, i}, 2)
            if(numEntries(scores) == 0 || ~isKey(scores, dict{1, i}(j)))
                scores(dict{1, i}(j)) = 0;
            end

            if(isKey(scores, dict{1, i}(j)) && syndrome(i) == 1)
                scores(dict{1, i}(j)) = scores(dict{1, i}(j)) + 1;
            end

            if(isKey(scores, dict{1, i}(j)) && syndrome(i) == 0)
                scores(dict{1, i}(j)) = scores(dict{1, i}(j)) - 1;
            end
        end
    end
end