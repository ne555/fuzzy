function salida = regulizate(fuzzy)
	salida = zeros(n_rules, tam_rules(2));
	salida(1,:) = max_min_composition(fuzzy, si_muy_frio_calentar_mucho);
	salida(2,:) = max_min_composition(fuzzy, si_frio_calentar);
	salida(3,:) = max_min_composition(fuzzy, si_poco_frio_calentar_poco);
	salida(4,:) = max_min_composition(fuzzy, si_templado_no_hacer_nada);
	salida(5,:) = max_min_composition(fuzzy, si_poco_caliente_enfriar_poco);
	salida(6,:) = max_min_composition(fuzzy, si_caliente_enfriar);
	salida(7,:) = max_min_composition(fuzzy, si_muy_frio_calentar_mucho);

end

function salida = defuzzycate(pertenencia, conjunto)
	n = lenght(pertenencia);
	cent_parcial = zeros(n);
	area_parcial = zeros(n);
	for K=[1:n]
		[cent_parcial(K), area_parcial(K)] = centroide(conjunto(K,:));
	end
	area_total = dot(pertenencia,area_parcial); %escalo
	cent_accum = dot(cent_parcial, area_parcial);
	salida = cent_accum/area_total;
end

