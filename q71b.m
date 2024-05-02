% Chamada da função com parâmetros apropriados
alpha = 0.8;
sigma_v2 = 1;
N = 1000;  % Número de amostras
p_values = 1:20;
xi_min_values = zeros(size(p_values));  % Array to store xi_min values
magnitude_responses = cell(size(p_values)); % Cell array to store magnitude responses

for p = p_values
    [xi_min_values(p), w] = wiener(alpha, sigma_v2, p, N);
    [H, freq] = freqz(w, 1, 'half');  % Get frequency response for each filter
    magnitude_responses{p} = abs(H);
end

% Plot apenas do xi_min em função da ordem do filtro
figure;
plot(p_values, xi_min_values, '-x');
title('Minimum Theoretical Error (ξ_min) vs. Order of the Wiener Filter');
xlabel('Order of the Filter p');
ylabel('Minimum Theoretical Error');
grid on;

% Plot magnitude response for selected filter orders
figure;
hold on;
selected_orders = [1, 5, 10, 15, 20]; % Example: plot for these orders
for i = selected_orders
    plot(freq/pi, magnitude_responses{i});
end
hold off;
title('Magnitude Response of Wiener Filters for Selected Orders');
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Magnitude');
legend("p=" + string(selected_orders));
grid on;
