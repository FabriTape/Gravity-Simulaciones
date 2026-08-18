% verlet_chatgpt_hibrido.m - Verlet hibrido vectorizado por ChatGPT
% Usa permute + bsxfun para aceleracion vectorizada
% Almacena historial como array 3D: X_history(N+1,n,3)
%
% Uso: octave verlet_chatgpt_hibrido

clearvars
tic
n = 500;

% Tensor de posiciones
X = randn(n, 3) * 3000;

% Tensor de velocidades
V = randn(n, 3) / 10;

% Condiciones de integración
dt = 1;
T = 600;
N = T / dt;

% Vector de masas del sistema
M = randn(n, 1) * 50000000000;

% Cálculo de la aceleración (vectorizada)
function A = aceleracion(X, M)
    G = 6.674e-11; % Constante de gravitación

    n = size(X, 1);

    % Calcular las diferencias de posición para todas las partículas
    Rij = permute(X, [1, 3, 2]) - permute(X, [3, 1, 2]);

    % Calcular la distancia entre las partículas y elevarla al cubo
    dist = sqrt(sum(Rij.^2, 3));
    dist3 = dist.^3;

    % Evitar divisiones por cero
    dist3(dist3 == 0) = 1;

    % Crear una matriz de identidad con unos en la diagonal
    I = eye(n);

    % Calcular la contribución de la gravedad (vectorizada)
    A = -G * sum(bsxfun(@times, Rij, M ./ dist3), 2) - G * bsxfun(@times, permute(M - I * M, [3, 2, 1]), 1 ./ dist3);
end

% Bucle de integración en el tiempo
X_history = zeros(N + 1, n, 3);
X_history(1, :, :) = X;

for i = 1:N
    X_new = 2 * X - X_history(i, :, :) + aceleracion(X, M) * dt^2;
    X_history(i + 1, :, :) = X_new;
    X = X_new;
end
toc



