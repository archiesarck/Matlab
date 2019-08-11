str = input('Input the function: ','s');

str = strcat('@(x)',str);
f = str2func(str);
min = input('Enter the min: ');
max = input('Enter the max: ');
re = input('Convergence criterion:\n1.Relative Error: \n');
fe = input('2.Functional Error: \n');
loops = input('3.Number of iterations: \n');
iterate = [];
error = [];
i = 0;
while (abs((max-min)/min)>re)&&(abs(f(c))>fe)&&(loops>0)
        c = min - f(min)*((f(max)-f(min))/(max-min));
        
        loops = loops-1;
        if c<min
            max = min;
            min = c;
        else
            min = max;
            max = c;
        end
        
        i = i+1;
        iterate = [iterate,i];
        error = [error,(max-min)/min];
end


disp(c);
if abs((max-min)/min)<re
    disp('Stopped due to error condition');
elseif loops==0
    disp('Stopped due to iteration limit');
end
min = 1;
max = 4;
subplot(1,2,1);
r = linspace(min,max,(max-min)*100);
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