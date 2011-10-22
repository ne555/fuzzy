function y = max_min_composition (x, M)
% Para usar las reglas
  m = size(M)(1);
  n = size(M)(2);
  y = zeros(1, n);
  for j = 1 : n
    y(j) = min(x(1), M(1, j));
    for i = 2 : m
      y(j) = max(y(j), min(x(i), M(i, j)));
    end
  end
end

