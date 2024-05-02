function [xi_min, w] = wiener(alpha, sigma_v2, p, N)
    % Geração do sinal AR(1)
    d = filter(1, [1, -alpha], sqrt(1-alpha^2) * randn(1, N));
    
    % Geração do sinal ruidoso x(n)
    v = sqrt(sigma_v2) * randn(1, N);
    x = d + v;
    
    % Cálculo das autocorrelações e correlações cruzadas
    R_d = toeplitz(alpha.^(0:p));   % Autocorrelação do AR(1)
    R_v = sigma_v2 * eye(p + 1);    % Matriz de autocorrelação do ruído
    R_x = R_d + R_v;                % Autocorrelação total de x
    r_dx = R_d(:,1);                % Correlação cruzada entre d(n) e x(n)
    
    % Solução das equações de Wiener-Hopf
    w = R_x \ r_dx;
    
    % Cálculo do erro mínimo teórico
    xi_min = R_d(1,1) - w' * r_dx;  % r_d(0) é R_d(1,1) porque MATLAB indexa a partir de 1
    
    return
end

