u = input('Initial Point: ');
v = input('Final Point: ');
h = input('Give Height: ');
x = u:h:v;
n = size(x);
n = n(2);
x = x(2:n);
n = size(x);
n = n(2);
a = input('Initial boundary: ');
b0 = input('Derivative at last point: ');
I = 1;
S = zeros(n-1,1);
l = zeros(1,n-2);
d = zeros(1,n-1);
u = zeros(1,n-2);
for i = 2:n-2
    l(I) = 1/(h^2) + (x(i)+3)/((x(i)+1)*2*h);
    d(I+1) = (x(i)+3)/((x(i)+1)^2) - 2/(h^2);
    u(I+1) = 1/(h^2) - (x(i)+3)/((x(i)+1)*2*h);
    S(i) = 2*(x(i)+1) + 3*(x(i)+3)/((x(i)+1)^2);
    I = I+1;
end
a1 = 1/(h^2) + (x(1)+3)/((x(1)+1)*2*h);
S(1) = 2*(x(1)+1) + 3*(x(1)+3)/((x(1)+1)^2) - a*a1;
d(1) = -2/(h^2) + (x(1)+3)/((x(1)+1)^2);
u(1) = 1/(h^2) - (x(1)+3)/((x(1)+1)*2*h);

g1 = 1/(h^2) - (x(n-1)+3)/((x(n-1)+1)*2*h);
S(n-1) = 2*(x(n-1)+1) + 3*(x(n-1)+3)/((x(n-1)+1)^2) - 2*g1*b0*h/3;
l(n-2) = 1/(h^2) + (x(n-1)+3)/((x(n-1)+1)*2*h) - g1/3;
d(n-1) = -2/(h^2) + (x(n-1)+3)/((x(n-1)+1)^2) + 4*g1/3;
b = S;
n = n-1;
alpha = ones(n);
alpha = alpha(1,:);
alpha(1) = d(1);
beta = ones(n);
beta = beta(1,:);
beta(1) = b(1);
i = 2;
sol = zeros(n);
sol = sol(1,:);

while i<=n-1
    alpha(i) = d(i)-(l(i-1)/alpha(i-1))*u(i-1);
    beta(i) = b(i)-(l(i-1)/alpha(i-1))*beta(i-1);
    i = i+1;
end
sol(n) = beta(n)/alpha(n);

k = n-1;

while k>0
    
    sol(k) = (beta(k)-u(k)*sol(k+1))/alpha(k);
    k = k-1;
end
n = n+1;
y = zeros(1,n);
for i = 1:n-1
    y(i) = sol(i);
end
y(n) = 2*b0*h/3 + 4*y(n-1)/3 - y(n-2)/3;
gx = zeros(1,n+1);
gy = zeros(1,n+1);
gy(2:n+1) = y;
gy(1) = a;
gx(2:n+1) = x;
gx(1) = 0;
disp('x: ');
disp(gx);
disp('y: ');
disp(gy);
scatter(gx,gy,'filled');