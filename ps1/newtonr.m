str = input('Input the function: ','s');

str = strcat('@(x)',str);
f = str2func(str);
strd = input('Input the derivative: ','s');
strd = strcat('@(x)',strd);
fd = str2func(strd);
a = input('Starting Point: ');
re = input('Convergence criterion:\n1.Relative Error: \n');
fe = input('2.Functional Error: \n');
loops = input('3.Number of iterations: \n');
iterate = [];
error = [];
i = 0;
b = a+re+1;
while (abs((b-a)/a)>re)&&(abs(f(b))>fe)&&(loops>0)
        a = b;
        b = a-f(a)/fd(a);
        loops = loops-1;
        i = i+1;
        iterate = [iterate,i];
        error = [error,(b-a)/a];
end
disp(b);
if abs((b-a)/a)<re
    disp(' Stopped due to Error Condition');
elseif loops==0
    disp(' Stopped due to Iteration Limit');
end
max = 5*abs(a);
min = -5*abs(a);
subplot(1,2,1);
r = linspace(min,max,200*max);
f = str2func(str);
y = arrayfun(f,r);
plot(r,y);
ax = [min max];
ay = [0 0];
hold on
axis manual
plot(ax,ay);
hold off
subplot(1,2,2);
plot(iterate,error);
title('Error Plot');
hold on
axis manual
plot(iterate,zeros(i));
hold off