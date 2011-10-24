function [salida] = regulizate(pert, n, antecedente, consecuente)
	%and -> min
	%or -> max
	salida = zeros(1,n);
	for K = [1:length(consecuente)]
		activacion = 1;
		for L = [1:size(antecedente)(2)]
			if(antecedente(K,L) > 0)
				activacion = min(activacion, pert(L));
			end
		end
		salida( consecuente(K) ) = max(salida(consecuente(K)), activacion);
	end
end

