function decodedWord = BFDecoder(codeWord, maxIterations, H)
    % Bit-Flipping LDPC decoder proposed by Gallager

    % preparation: convert parity-check matrix into some structure of your
    % choice
    % for example, you can use dictionary and map every bit of the syndrome
    % to the bits of received word that participate in parity check for
    % this bit
    % https://www.mathworks.com/help/matlab/ref/dictionary.html
    dict = CreateDict(H); % Implement This

    decodedWord = codeWord;
    iter_num = 0;

    % check the syndrome, maybe there are no errors?
    % syndrome = % Your Code Here
    syndrome = decodedWord * H.';
    syndrome = mod(uint8(syndrome), 2);

    if (sum(syndrome) == 0)
        converged = true;
    else
        converged = false;
    end

    while (iter_num < maxIterations && ~converged)
        iter_num = iter_num + 1;
        scores = CalculateScores(syndrome, dict); % Implement This
        decodedWord = DecisionMaking(decodedWord, scores); % Implement This

        % syndrome = % Your Code Here
        syndrome = decodedWord * H.';
    
        if (sum(syndrome) == 0)
            converged = true;
        else
            converged = false;
        end
    end
    a = 0;
    
end