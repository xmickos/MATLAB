function llr = SoftDemapping(rxsig, cfgLDPCDec, noisevar, constellation)
    
    switch constellation
        case "QPSK"
            q = 1;
            llr = zeros(cfgLDPCDec.BlockLength, 1);
            for i = 1 : length(rxsig)
                [s, ~] = constellation_func("QPSK");
                d = zeros(1, 4);
                for j = 1 : length(s)
                    d(j) = abs(s(j) - rxsig(i));
                end

                l1 = log( (exp(-d(1)^2 / noisevar) + exp(-d(2)^2 / noisevar)) / ...
                    (exp(-d(3)^2 / noisevar) + exp(-d(4)^2 / noisevar)) );
                l2 = log( (exp(-d(1)^2 / noisevar) + exp(-d(3)^2 / noisevar)) / ...
                    (exp(-d(2)^2 / noisevar) + exp(-d(4)^2 / noisevar)) );

                llr(q) = l1;
                llr(q + 1) = l2;
                q = q + 2;
                
            end
    end

end