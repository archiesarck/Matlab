str = input('Input the function g(x) where x=g(x): ','s');
str = strcat('@(x)',str);
g = str2func(str);
a = input('Starting point: ');
re = input('Convergence criterion:\n1.Relative Error: \n');
fe = input('2.Functional Error: \n');
loops = input('3.Number of iterations: \n');
iterate = [];
error = [];
i = 0;
b = a+re+1;
err = 10e-5;
c = a;
while (abs((b-c)/c)>re)&&(abs(g(a)-a)>fe)&&(loops>0)
    c = a;
    b = g(a);
    a = b;
    loops = loops-1;
    i = i+1;
    iterate = [iterate,i];
    error = [error,(b-c)/c];
end
disp(a);
if abs((b-c)/c)<re
    disp('Stopped due to error condition');
elseif loops==0
    disp('Stopped due to iteration limit');
end
if abs((b-c)/c)>re
    disp('Please increase the number of iterations!');
end
gmin = a-5;
gmax = a+5;
subplot(1,2,1);
r = linspace(gmin,gmax,(gmax-gmin)*100);
fun = strcat(str,'-x');
f = str2func(fun);
y = arrayfun(f,r);
plot(r,y);
title('Function Plot');
ax = [gmin gmax];
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