function G = give_me_g(rows, cfgLDPCEnc)

    G = zeros(rows, cfgLDPCEnc.BlockLength);

    for i = 1 : 1 : cfgLDPCEnc.NumInformationBits
        input = zeros(1, cfgLDPCEnc.NumInformationBits);
        input(i) = 1;
        fprintf("%d\n", i);
        G(i, :) = ldpcEncode(input.', cfgLDPCEnc);
    end
end