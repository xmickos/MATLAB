function [Noise, NoisedSignal] = NoiseGenerator(SNR,Signal)

    Noise_ampl = abs(Signal) / (10^(SNR/20));

    Noise = (1 + i)*(normrnd(0, Noise_ampl, size(Signal)));
    
    NoisedSignal = Signal + Noise;

end

