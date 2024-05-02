% Parâmetros
sigma_v2 = 1;
N = 1000;  % Número de amostras
p = 10;    % Ordem fixa do filtro
alpha_values = 0.1:0.1:0.9;  % Variando alpha de 0.1 a 0.9
xi_min_values = zeros(size(alpha_values));  % Array to store xi_min values

for i = 1:length(alpha_values)
    [xi_min_values(i), ~] = wiener(alpha_values(i), sigma_v2, p, N);
end

% Plot do xi_min em função de alpha
figure;
plot(alpha_values, xi_min_values, '-x');
title('Minimum Theoretical Error (ξ_min) vs. Alpha');
xlabel('Alpha');
ylabel('Minimum Theoretical Error');
grid on;
