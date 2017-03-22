function y = heaviside(x,n)
% HEAVISIDE
% Returns x^n if x is positive and zero if x is negative
if (x > 0)
 if n >= 0
 y = x^n;
 else
 y = 0;
 end
else
 y = 0;
end 