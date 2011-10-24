function m = membresia(x, A)
% Pertenencia a cada uno de los conjuntos
  nce = size(A)(1);
  m = zeros(1, nce);
  for i = 1 : nce
    m(i) = pertenencia(x, A(i,:));
  end
end
