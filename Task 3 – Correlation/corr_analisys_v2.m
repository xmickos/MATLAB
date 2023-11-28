clear global; clc; close all;
load('Matlab_L3_2.mat')

len = 128;
eps = 0.001;

m_poly  = [1 1 0 0 1 1];
m_init  = [0 1 0 0 1 1];
g_gen2  = [0 1 0 0 1 1];
g_gen1  = [0 1 0 1 0 1];
g_poly1 = [1 0 0 0 0 1];
g_poly2 = [1 1 0 0 1 1];

m_seq = MSeqGen(m_poly, m_init, len);
gold_seq_1 = MSeqGen(g_poly1, g_gen1, len);
gold_seq_2 = MSeqGen(g_poly2, g_gen2, len);
gold_seq = xor(gold_seq_1, gold_seq_2);

xcorr_array_1 = MyOwnXcorr(gold_seq, Bit_Stream_1);
xcorr_array_1 = xcorr_array_1 / max(xcorr_array_1);

xcorr_array_2 = MyOwnXcorr(m_seq, Bit_Stream_2);
xcorr_array_2 = xcorr_array_2 / max(xcorr_array_2);


figure;
plot(xcorr_array_2);
title("Корреляция Bit_ Stream_ 1 с m_ seq");
xlabel("Смещение m_ seq относительно Bit_ Stream_ 1");
ylabel("Корреляция");
savefig("Bit_Stream_1_*_m_seq.fig");

figure;
plot(xcorr_array_1);
title("Корреляция Bit_ Stream_ 2 с gold_ seq");
xlabel("Смещение gold_ seq относительно Bit_ Stream_ 2");
ylabel("Корреляция");
savefig("Bit_Stream_2_*_gold_seq.fig");


[autocorr_array, autocorr_lags] = xcorr(m_seq);
figure;
plot(autocorr_lags, autocorr_array);
title("Автокорреляция м-последовательности");
savefig('m_seq*m_seq.fig');

[Frame_Length_1, Start_Of_Frame_Position_1, Number_Of_Frames_1, Data_Length_1] = ...
FindMyHeaders(xcorr_array_1, length(gold_seq), length(Bit_Stream_1), 1, eps);
fprintf("[Сточка 46] Ответ для Bit Stream 1: \n\tFrame_Length: %d\n\tStart_Of_Frame_Position: (...)\n\t" + ...
    "Number_Of_Frames: %d\n\tData_Length: %d\n\n", Frame_Length_1, Number_Of_Frames_1, ...
    Data_Length_1);

[Frame_Length_2, Start_Of_Frame_Position_2, Number_Of_Frames_2, Data_Length_2] = ...
FindMyHeaders(xcorr_array_1, length(gold_seq), length(Bit_Stream_1), 1, eps);
fprintf("[Сточка 52] Ответ для Bit Stream 2: \n\tFrame_Length: %d\n\tStart_Of_Frame_Position: (...)\n\t" + ...
    "Number_Of_Frames: %d\n\tData_Length: %d\n\n", Frame_Length_2, Number_Of_Frames_2, ...
    Data_Length_2);



function m_seq = MSeqGen(poly, init, length)
    curr_regs = init;
    m_seq = zeros(1, length);
    for i = 1:length
        m_seq(i) = curr_regs(end);
        new_bit = mod(sum(curr_regs .* poly), 2);
        curr_regs = [new_bit, curr_regs(1:end-1)];
    end
    m_seq = logical(m_seq);
end

function [Frame_Length, Start_Of_Frame_Position, Number_Of_Frames, Data_Length] = FindMyHeaders(xcorr_array, seq_len, stream_len, border_value, eps)

    % Функция FindMyHeaders решает задачу поиска заголовков в массиве,
    % полученном как результат корреляции битового потока с предполагаемой
    % последовательностью header'a.

    Start_Of_Frame_Position = zeros(1, round(stream_len / (2 * seq_len))); 

    % Умножение на два из соображения  о том, что передавать кадр короче,
    % чем длина заголовка, не имеет смысла - верхняя оценка. 

    Number_Of_Frames = 0;
  
    for i = 1:length(xcorr_array) - (seq_len - 1)
        if abs(xcorr_array(i) - border_value) < eps
            Number_Of_Frames = Number_Of_Frames + 1;
            Start_Of_Frame_Position(Number_Of_Frames) = i - seq_len - 1;
        end
    end
    Frame_Length = Start_Of_Frame_Position(2) - Start_Of_Frame_Position(1);
    Data_Length = Frame_Length - seq_len;
end

function corr_output = MyOwnXcorr(Bitstream_1, Bitstream_2)
%   Функция MyOwnXcorr реализует операцию корреляции сигналов Bitstream_1 и
%   Bitstream_2. Реализация предполагает, что длина Bitstream_2 много
%   больше длины Bitstream_1.

%   В такой реализации индексы массива corr_output пересчитываются в
%   индексы кадров в битовом потоке со входа посредством вычитания
%   len_1 - 1.

    len_1 = length(Bitstream_1);
    len_2 = length(Bitstream_2);
    
    corr_output = zeros(1, len_1 + len_2 + 2);
    
    for i = 1 : len_1 + len_2 - 1
        left_border_1  = len_1 - i + 1;
        right_border_1 = len_2 + i - 1;
        left_border_2  = i - len_1 + 1; 
        right_border_2 = i;

        if left_border_1 < 1
            left_border_1 = 1;
        end

        if right_border_1 > len_1
            right_border_1 = len_1;
        end

        if left_border_2 < 1
            left_border_2 = 1;
        end
        
        if i > len_2
            right_border_1 = len_1 - (i - len_2);
            right_border_2 = len_2;
        end

        corr_output(i) = sum(Bitstream_1(left_border_1 : right_border_1) .* ...
        Bitstream_2(left_border_2 : right_border_2)) / (len_1 + len_2 + 2);

    end
end

% function [FrameLength, Start_Of_Frame_Position, Number_Of_Frames, Data_Length] = DataParse(BitStream, GSequence)
%     ind = 1;
%     len = length(GSequence);
%     Number_Of_Frames = 0;
%     while ind <= length(BitStream) - (len - 1)
%         if sum(GSequence - BitStream(ind : ind + len - 1)) == 0
%             if Number_Of_Frames == 0
%                 Start_Of_Frame_Position = ind;
%             end
%             ind = ind + len - 1;
%             if Number_Of_Frames == 1
%                 Data_Length = Start_Of_Frame_Position - ...
%                     Start_Of_Frame_Position - 1 - (len - 1);
%             end
%             Number_Of_Frames = Number_Of_Frames + 1;
%         end
%         ind = ind + 1;
%     end
%     FrameLength = Data_Length + len;
% end


% function [xcorr_array, lags] = CorrEstimation(BitStream, GSequence)
%     % Функция CorrEstimation написана для того, чтобы была возможность
%     % наглядно оценить, какое минимальное значение корреляции между
%     % предполагаемым header'ом и битовым потоком стоит использовать для 
%     % определения границ фрагмента данных в последовательности. 
%     [xcorr_array, lags] = xcorr(BitStream, GSequence);
%     figure;
%     plot(lags, xcorr_array);
%     xlabel("Смещение GSequence относительно BitStream");
%     ylabel("Корреляция");
%     title("Корреляция между BitStream и GSequence");
%     savefig('fig1.fig')
% end
