function h = raised_cosine(Roll_off, Nsamp, Span)
    L = Nsamp * Span;

    t = linspace(-Span/2, Span/2, L);

    % printf("alo")

    h = zeros(size(t));
    
    % for i = 1:length(t)
    %     if t(i) == 0
    %         h(i) = 1 - Roll_off + 4 * Roll_off / pi;
    %     elseif abs(t(i)) == 1 / (4 * Roll_off)
    %         h(i) = Roll_off / sqrt(2) * ((1 + 2 / pi) * sin(pi / (4 * Roll_off)) + (1 - 2 / pi) * cos(pi / (4 * Roll_off)));
    %     else
    %         h(i) = (sin(pi * t(i) * (1 - Roll_off)) + 4 * Roll_off * t(i) * cos(pi * t(i) * (1 + Roll_off))) / (pi * t(i) * (1 - (4 * Roll_off * t(i))^2));
    %     end
    % end


    for i = 1:length(t)
        if t(i) == 0
            h(i) = 1;
        elseif abs(t(i)) == 1 / (2 * Roll_off);
            h(i) = Roll_off / 2 * sin( pi / (2 * Roll_off ) );
        else
            h(i) = sinc( pi * t(i) ) * cos( pi * Roll_off *t(i) ) / ( 1 - ( 2 * Roll_off * t(i) )^2 );
        end
    end
end