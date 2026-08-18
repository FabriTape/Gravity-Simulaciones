function [density] = adaptive_kernel_density (x, y, z, kernel, bandwidth)

  # Seleccione un kernel
  if kernel == "gaussian"
    k = @(x) exp(-(x^2)/(bandwidth^2));
  elseif kernel == "triangular"
    k = @(x) (1 - abs(x)/bandwidth)/bandwidth;
  else
    error("Kernel desconocido");
  end

  # Calcule los pesos del kernel
  weights = zeros(length(x), length(y), length(z));
  for i = 1:length(x)
    for j = 1:length(y)
      for k = 1:length(z)
        weights(i, j, k) = k(abs(x(i) - x)/bandwidth) * k(abs(y(j) - y)/bandwidth) * k(abs(z(k) - z)/bandwidth);
      end
    end
  end

  # Calcule la suma ponderada del kernel
  density = sum(weights, 3);

endfunction

