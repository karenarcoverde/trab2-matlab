% Função para calcular o filtro de Wiener
function h_opt = wiener_filter(v2_n, x_n, p)
    R_v2 = xcorr(v2_n, 'unbiased');
    R_xv2 = xcorr(x_n, v2_n, 'unbiased');
    R = toeplitz(R_v2(500:500+p-1));
    r = R_xv2(500:500+p-1)';
    h_opt = R \ r;
end
