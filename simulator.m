t_fin = 20;
n = 1000;
t = linspace(0,t_fin,n)';

T_i = zeros(size(t));
T_e = zeros(size(t));
T_r = zeros(size(t));
T_nada = zeros(size(t));
i = zeros(size(t));
v = zeros(size(t));

%puerta = floor(360*rand(1,n)+1)>359;
puerta = zeros(size(t));

%Puerta cerrada
%T_i = 0.912 * T_i(n-1) + 0.088 * T_e(n) + 0.604 *i^2(n) - 12.1*10^-3 *v(n);
%Puerta abierta
%T_i = 0.160 * T_i(n-1) + 0.831 * T_e(n) + 0.112 *i^2(n) - 2*10^-3 *v(n);
%T_r(1:n/2) = 1;
T_r = sign(sin(t));

T_e = -1.5*sin(t);
T_i(2) = T_r(2);
T_i(1) = T_i(1);
T_nada = T_i;

for K = [3:n]
	[v(K),i(K)] = controlador_2( T_r(K)-T_i(K-1), T_r(K)-T_e(K-1) );
	if(puerta(K))
		T_i(K) = 0.169*T_i(K-1) + 0.831*T_e(K) + 0.112*i(K)^2 - 2*10^-3*v(K);
	else
		T_i(K) = 0.912*T_i(K-1) + 0.088*T_e(K) + 0.604*i(K)^2 - 12.1*10^-3*v(K);
		T_nada(K) = 0.912*T_nada(K-1) + 0.088*T_e(K);
	end
end

figure(1);
clf;
hold on;
title 'Control de temperatura'
plot(t,T_i, '-*k');
plot(t,T_r, 'r');
plot(t,T_e, 'b');
hold off;

figure(2);
title 'Tension y corriente aplicados'
plot(t,v/220,'b', t,i/2,'r');

figure(3);
plot(t,T_nada,'k', t, T_i, 'r');

