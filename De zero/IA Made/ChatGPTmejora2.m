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

% Celda para almacenar registros de posiciones
X_history = cell(N + 1, 1);
X_history{1} = X;

function A = aceleracion(X, M)
    G = 6.674e-11; % Constante de gravitación

    n = size(X, 1);
    A = zeros(n, 3);

    for i = 1:n
        % Calcular la diferencia de posiciones para todas las partículas
        Rij = X - X(i, :);

        % Calcular la distancia entre las partículas y elevarla al cubo
        dist = sqrt(sum(Rij.^2, 2));
        dist3 = dist.^3;

        % Evitar divisiones por cero
        dist3(dist3 == 0) = 1;

        % Calcular la contribución de la partícula i a las demás
        M_i = M(1:end ~= i); % Excluir la masa de la partícula actual
        A(i, :) = -G * sum(bsxfun(@times, Rij(1:end ~= i, :), M_i ./ dist3(1:end ~= i)), 1);
    end
end


% Bucle de integración en el tiempo
for i = 1:N
    X_new = 2 * X - X_history{i} + aceleracion(X, M) * dt^2;
    X_history{i + 1} = X_new;
    X = X_new;
end
toc

% Graficar las trayectorias
#figure;
#hold on;
#for i = 1:n
#    positions(:,i,:) = cell2mat(X_history(i));
#    plot3(positions(:, i, 1), positions(:, i, 2), positions(:, i, 3),'o');
#end
#hold off;


