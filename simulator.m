t_fin = 6;
n = 100;
t = linspace(0,t_fin,n)';

T_i = zeros(size(t));
T_e = zeros(size(t));
T_r = zeros(size(t));
i = zeros(size(t));
v = zeros(size(t));

puerta = zeros(size(t));

%puerta(42:54) = 1;

%Puerta cerrada
%T_i = 0.912 * T_i(n-1) + 0.088 * T_e(n) + 0.604 *i^2(n) - 12.1*10^-3 *v(n);
%Puerta abierta
%T_i = 0.160 * T_i(n-1) + 0.831 * T_e(n) + 0.112 *i^2(n) - 2*10^-3 *v(n);

T_e = -2.5*ones(size(t));
T_r = ones(size(t));
T_i(1) = T_r(1);
T_i(2) = T_r(2);

for K = [3:n]
	%[v(K),i(K)] = fuzzy_controller( T_i(K-1), T_r(K), T_e(K) );
	[v(K),i(K)] = controlador( T_r(K)-T_e(K-1) );
	if(puerta(K))
		T_i(K) = 0.912*T_i(K-1) + 0.088*T_e(K) + 0.604*i(K)^2 - 12.1*10^-3*v(K);
	else
		T_i(K) = 0.169*T_i(K-1) + 0.831*T_e(K) + 0.112*i(K)^2 - 2*10^-3*v(K);
	end
end

clf;
figure(1);
plot(t,T_i, '-*k');
hold on;
plot(t,T_r, 'r');
plot(t,T_e, 'b');
hold off;

figure(2);
plot(t,v,'k');


