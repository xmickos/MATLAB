clear global; clc;
load('Matlab_L3_2.mat')


len = 128;

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

[FrameLength_1, Start_Of_Frame_Position_1, Number_Of_Frames_1, Data_Length_1] = FindHeader(Bit_Stream_1, gold_seq, len);
fprintf("Second sequence:\n");
[FrameLength_2, Start_Of_Frame_Position_2, Number_Of_Frames_2, Data_Length_2] = FindHeader(Bit_Stream_2, m_seq, len);



function m_seq = MSeqGen(poly, init, length)
    curr_regs = init;
    m_seq = zeros(1, length);
    for i = 1:length
        m_seq(i) = curr_regs(end);
        new_bit = mod(sum(curr_regs .* poly), 2);
        curr_regs = [new_bit, curr_regs(1:end-1)];
    end
end

% function g_seq = GSeqGen(poly1, init1, poly2, init2, length)
%
% end

function [FrameLength, Start_Of_Frame_Position, Number_Of_Frames, Data_Length] = FindHeader(BitStream, GSequence, len)
    FrameLength = 0;
    Number_Of_Frames = 1;
    Start_Of_Frame_Position = zeros(1, 130);
    Data_Length = zeros(1, 129);
    % Величина 150 из оценки 129 < 16756 / 128 < 130;
    ind = 1;
    while ind <= length(BitStream) - (len - 1)
        if sum(GSequence - BitStream(ind : ind + len - 1)) == 0
           Start_Of_Frame_Position(Number_Of_Frames) = ind;
           fprintf("Finded! num = %d\n", Number_Of_Frames);
           ind = ind + len - 1;
           if Number_Of_Frames > 1
            Data_Length(Number_Of_Frames - 1) = Start_Of_Frame_Position(Number_Of_Frames) - Start_Of_Frame_Position(Number_Of_Frames - 1) - (len - 1);
            fprintf("s(n) - s(n - 1) = %d - %d - 127 = %d", Start_Of_Frame_Position(Number_Of_Frames), ...
                Start_Of_Frame_Position(Number_Of_Frames - 1), Data_Length(Number_Of_Frames - 1));
           end
           Number_Of_Frames = Number_Of_Frames + 1;
        end
        ind = ind + 1;
        FrameLength = Data_Length + len;

    end
    % len - 1 в вычислении Data_Length по аналогии с малыми размерами: если в
    % послед-ти 1 2 3 4 5 6 7 8 9 10 11
    % первые 4 отсчёта – header, следующие 3 – data, а потом опять
    % header, нужно отнять: 8(индекс начала второго header`a) - 1(индекс
    % начала первого header`a) - 3(длина header`a без единицы - отсюда 127 == len - 1)
end
