close all; clear; clc;

Lh = 126;
Ld = 10 * Lh;

Coeffs = [1 0 0 1 1 1 0 1];


%% M-seq

m_seq1 = generate_m_sequence([0 0 1 0 0 0 1 0], Coeffs, Lh);
m_seq2 = generate_m_sequence([0 0 1 0 1 0 1 1], [0 0 1 1 0 0 1 1], Lh);

[r, lags] = xcorr(m_seq2, m_seq2);
plot(lags, r);

%% Testing
rng(100);
probability = zeros(1, 100);
tries = 100;
i = 0;


for snrs = -25:0.5:25
    i = i + 1;
    trues = 0;
    for n_try = 1:tries    
        Bit_Tx = randi([0,1], 1, Ld);
        
        Bit_Tx = cat(2, m_seq2, Bit_Tx);
        
        IQ_TX_h = mapping(m_seq2, "BPSK");
        IQ_TX_d = mapping(Bit_Tx, "QPSK");
        
        
        IQ_TX = cat(2, IQ_TX_h, IQ_TX_d);
        Header_mapped = mapping(IQ_TX_h, "BPSK");
        
        IQ_RX = Noise(IQ_TX, snrs);
                
        %% Correlation & Start Detecting
        
        lags = C_xcorr(IQ_RX, Header_mapped);

        [~, offset] = max(lags);
                
        if (offset == 1)
            trues = trues + 1;
        end

    end
    probability(i) = trues / tries;
end
%% Graph



figure;
plot(linspace(-25, 25, 101), probability);
title("Probability curve");
xlabel("SNR");
ylabel("Probability");
savefig("probability_curve.fig");



%%
function m_sequence = generate_m_sequence(init_seed, polynomial, len_m)
    m_sequence = zeros(1, len_m);

    current_state = init_seed;

    for i = 1:len_m
        m_sequence(i) = current_state(end);

        new_state = mod(sum(polynomial .* current_state), 2);

        current_state = [new_state, current_state(1:end-1)];
    end
end