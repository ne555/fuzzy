function [v,i] = controlador(entrada)
	%Controlador logico difuso
	%function [v,i] = controlador(entrada)
	%entrada = diferencia entre temperatura actual y deseada

	%la entrada se mapea a un rango [-1;1]
	max_delta = 2.5;
	entrada = entrada/max_delta;
	if entrada>1
		entrada = 1;
	elseif entrada < -1
		entrada = -1;
	end
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
	conj_muy_frio=[-1.1 -1 -0.1];
	conj_frio=[-0.7 -0.6 -0.1];
	conj_poco_frio=[-0.45 -0.1 0];
	conj_templado=[-0.15 0 0.15];
	conj_poco_caliente=[0 0.1 0.45];
	conj_caliente=[0.1 0.2 0.7];
	conj_muy_caliente=[0.5 1 1.1];

	conjuntos_entrada = [conj_muy_frio; conj_frio; conj_poco_frio; conj_templado; conj_poco_caliente; conj_caliente; conj_muy_caliente];

	nro_conjuntos_e = size(conjuntos_entrada)(1);

	%Definicion de los conjuntos de salida
	conj_calentar_mucho=[-1.1 -1 -0.5];
	conj_calentar=[-0.7 -0.5 -0.3];
	conj_calentar_poco=[-0.45 -0.25 -0.05];
	conj_no_hacer_nada=[-0.2 0 0.2];
	conj_enfriar_poco=[0.05 0.25 0.45];
	conj_enfriar=[0.3 0.5 0.7];
	conj_enfriar_mucho=[0.5 1 1.1];

	conjuntos_salida = [conj_calentar_mucho; conj_calentar; conj_calentar_poco; conj_no_hacer_nada; conj_enfriar_poco; conj_enfriar; conj_enfriar_mucho];

	%figure;plot(conjuntos_entrada');
	%figure;plot(conjuntos_salida');

	nro_conjuntos_s = size(conjuntos_salida)(1);

	% Funciones

	fit_vectors_entrada = zeros(nro_conjuntos_e);
	for i = 1 : nro_conjuntos_e
	  fit_vectors_entrada(i, :) = fit_vector(conjuntos_entrada(i, 2), conjuntos_entrada);
	end

	fit_vectors_salida = zeros(nro_conjuntos_s);
	for i = 1 : nro_conjuntos_s
	  fit_vectors_salida(i, :) = fit_vector(conjuntos_salida(i, 2), conjuntos_salida);
	end


	% Reglas
	global si_muy_frio_calentar_mucho;
	global si_frio_calentar;
	global si_poco_frio_calentar_poco;
	global si_templado_no_hacer_nada;
	global si_poco_caliente_enfriar_poco;
	global si_caliente_enfriar;
	global si_muy_caliente_enfriar_mucho;
	global tam_rules;
	global n_rules;
	si_muy_frio_calentar_mucho = correlation_minimum(fit_vectors_entrada(1, :), fit_vectors_salida(1, :));
	si_frio_calentar = correlation_minimum(fit_vectors_entrada(2, :), fit_vectors_salida(2, :));
	si_poco_frio_calentar_poco = correlation_minimum(fit_vectors_entrada(3, :), fit_vectors_salida(3, :));
	si_templado_no_hacer_nada = correlation_minimum(fit_vectors_entrada(4, :), fit_vectors_salida(4, :));
	si_poco_caliente_enfriar_poco = correlation_minimum(fit_vectors_entrada(5, :), fit_vectors_salida(5, :));
	si_caliente_enfriar = correlation_minimum(fit_vectors_entrada(6, :), fit_vectors_salida(6, :));
	si_muy_caliente_enfriar_mucho = correlation_minimum(fit_vectors_entrada(7, :), fit_vectors_salida(7, :));
	tam_rules = size(si_muy_frio_calentar_mucho);
	n_rules = 7;

	entrada_fuzzy = fit_vector(entrada,conjuntos_entrada); 
	salida_fuzzy = regulizate(entrada_fuzzy);
	pertenencia_salida = max(salida_fuzzy); %porque las reglas fueron de tipo max_min
	%pertenencia_salida = sum(salida_fuzzy); %porque las reglas fueron de tipo producto
	salida = defuzzycate(pertenencia_salida, conjuntos_salida); %centroide, maximo, etc...
	
	%fit_vectors_entrada
	%fit_vectors_salida

	%entrada_fuzzy
	%salida_fuzzy
	%salida

%Mapeo inverso de la salida a los valores de v y i
	vmax = 220;
	imax = 1;
    if(salida<0)
		v = -salida*vmax;
		i = 0;
	else
		v = 0;
		i = sqrt(salida*imax**2);
	end
end
