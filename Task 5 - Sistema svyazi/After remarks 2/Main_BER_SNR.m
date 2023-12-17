close all; clear; clc;
%% Init parametrs of model
Length_Bit_vector = 1e5;

% Constellation = "BPSK"; % QPSK, 8PSK, 16-QAM
% Constellation = "QPSK";
% Constellation = "16QAM";
Constellation = "QPSK";


SNR = 30; % dB

%% Bit generator
rng(100);

Bit_Tx = randi([0,1], 1, Length_Bit_vector);

%% Mapping

fprintf("\t\t---Mapping---\n");

IQ_TX = mapping(Bit_Tx, Constellation);

fprintf("\nBit_Tx(1) = %d, IQ_TX(1) = %d + %d j\n", Bit_Tx(1, 1), real(IQ_TX(1)),  imag(IQ_TX(1)));
fprintf("\nBit_Tx(2) = %d, IQ_TX(2) = %d + %d j\n", Bit_Tx(1, 2), real(IQ_TX(2)),  imag(IQ_TX(2)));
fprintf("\nBit_Tx(3) = %d, IQ_TX(3) = %d + %d j\n", Bit_Tx(1, 3), real(IQ_TX(3)),  imag(IQ_TX(3)));
fprintf("first 12 bits:\n");
for k = 1 : 12
    fprintf("Bit_Tx(k) = %d\n", Bit_Tx(k));
end
%% Channel

fprintf("\t\t---Channel---\n");

% Write your own function Eb_N0_convert(), which convert SNR to Eb/N0

Eb_N0 = Eb_N0_convert(SNR, Constellation);

% Use your own function of generating of AWGN from previous tasks

fprintf("Eb_N0 = %f\nlength(IQ_TX) = %d\n", Eb_N0, length(IQ_TX));
IQ_RX = Noise(IQ_TX, SNR);
fprintf("IQ_RX(1) = %d + %d j\n", real(IQ_RX(1)), imag(IQ_RX(1)));
fprintf("IQ_RX(2) = %d + %d j\n", real(IQ_RX(2)), imag(IQ_RX(2)));
fprintf("IQ_RX(3) = %d + %d j\n", real(IQ_RX(3)), imag(IQ_RX(3)));



%% Demapping

fprintf("\t\t---Demapping---\n");

Bit_Rx = demapping(IQ_RX, Constellation);

iq_plane_visualisation(IQ_RX, Constellation);

savefig("qpsk_visualised.fig");

fprintf("Transmitted VS Recieved first 12 bits:\n");
for k = 1 : 12
    fprintf("Bit_Tx(%d) = %d VS Bit_Rx(%d) = %d\n", k, Bit_Tx(k), k, Bit_Rx(k));
end

%% Error check
% Write your own function Error_check() for calculation of BER
BER = Error_check(Bit_Tx, Bit_Rx);

%% Additional task. Modulation error ration
% MER_estimation = MER_my_func(IQ_RX, Constellation);
% Compare the SNR and MER_estimation from -50dB to +50dB for BPSK, QPSK,
% 8PSK and 16QAM constellation.
% Plot the function of error between SNR and MER for each constellation 
% Discribe the results. Make an conclusion about MER.
% You can use the cycle for collecting of data
% Save figure

%% Experimental BER(SNR) and BER(Eb/N0)
% Collect enough data to plot BER(SNR) and BER(Eb/N0) for each
% constellation.
% Compare the constalation. Describe the results
% You can use the cycle for collecting of data
% Save figure

Data = zeros(4, 12);
Length_Bit_vector = 1e4;
Bit_Tx = randi([0,1], 1, Length_Bit_vector);
snrs = linspace(-25, 25, 12);


for snr_indx = 1:12
    IQ_Tx = mapping(Bit_Tx, "BPSK");
    
    IQ_Rx = Noise(IQ_Tx, snrs(snr_indx));
    
    Bit_Rx = demapping(IQ_Rx, "BPSK");

    Data(1, snr_indx) = Error_check(Bit_Tx, Bit_Rx);
end


for snr_indx = 1:12
    IQ_Tx = mapping(Bit_Tx, "QPSK");
    
    IQ_Rx = Noise(IQ_Tx, snrs(snr_indx));
    
    Bit_Rx = demapping(IQ_Rx, "QPSK");

    Data(2, snr_indx) = Error_check(Bit_Tx, Bit_Rx);
end


for snr_indx = 1:12
    IQ_Tx = mapping(Bit_Tx, "8PSK");
    
    IQ_Rx = Noise(IQ_Tx, snrs(snr_indx));
    
    Bit_Rx = demapping(IQ_Rx, "8PSK");

    Data(3, snr_indx) = Error_check(Bit_Tx, Bit_Rx);
end


for snr_indx = 1:12
    IQ_Tx = mapping(Bit_Tx, "16QAM");
    
    IQ_Rx = Noise(IQ_Tx, snrs(snr_indx));
    
    Bit_Rx = demapping(IQ_Rx, "16QAM");

    Data(4, snr_indx) = Error_check(Bit_Tx, Bit_Rx);
end


%% Построение графиков

hold on;
scatter(snrs, Data(1, :));
plot(snrs, Data(1, :));

scatter(snrs, Data(2, :));
plot(snrs, Data(2, :));

scatter(snrs, Data(3, :));
plot(snrs, Data(3, :));

scatter(snrs, Data(4, :));
plot(snrs, Data(4, :));

hold off;

legend({'', 'BPSK', '', 'QPSK', '', '8PSK', '', '16QAM'}, 'Location', 'Best');

title("Experimental BER(SNR) plots")
xlabel("SNR")
ylabel("BER")

savefig("BER_SNR_experimental.fig");

%% Theoretical lines of BER(Eb/N0)
% Read about function erfc(x) or similar
% Configure the function and get the theoretical lines of BER(Eb/N0)
% Compare the experimental BER(Eb/N0) and theoretical for BPSK, QPSK, 8PSK
% and 16QAM constellation
% Save figure

snrs = linspace(-25, 25, 12);


true_bers = zeros(4, 12);
for i = 1 : 12
    Eb_N0 = 10 .^ (Eb_N0_convert(snrs(i), "BPSK") / 10);
    true_bers(1, i) = 1/2*erf(sqrt(Eb_N0));
end

for i = 1 : 12
    Eb_N0 = 10 .^ (Eb_N0_convert(snrs(i), "QPSK") / 10);
    true_bers(2, i) = 1/2*erf(sqrt(Eb_N0));
end

for i = 1 : 12
    Eb_N0 = 10 .^ (Eb_N0_convert(snrs(i), "8PSK") / 10);
    true_bers(3, i) = 1/2*erf(sqrt(Eb_N0));
end

for i = 1 : 12
    Eb_N0 = 10 .^ (Eb_N0_convert(snrs(i), "16QAM") / 10);
    true_bers(4, i) = 1/2*erf(sqrt(Eb_N0));
end

%%

true_bers = flip(true_bers);

figure;

hold on;
scatter(snrs, true_bers(1, :));
plot(snrs, true_bers(1, :));

scatter(snrs, true_bers(2, :));
plot(snrs, true_bers(2, :));

scatter(snrs, true_bers(3, :));
plot(snrs, true_bers(3, :));

scatter(snrs, true_bers(4, :));
plot(snrs, true_bers(4, :));

hold off;

legend({'', 'BPSK', '', 'QPSK', '', '8PSK', '', '16QAM'}, 'Location', 'Best');

title("Theoretical BER(SNR) plots")
xlabel("SNR")
ylabel("BER")

savefig("BER_SNR_theoretical.fig");
