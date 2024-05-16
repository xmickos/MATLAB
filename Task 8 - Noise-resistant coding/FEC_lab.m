%=============================  Warmup =====================================
% configuring LDPC encoder and decoder

% parity check matrix as defnied in Wi-Fi (IEEE® 802.11)
data = load('Parity_Check_Matrix.mat', 'H');
H = logical(data.H);

cfgLDPCEnc = ldpcEncoderConfig(H); % configuring encoder
cfgLDPCDec = ldpcDecoderConfig(H); % configuring decoder

% using cfgLDPCEnc variable, print our the number of inofrmation, parity
% check bits and the coderate
fprintf('Number of information bits in a block: %d\n', cfgLDPCEnc.NumInformationBits);
fprintf('Number of parity check bits in a block: %d\n', cfgLDPCEnc.NumParityCheckBits);
coderate = cfgLDPCEnc.NumInformationBits / cfgLDPCEnc.BlockLength;
fprintf('Coderate: %f\n', coderate);
%%





%% simple test to check that encoder and decoder configured correctly

test_message = boolean(randi([0 1],cfgLDPCEnc.NumInformationBits,1,'int8'));
encodedData = ldpcEncode(test_message,cfgLDPCEnc);

% calculate the syndrome

s = encodedData.' * H.';


% s = %YOUR CODE HERE
s=mod(s, 2); % we need xor instead of multiplication
if(~any(s))
    fprintf('No errors!\n');
else
    fprintf('Errors detected during syndrome check!\n');
end

% deliberately distorting one bit of the message
ind = randi(numel(encodedData));
encodedData(ind) = ~(encodedData(ind));

% checking the syndrome once again
% s = %YOUR CODE HERE
s = encodedData.' * H.';
s=mod(s, 2); % we need xor instead of multiplication
if(~any(s))
    fprintf('No errors!\n');
else
    fprintf('Errors detected during syndrome check!\n');
end
%%






%% Part 1 Simple Bit Flipping decoding algorithm

maxIterationsBF = 50;
decodedCodeWord = BFDecoder(encodedData.', maxIterationsBF, H); % Implement


%%


SNRs = [-5:0.1:5, 6:1:9, 9.1:0.1:9.5];
BERs = zeros(1, length(SNRs));
Constellation = "BPSK";
% SNR = 30; % dB
rng(100);
Length_Bit_vector = 486;

G = give_me_g(Length_Bit_vector, cfgLDPCEnc);

for i = 1 : 1 : length(SNRs)
    SNR = SNRs(i);
    Bit_Tx = randi([0,1], cfgLDPCEnc.NumInformationBits, 1);    % Input bits
    Bit_encoded = ldpcEncode(Bit_Tx, cfgLDPCEnc);  % Encoding
    IQ_TX = mapping(Bit_encoded, Constellation);    % Mapping
    IQ_RX = Noise(IQ_TX, SNR);                      % Noise
    Bit_Rx = demapping(IQ_RX, Constellation).';       % Demapping
    Bit_pre_decoded = BFDecoder(Bit_Rx, maxIterationsBF, H); % Decoding
    % Bit_decoded = gflineq(G.', Bit_pre_decoded.');
    Bit_decoded = Bit_pre_decoded(1:cfgLDPCEnc.NumInformationBits);
    
    BERs(i) = Error_check(Bit_encoded, Bit_pre_decoded);
end

figure;
plot(SNRs, BERs);
xlabel("SNR, dB")
ylabel("BER")
savefig("LDPC_encoder_BER.fig");







% Create BER-SNR plots for uncoded data and
% for LDPC coded data with your BF decoder


%
%% ============= Part 2 comparing Beleif Propagation, Bit Flipping decoders and uncoded system =================

maxnumiter = 10;
snr = 0 : 25; % adjust the snr range to the constellation you choose! > QPSK.
numframes = 100;


% check manually on the build-in ber counter
% it outputs three variables
ber = comm.ErrorRate; %build-in BER counter
ber2 = comm.ErrorRate; %build-in BER counter

% arrays to store error statistic
errStats = zeros(length(snr), numframes, 3); 
errStatsNoCoding = zeros(length(snr), numframes, 3);

tStart = tic;
for ii = 1:length(snr)
    for counter = 1:numframes
        data = randi([0 1],cfgLDPCEnc.NumInformationBits,1,'int8');
        % Transmit and receive with LDPC coding
        encodedData = ldpcEncode(data,cfgLDPCEnc);

        % YOUR MAPPER HERE choose any constellation type you like
        % modSignal = %YOUR CODE HERE Mapper(encodedData, ...);
        modSignal = mapping(encodedData, "QPSK");

        % [rxsig, noisevar] = awgn(modSignal,snr(ii)); % use your AWGN function
        [rxsig, noisevar] = Noise(modSignal, snr(ii));

        % YOUR DEMAPPER HERE N.B. Perform Soft Demapping, output llr!
        % llr = % YOUR CODE HERE Demapper(rxsig, ...);
        
        disp(rxsig(1));
        disp(rxsig(2));
        disp(rxsig(3));

        llr = SoftDemapping(rxsig, cfgLDPCDec, noisevar, "QPSK");

        disp(llr(1:6));

        rxbits = ldpcDecode(llr, cfgLDPCDec, maxnumiter);
        errStats(ii, counter, :) = ber(data, rxbits);

        %========================================

        % no coding system
        % noCoding = %YOUR CODE HERE Mapper(encodedData, ...);
        noCoding = mapping(data, "QPSK");
        % rxNoCoding = awgn(noCoding,snr(ii));
        rxNoCoding = Noise(noCoding, snr(ii));
        % YOUR DEMAPPER HERE N.B. Perform Hard Demapping, output bits!
        % rxBitsNoCoding = % YOUR CODE HERE Demapper(rxNoCoding, ...);

        rxBitsNoCoding = demapping(rxNoCoding, "QPSK");

        errStatsNoCoding(ii, counter, :) = ber2(data,int8(rxBitsNoCoding.'));
    end
    fprintf(['SNR = %2d\n   Coded: Error rate = %1.2f, ' ...
        'Number of errors = %d\n'], ...
        snr(ii),mean(errStats(ii, :, 1), 2), mean(errStats(ii, :, 2), 2))
    fprintf(['Noncoded: Error rate = %1.2f, ' ...
        'Number of errors = %d\n'], ...
        mean(errStatsNoCoding(ii, :, 1), 2), mean(errStatsNoCoding(ii, :, 2), 2))
    reset(ber);
    reset(ber2);
end
ber.release();
ber2.release();
tend = toc(tStart);
fprintf('Simulation finished after %.2f s\n', tend);

%%

figure;
semilogy(snr, mean(errStatsNoCoding(:, :, 1), 2), 'LineWidth', 2)
hold on
semilogy(snr, mean(errStats(:, :, 1), 2), 'LineWidth', 2)
hold off

xlabel('SNR, dB');
ylabel('BER')
grid on
set(gca, 'Fontsize', 20)

% savefig("ber_snr_with_or_without_encoding.fig");

save('BER_SNR_results.mat', 'errStatsNoCoding', 'errStats', '-v7.3')

% EsN0 = SNR_theory + 10 * log10(1 / (1 / nsamp)); % Tsample / Tnoise
EbN0 = snr - 10 * log10(2) 

% Replot the results in BER vs Eb/N0 scale
% how the shape of curves has changed?
% what is the gain in dB?
% +20 points: compare results with llr and approximate llr formulas