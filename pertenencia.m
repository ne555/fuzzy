function p = pertenencia(d, conj) % para triangulos
% Pertenencia de la variable al conjunto difuso
  if (d < conj(1) || d > conj(3))
    p = 0;
  else
    if (d < conj(2))
      p = (1 / (conj(2)-conj(1))) * abs(d - conj(1));
    else
      p = (1 / (conj(3)-conj(2))) * abs(d - conj(3));
    end
  end
end
