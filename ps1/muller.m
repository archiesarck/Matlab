cof = input('Give array of co-efficient as [an a(n-1) .... a0]: ');
x1 = input('Keeping in mind x1<x2<x3, provide x1: ');
x2 = input('Provide x2: ');
x3 = input('Provide x3: ');
i3 = x3;
i1 = x1;
i2 = x2;
ite = [];
error = [];
re = input('Convergence criterion:\n1.Relative Error: \n');
fe = input('2.Functional Error: \n');
loops = input('3.Number of iterations: \n');
i = 0;
while (abs((x3-x2)/x2)>re)&&(abs(polyval(cof,x3))>fe)&&(loops>0)
        c = polyval(cof,x3);
        a = (((polyval(cof,x3)-polyval(cof,x2))/(x3-x2))-((polyval(cof,x2)-polyval(cof,x1))/(x2-x1)))/(x3-x1);
        b = (polyval(cof,x3)-polyval(cof,x2))/(x3-x2) + (x3-x2)*a;
        root1 = (b+sqrt(b*b-4*a*c))/(2*a);
        root2 = (b-sqrt(b*b-4*a*c))/(2*a);      
        x1 = x2;
        x2 = x3;
        if abs(polyval(cof,x3-root1))>abs(polyval(cof,x3-root2))
            x3 = x3-root2;
        else
            x3 = x3-root1;
        end
        loops = loops-1;
        i = i+1;
        ite = [ite,i];
        error = [error,(x3-x2)/x2];
end
disp(x3);
if abs((x3-x2)/x2)<re
    disp('Stopped due to error condition');
elseif loops==0
    disp('Stopped due to iteration limit');
end

arr = [i1 i2 i3 x1 x2 x3];
if isreal(arr)
    clear min;
    clear max;
    m = min(arr);
    M = max(arr);
else
    m = i1;
    M = i3;
end
subplot(1,2,1);

r = linspace(m,M,(M-m)*100);
y = polyval(cof,r);
plot(r,y);
title('Function Plot');
ax = [m M];
ay = [0 0];
hold on
axis manual
plot(ax,ay);
hold off
subplot(1,2,2);

plot(ite,error);
hold on
axis manual
plot(ite,zeros(i));
hold off
title('Error Plot');