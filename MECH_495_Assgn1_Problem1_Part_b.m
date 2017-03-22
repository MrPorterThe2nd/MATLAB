total = 0;
totals = 0;

%trapezoidal rule
for b = 1:n-2
 temp = (b+1-b)*(sol(b)+sol(b+1))/2;
 total = total + temp;
end

%simpson's 3/8's rule
for b = 1:2:n-2
 temps = (b+2-b)/6*(sol(b)+4*sol(b+1)+sol(b+2));
 totals = totals + temps;
end
