str = input('Input the function: ','s');
str = strcat('@(x)',str);
f = str2func(str);
min = input('Enter the min:');
gmin = 5*min;
max = input('Enter the max:');
gmax = 5*max;
re = input('Convergence criterion:\n1.Relative Error: \n');
fe = input('2.Functional Error: \n');
loops = input('3.Number of iterations: \n');
iterate = [];
error = [];
i = 0;
while (abs((max-min)/min)>re)||(abs(f(c))>fe)&&(loops>0) 
    c = (min+max)/2;
    if f(min)*f(c)<0
        max = c;
    elseif f(max)*f(c)<0
        min = c;
    elseif f(c)==0
        break;
    end
    loops = loops-1;
    i = i+1;
    iterate = [iterate,i];
    error = [error,(max-min)/min];
end
disp(c);
if abs((max-min)/min)<re
    disp('Program ended due to relative error limit');
elseif loops==0
    disp('Program ended due to iterative limit');
end
subplot(1,2,1);
r = linspace(gmin,gmax,(gmax-gmin)*100);
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