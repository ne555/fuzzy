function M = correlation_minimum (x, y)
% Para generar las reglas
  M = zeros(length(x), length(y));
  for i = 1 : length(x) 
  	for j = 1 : length(y)
      M(i, j) = min(x(i), y(j));
    end
  end
end
