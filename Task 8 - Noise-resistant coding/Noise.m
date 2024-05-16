function [NoisedSignal, noisevar] = Noise(Signal, SNR)
    % генерация белого шума с мощностью, заданной в SNR

    % вычисление мощности сигнала
    Psignal = sum(abs(Signal).^2)/length(Signal);

    % вычисление мощности шума
    Pnoise = Psignal / (10 ^ (SNR / 10));
    
    % генерация белого шума
%     fprintf('size(Signal) = %d', size(Signal));
    sz = length(Signal);
    Noise = normrnd(0, sqrt(Pnoise/2), [1, sz]) + 1i*normrnd(0, sqrt(Pnoise/2), [1, sz]);
    
    % сложение сигнала и шума
    NoisedSignal = Signal + Noise;
    noisevar = sqrt(Pnoise / 2);
end
