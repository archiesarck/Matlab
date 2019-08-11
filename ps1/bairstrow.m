n = input('Degree: ');
a = input('Give array of co-efficient as [an a(n-1) .... a0]: ');
r = input('Provide r: ');
s = input('Provide s: ');
re = input('Convergence criterion:\n1.Relative Error: \n');
fe = input('2.Functional Error: \n');
loops = input('3.Number of iterations: \n');
iterate = [];
rerror = [];
serror = [];
l = 0;
ds = s*re+1;
while (loops>0)&&((abs(ds/s)>re)||(abs(dr/r)>re))
        b = [];
        c = [];
        b = [b,a(1)];
        b = [b,a(2)+r*b(1)];
        for i=3:n+1
            b = [b,a(i)+r*b(i-1)+s*b(i-2)];
        end
        c = [c,b(1)];
        c = [c,b(2)+r*c(1)];
        for i=3:n+1
            c = [c,b(i)+r*c(i-1)+s*c(i-2)];
        end
        dr = (c(n-1)*b(n)-b(n+1)*c(n-2))/(c(n)*c(n-2)-c(n-1)*c(n-1));
        ds = (c(n-1)*b(n+1)-b(n)*c(n))/(c(n)*c(n-2)-c(n-1)*c(n-1));
        r = r+dr;
        s = s+ds;
        loops = loops-1;
        l = l+1;
        iterate = [iterate,l];
        rerror = [rerror,dr];
        serror = [serror,ds];
end
if loops==0
    disp('Stopped due to iterative limit');
else
    disp('Stopped due to error condition');
end
root1 = (r+sqrt(r*r+4*s))/2;
root2 = (r-sqrt(r*r+4*s))/2;
disp(root1);
disp(root2);
subplot(1,2,1);
    m = -abs(r)-10;
    M = abs(r)+10;
x = linspace(m,M,(M-m)*100);
y = polyval(a,x);
plot(x,y);
title('Function Plot');
ax = [m M];
ay = [0 0];
hold on
axis manual
plot(ax,ay);
hold off
subplot(1,2,2);
plot(iterate,serror);
title('Error Plot');
hold on
axis manual
plot(iterate,rerror);
axis manual
plot(iterate,zeros(l));
hold off