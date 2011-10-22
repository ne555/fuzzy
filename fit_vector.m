function fv = fit_vector(d, ce)
% Pertenencia a cada uno de los conjuntos
  nce = size(ce)(1);
  fv = zeros(1, nce);
  for i = 1 : nce
    fv(i) = pertenencia(d, ce(i,:));
  end
end
