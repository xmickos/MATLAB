function FlippedDecodedWord = DecisionMaking(decodedWord, scores)
    % choose which bits to flip based on the scores
    keys_ = keys(scores);
    min_key = keys_(1);
    my_min = scores(keys_(1));
    for i = 1 : size(keys_, 1)
        key = keys_(i);
        if(scores(key) < my_min)
            my_min = scores(key);
            min_key = key;
        end
    end
    decodedWord(min_key) = ~decodedWord(min_key);
    FlippedDecodedWord = decodedWord;
end