function [v,i] = controlador_2(x,y)
	%Controlador logico difuso
	%function [v,i] = controlador(x)
	%x = diferencia entre temperatura actual y deseada

	%la x se mapea a un rango [-1;1]
	max_delta = 2.5;
	x = x/max_delta;
	if x>1
		x = 1;
	elseif x < -1
		x = -1;
	end
	y = y/max_delta;
	if y>1
		y = 1;
	elseif y < -1
		y = -1;
	end
	% Conjuntos
	X = conjuntizate(4,3);
	Y = conjuntizate(4,2);
	A = [X;Y];
	n_ent = size(A)(1);

	%Definicion de los conjuntos de salida
	B = conjuntizate(4,1);
	%figure;plot(A');
	%figure;plot(B');

	n_sal = size(B)(1);

	%Reglas 
	%mapeo 1 a 1
	reglas = diag(ones(n_ent,1)); 
	consec = [1:n_sal];
	consec = [consec, [4 4 5 5 5 5 5 6 6] ];


	% Funciones


	% Reglas
	pertenencia = [membresia(x,X), membresia(y,Y)]; 
	pertenencia_salida = regulizate(pertenencia, n_sal, reglas, consec); %reglas 1 a 1 (max_min)
	%pertenencia_salida = sum(salida_fuzzy); %porque las reglas fueron de tipo producto
	salida = defuzzycate(pertenencia_salida, B); %centroide, maximo, etc...
	
%Mapeo inverso de la salida a los valores de v y i
	vmax = 2*220;
	imax = 2;
    if(salida<0)
		v = -salida*vmax;
		i = 0;
	else
		v = 0;
		i = sqrt(salida*imax**2);
	end

end
