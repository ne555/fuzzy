function salida = regulizate(fuzzy)
% Aplica cada regla
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
