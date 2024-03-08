function rrc = root_raised_cosine(Roll_off, Nsamp, Span)
    t = -Span*Nsamp:1/Nsamp:Span*Nsamp;

    rrc = zeros(length(t));

    for i = 1:length(t)
        if t(i) == 0
            rrc(i) = 1 + Roll_off * (4 / pi - 1);
        elseif abs(t(i)) == 1 / ( 4 * Roll_off )
            rrc(i) = Roll_off/(sqrt(2)) * ((1 + 2/pi)*sin(pi/(4*Roll_off)) ...
                + (1-2/pi)*cos(pi/(4*Roll_off)));
        else
            rrc(i) = (sin(pi * t(i) * ( 1 - Roll_off)) + 4 * Roll_off * t(i) * cos(pi * t(i) * (1 + Roll_off))) / (pi * t(i) * ( 1 - (4 * Roll_off * t(i))^2));
        end

    end


    rrc(isnan(rrc)) = 1; 
end