% Conjuntos

%conj_muy_frio=[-1.5 -1 -0.5];
%conj_frio=[-0.75 -0.5 -0.25];
%conj_poco_frio=[-0.5 -0.25 0];
%conj_templado=[-0.25 0 0.25];
%conj_templado_caliente=[-0.15, 0.1, 0.35];
%conj_poco_caliente=[0 0.25 0.5];
%conj_caliente=[0.25 0.5 0.75];
%conj_muy_caliente=[0.5 1 1.5];

%Definicion de los conjuntos de entrada
conj_muy_frio=[-1.5 -1 -0.7];
conj_frio=[-0.8 -0.5 -0.2];
conj_poco_frio=[-0.55 -0.25 0.05];
conj_templado=[-0.3 0 0.3];
conj_poco_caliente=[-0.05 0.25 0.55];
conj_caliente=[0.2 0.5 0.8];
conj_muy_caliente=[0.7 1 1.5];

conjuntos_entrada = [conj_muy_frio; conj_frio; conj_poco_frio; conj_templado; conj_poco_caliente; conj_caliente; conj_muy_caliente];

nro_conjuntos_e = size(conjuntos_entrada)(1);

%Definicion de los conjuntos de salida
conj_calentar_mucho=[-1.5 -1 -0.5];
conj_calentar=[-0.75 -0.5 -0.25];
conj_calentar_poco=[-0.5 -0.25 0];
conj_no_hacer_nada=[-0.25 0 0.25];
conj_enfriar_poco=[0 0.25 0.5];
conj_enfriar=[0.25 0.5 0.75];
conj_enfriar_mucho=[0.5 1 1.5];

conjuntos_salida = [conj_calentar_mucho; conj_calentar; conj_calentar_poco; conj_no_hacer_nada; conj_enfriar_poco; conj_enfriar; conj_enfriar_mucho];

nro_conjuntos_s = size(conjuntos_salida)(1);

% Funciones

% Para generar las reglas
function M = correlation_minimum (x, y)
  M = zeros(length(x), length(y));
  for i = 1 : length(x) for j = 1 : length(y)
      M(i, j) = min(x(i), y(j));
    end
  end
end

% Para usar las reglas
function y = max_min_composition (x, M)
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

% Pertenencia
function p = pertenencia(d, conj) % para triangulos
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

% Fit vector
function fv = fit_vector(d, ce)
  nce = size(ce)(1);
  fv = zeros(1, nce);
  for i = 1 : nce
    fv(i) = pertenencia(d, ce(i,:));
  end
end

fit_vectors_entrada = zeros(nro_conjuntos_e);
for i = 1 : nro_conjuntos_e
  fit_vectors_entrada(i, :) = fit_vector(conjuntos_entrada(i, 2), conjuntos_entrada);
end

fit_vectors_salida = zeros(nro_conjuntos_s);
for i = 1 : nro_conjuntos_s
  fit_vectors_salida(i, :) = fit_vector(conjuntos_salida(i, 2), conjuntos_salida);
end

% Reglas
global si_muy_frio_calentar_mucho = correlation_minimum(fit_vectors_entrada(1, :), fit_vectors_salida(1, :));
global si_frio_calentar = correlation_minimum(fit_vectors_entrada(2, :), fit_vectors_salida(2, :));
global si_poco_frio_calentar_poco = correlation_minimum(fit_vectors_entrada(3, :), fit_vectors_salida(3, :));
global si_templado_no_hacer_nada = correlation_minimum(fit_vectors_entrada(4, :), fit_vectors_salida(4, :));
global si_poco_caliente_enfriar_poco = correlation_minimum(fit_vectors_entrada(5, :), fit_vectors_salida(5, :));
global si_caliente_enfriar = correlation_minimum(fit_vectors_entrada(6, :), fit_vectors_salida(6, :));
global si_muy_caliente_enfriar_mucho = correlation_minimum(fit_vectors_entrada(7, :), fit_vectors_salida(7, :));
global tam_rules = size(si_muy_frio_calentar_mucho);
global n_rules = 7;

function salida = regulizate(fuzzy)
	global si_muy_frio_calentar_mucho 
	global si_frio_calentar 
	global si_poco_frio_calentar_poco 
	global si_templado_no_hacer_nada 
	global si_poco_caliente_enfriar_poco 
	global si_caliente_enfriar 
	global si_muy_caliente_enfriar_mucho 
	global n_rules;
	global tam_rules;
	salida = zeros(n_rules, tam_rules(2));
	salida(1,:) = max_min_composition(fuzzy, si_muy_frio_calentar_mucho);
	salida(2,:) = max_min_composition(fuzzy, si_frio_calentar);
	salida(3,:) = max_min_composition(fuzzy, si_poco_frio_calentar_poco);
	salida(4,:) = max_min_composition(fuzzy, si_templado_no_hacer_nada);
	salida(5,:) = max_min_composition(fuzzy, si_poco_caliente_enfriar_poco);
	salida(6,:) = max_min_composition(fuzzy, si_caliente_enfriar);
	salida(7,:) = max_min_composition(fuzzy, si_muy_caliente_enfriar_mucho);
end

function salida = defuzzycate(pertenencia, conjunto)
	n = length(pertenencia);
	cent_parcial = zeros(n,1);
	area_parcial = zeros(size(pertenencia));
	for K=[1:n]
		[cent_parcial(K), area_parcial(K)] = centroide(conjunto(K,:));
	end
	area_parcial = pertenencia .* area_parcial; %escalo
	area_total = sum(area_parcial); 
	cent_accum = dot(cent_parcial, area_parcial);
	salida = cent_accum/area_total;
end

%Entrada/Salida
%fuzzyficacion
n = 100;
entrada = linspace(-1,1,n)';
salida = zeros(size(entrada));

for K = [1:length(entrada)]
	entrada_fuzzy = fit_vector(entrada(K),conjuntos_entrada); 
	salida_fuzzy = regulizate(entrada_fuzzy);
	pertenencia_salida = max(salida_fuzzy); %porque las reglas fueron de tipo max_min
	%pertenencia_salida = sum(salida_fuzzy); %porque las reglas fueron de tipo producto
	salida(K) = defuzzycate(pertenencia_salida, conjuntos_salida); %centroide, maximo, etc...
end



