% barnes_hut_fft.m - Barnes-Hut + FFT Particle Mesh (experimental)
% Resuelve ecuacion de Poisson via FFT en grilla
% Calcula fuerzas por expansion multipolar
% Experimental: puede no converger como implementacion completa
%
% Uso: octave barnes_hut_fft

clear all;
close all;

% Parámetros del problema
n = 100; % Número de partículas
G = 6.674e-11; % Constante de gravitación
m = rand(n,1)*1e10; % Vector de masas
x = rand(n,3)*1e6; % Vector de posiciones iniciales
v = rand(n,3)*1e3; % Vector de velocidades iniciales

% Parámetros del método de expansión multipolar
lmax = 2; % Orden máximo de la expansión multipolar
theta = 0.5; % Parámetro de apertura
eps = 1e-6; % Tolerancia para el cálculo de la expansión multipolar

% Parámetros del método de particle mesh
N = 100; % Número de puntos de la malla
L = 2e6; % Longitud de la caja
dx = L/N; % Tamaño de la celda
xg = linspace(-L/2,L/2,N); % Vector de posiciones de la malla
[X,Y,Z] = meshgrid(xg,xg,xg); % Malla 3D
rho = zeros(N,N,N); % Densidad de masa en la malla
phi = zeros(N,N,N); % Potencial gravitacional en la malla

% Bucle de integración
dt = 1e3; % Paso de tiempo
T = 1e6; % Tiempo total
Nt = T/dt; % Número de pasos de tiempo
for t = 1:Nt
    % Calcular la densidad de masa en la malla
    rho(:) = 0;
    for i = 1:n
        sx = floor((x(i,1)+L/2)/dx)+1;
        sy = floor((x(i,2)+L/2)/dx)+1;
        sz = floor((x(i,3)+L/2)/dx)+1;
        sx = rem(sx-1,N)+1; % Condiciones periódicas de contorno
        sy = rem(sy-1,N)+1; % Condiciones periódicas de contorno
        sz = rem(sz-1,N)+1; % Condiciones periódicas de contorno
        rho(sx,sy,sz) = rho(sx,sy,sz) + m(i)/dx^3;
    end

    % Resolver la ecuación de Poisson para obtener el potencial gravitacional
    phi = fftn(rho);
    kx = 2*pi/L*[0:N/2-1 -N/2:-1];
    [KX,KY,KZ] = meshgrid(kx,kx,kx);
    K2 = KX.^2 + KY.^2 + KZ.^2;
    phi = ifftn(-G*rho./(K2+eps));

    % Calcular la fuerza en cada partícula utilizando el método de expansión multipolar
    F = zeros(n,3);
    for i = 1:n
        F(i,:) = multipole_force(x(i,:),m,x,phi,lmax,theta,eps);
    end

    % Actualizar las posiciones y velocidades de las partículas utilizando el integrador de Verlet
    x = x + v*dt + 0.5*F./repmat(m,1,3)*dt^2;
    a = zeros(n,3);
    for i = 1:n
        a(i,:) = multipole_force(x(i,:),m,x,phi,lmax,theta,eps)./m(i);
    end
    v = v + 0.5*(a+F./repmat(m,1,3))*dt;
end

% Graficar las posiciones finales de las partículas
scatter3(x(:,1),x(:,2),x(:,3),10,m,'filled');
xlabel('x');
ylabel('y');
zlabel('z');
title('Método de expansión multipolar y método de particle mesh para el problema de los n cuerpos gravitacionales');
