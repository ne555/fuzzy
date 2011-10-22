function [c, area] = centroide(v)
	area1 = (v(2)-v(1))/2;
	area2 = (v(3)-v(2))/2;

	area = area1 + area2;

	c1 = v(2) - (v(2)-v(1))*(1/3);
	c2 = v(2) + (v(3)-v(2))*(1/3);

	c = (c1*area1 + c2*area2)/area; 
end
