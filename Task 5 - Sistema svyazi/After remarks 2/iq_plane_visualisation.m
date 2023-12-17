function iq_plane_visualisation(IQ_RX, constellation)


fprintf("[ip_plane_visualisation, line: 4]\n");
for i=1:5
    fprintf("IQ_RX(%d) = %f +%f*j\n", i, real(IQ_RX(i)), imag(IQ_RX(i)));
end

    true_points = [real(constellation_func(constellation)), imag(constellation_func(constellation))];

    hold on;
    s = scatter(real(IQ_RX), imag(IQ_RX), 'filled');
    scatter(true_points(:, 1), true_points(:, 2), 'filled', 'pentagram', 'r');
    hold off;

    distzero = sqrt(real(IQ_RX).^2 + imag(IQ_RX).^2) ./ 1e5;
    s.MarkerFaceAlpha = 'flat';
    s.AlphaData = distzero;

    xlim([-1.25 1.25])
    ylim([-1.25 1.25])
    
    title("IQ plane");
    xlabel("I")
    ylabel("Q")

end