limit = 2.5;
entrada = linspace(-limit, 0, n)';
v = zeros(size(entrada));

for K = [1:n]
	[v(K)] = controlador_2(entrada(K), 0);
end

plot(entrada/limit, v, 'b');

