function salida = defuzzycate(pertenencia, conjunto)
% Calcula la salida mediante promedio ponderado de los centroides
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
