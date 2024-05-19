% (a)
% Parâmetros
omega_0 = 0.05 * pi;
n = 0:499;
phi = rand() * 2 * pi - pi;

% Processos
d_n = sin(omega_0 * n + phi);
g_n = randn(1, 500); % Ruído branco com variância unitária
x_n = d_n + g_n;
v2_n = 0.8 * [0, 0, x_n(1:end-2)] + g_n;

% Plotar os processos
figure;
subplot(3, 1, 1);
plot(n, x_n);
title('Processo x(n)');
xlabel('n');
ylabel('x(n)');
grid on;

subplot(3, 1, 2);
plot(n, d_n);
title('Processo d(n)');
xlabel('n');
ylabel('d(n)');
grid on;

subplot(3, 1, 3);
plot(n, v2_n);
title('Processo v2(n)');
xlabel('n');
ylabel('v2(n)');
grid on;


% (b)
% Ordem do filtro
p = 6;

% Função de autocorrelação de v2(n)
R_v2 = xcorr(v2_n, 'unbiased');

% Função de correlação cruzada entre x(n) e v2(n)
R_xv2 = xcorr(x_n, v2_n, 'unbiased');

% Montar e resolver as equações de Wiener-Hopf
R = toeplitz(R_v2(500:500+p-1));
r = R_xv2(500:500+p-1)';
h_opt = R \ r;

% Mostrar o filtro ótimo
disp('Filtro FIR ótimo:');
disp(h_opt);


% (c)
% Calcular filtros ótimos para diferentes ordens
orders = [2, 4, 6];
errors = zeros(1, length(orders));

for i = 1:length(orders)
    p = orders(i);
    h_opt = wiener_filter(v2_n, x_n, p);
    g_hat = filter(h_opt, 1, v2_n);
    errors(i) = mean((g_hat - g_n).^2);

    % Plotar g(n) estimado
    figure;
    plot(n, g_n, n, g_hat);
    legend('g(n)', ['$\hat{g}(n)$ - ordem ', num2str(p)], 'Interpreter', 'latex');
    title(['Estimativa de $g(n)$ com filtro de Wiener de ordem ', num2str(p)], 'Interpreter', 'latex');
    xlabel('n');
    ylabel('Amplitude');
    grid on;
end

% Comparar erros médios quadrados
disp('Erros médios quadrados para diferentes ordens:');
disp(table(orders', errors', 'VariableNames', {'Ordem', 'ErroMédioQuadrado'}));


% (d)

alphas = [0.1, 0.5, 1.0];
order = 4;
errors_alpha = zeros(1, length(alphas));

for i = 1:length(alphas)
    alpha = alphas(i);
    v0_n = v2_n + alpha * d_n;
    h_opt = wiener_filter(v0_n, x_n, order);
    g_hat = filter(h_opt, 1, v0_n);
    errors_alpha(i) = mean((g_hat - g_n).^2);

    % Plotar g(n) estimado
    figure;
    plot(n, g_n, n, g_hat);
    legend('g(n)', ['$\hat{g}(n)$ - $\alpha$ = ', num2str(alpha)], 'Interpreter', 'latex');
    title(['Estimativa de $\hat{g}(n)$ com filtro de Wiener e $\alpha = ', num2str(alpha), '$'], 'Interpreter', 'latex');
    xlabel('n');
    ylabel('Amplitude');
    grid on;
end

% Comparar erros médios quadrados para diferentes valores de alpha
disp('Erros médios quadrados para diferentes valores de \alpha:');
disp(table(alphas', errors_alpha', 'VariableNames', {'Alpha', 'ErroMédioQuadrado'}));


