function conj = conjuntizate(n, ancho)
	%triangulos en [-1;1], todos iguales
	conj = zeros(2*n+1,3);
	centro = linspace(-1,1,2*n+1);
	delta = 1/n;
	for K = 2:2*n
		offset = ancho*delta;
		conj(K,:) = [centro(K)-offset, centro(K), centro(K)+offset];
	end
	conj(1,:) = [-1.001, -1, -1+2*delta];
	conj(2*n+1,:) = [1-2*delta, 1, 1.001];
end
