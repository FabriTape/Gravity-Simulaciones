% verlet_chatgpt_loops.m - Velocity Verlet con loops optimizados por ChatGPT
% Metodo: Verlet con aceleracion por loops explícitos (no vectorizado)
% Cuerpos: 500 (aleatorios)
%
% Uso: octave verlet_chatgpt_loops

clearvars
tic
n = 500;

% Tensor de posiciones y velocidades iniciales
X = randn(n, 3) * 3000;
V = randn(n, 3) / 10;

% Condiciones de integración
dt = 1;
T = 600;
N = T / dt;

% Vector de masas del sistema
M = randn(n, 1) * 50000000000;

% Inicialización del tensor de aceleraciones
A = zeros(n, 3);

% Función para calcular la aceleración en un instante dado
function a = aceleracion(X, M)
    G = 6.674e-11; % Constante de gravitación

    % Inicialización del tensor de aceleraciones
    a = zeros(size(X));

    for i = 1:size(X, 1)
        r = X - X(i, :);
        r(i, :) = []; % Excluir la influencia propia
        dist = sqrt(sum(r.^2, 2));
        dist3 = dist.^3;
        dist3(dist3 == 0) = 1; % Evitar divisiones por cero
        a(i, :) = -G * sum(bsxfun(@times, r, M(1:end ~= i) ./ dist3), 1);
    end
end

% Bucle de integración en el tiempo
for i = 1:N
    % Cálculo de la aceleración en t = i
    A = aceleracion(X, M);

    % Actualización de posiciones usando el método de Verlet
    X = X + V * dt + 0.5 * A * dt^2;

    % Cálculo de la aceleración en t = i+1
    A_new = aceleracion(X, M);

    % Actualización de velocidades usando el método de Verlet
    V = V + 0.5 * (A + A_new) * dt;

    % Mostrar progreso cada 10 pasos
    if mod(i, 10) == 0
        fprintf('Paso %d de %d\n', i, N);
    end
end
toc

% Gráfico 3D
plot3(X(:, 1), X(:, 2), X(:, 3), 'o')
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Simulación de N Cuerpos')

