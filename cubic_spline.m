file_name = input('Input the file name: ','s');
file_name = strcat(file_name,'.txt');
fid = fopen(file_name,'r');
if ~exist(file_name,'file')
    disp('No such file exists!');
    return;
end
x = fgets(fid);
y = fgets(fid);
y = str2num(y); %#ok<ST2NM>
x = str2num(x); %#ok<ST2NM>
n = size(x);
n = n(2);

h = zeros(n-1);
for i=1:n-1
    h(i) = x(i+1)-x(i);
end
v = zeros(n);
for i = 1:n-2
    v(i,i) = h(i);
    v(i,i+1) = 2*(h(i)+h(i+1));
    v(i,i+2) = h(i+1);
end
vect = zeros(n);
vect = vect(1,:);
for i = 1:n-2
    vect(i) = 6*(y(i+2)-y(i+1))/(x(i+2)-x(i+1)) - 6*(y(i+1)-y(i))/(x(i+1)-x(i));
end

%0 = Natural
%1 = Parabolic
%2 = NK
%3 = Periodic
%4 = clamped spline
spline = input('1. Natural\n2. Parabolic\n3. Not-a-Knot\n4. Periodic\n5. Clamped\n');
spline = spline-1;
if spline>4
    disp('Non-sense');
    return;
end
if spline==0
    v(n-1,1) = 1;
    vect(n-1) = 0;
    v(n,n) = 1;
    vect(n) = 0;
elseif spline==1
    if n==2
        disp('Can not be solved as v is singular');
        return;
    end
    v(n-1,1) = 1;
    v(n-1,2) = -1;
    vect(n-1) = 0;
    v(n,n-1) = 1;
    v(n,n) = -1;
    vect(n) = 0;
elseif spline==2
    if n==2
        disp('Two heights are needed');
        return;
    end
    v(n-1,1) = -h(2);
    v(n-1,2) = h(1)+h(2);
    v(n-1,3) = -h(1);
    v(n,n-2) = -h(n-1);
    v(n,n-1) = h(n-1)+h(n-2);
    v(n,n) = -h(n-2);
elseif spline==3
    disp('Periodic');
    v(n-1,1) = 1;
    v(n-1,n-1) = -1;
    v(n,2) = 1;
    v(n,n) = -1;
elseif spline==4
    alpha = input('Alpha ');
    beta = input('Beta ');
    v(n-1,1) = 2;
    v(n-1,2) = 1;
    v(n,n) = 2;
    v(n,n-1) = 1;
    vect(n-1) = (6/h(1))*(((y(2)-y(1))/(x(2)-x(1)))-alpha);
    vect(n) = (6/h(n-1))*(beta-((y(n)-y(n-1))/(x(n)-x(n-1))));
end
vect = vect.';
sol = v\vect;
sol = sol.';
gx = linspace(x(1),x(n),(n-1)*100);
gy = zeros(100*(n-1));
dy = zeros(n-1,n);
d2y = zeros(n-1,n);
coeff = zeros(n-1,4);
loop = 1;
for i=1:n-1
    coeff(i,1) = (sol(loop+1)-sol(loop))/(6*h(loop));
    coeff(i,2) = (sol(loop)*x(loop+1)-sol(loop+1)*x(loop))/(2*h(loop));
    coeff(i,3) = (y(loop+1)-y(loop))/h(loop)+(sol(loop)-sol(loop+1))*h(loop)/6 + (sol(loop+1)*x(loop)*x(loop)-sol(loop)*x(loop+1)*x(loop+1))/(2*h(loop));
    coeff(i,4) = (sol(loop)*(x(loop+1)^3)-sol(loop+1)*(x(loop)^3))/(6*h(loop)) + sol(loop+1)*h(loop)*x(loop)/6 - sol(loop)*h(loop)*x(loop+1)/6 + y(loop)*x(loop+1)/h(loop) - y(loop+1)*x(loop)/h(loop);
    loop = loop+1;
end
for i = 1:n-1
    gy((i-1)*100+1:i*100) = polyval(coeff(i,:),gx((i-1)*100+1:i*100));
    
end
fid = fopen('cubic.txt','w');
for i=1:n-1
    for j=1:4
        fprintf(fid,'%d ',coeff(i,j));
    end
    fprintf(fid,'\r\n');
end
fclose(fid);
diff1 = coeff;
for i=1:n-1
    for j=1:4
        diff1(i,j) = (4-j)*coeff(i,j);
    end
end
diff1(:,[3 4]) = diff1(:,[4 3]);
diff1(:,[2 3]) = diff1(:,[3 2]);
diff1(:,[1 2]) = diff1(:,[2 1]);

diff2 = diff1;
for i=1:n-1
    for j=1:4
        diff2(i,j) = (4-j)*diff1(i,j);
    end
end
diff2(:,[3 4]) = diff2(:,[4 3]);
diff2(:,[2 3]) = diff2(:,[3 2]);
diff2(:,[1 2]) = diff2(:,[2 1]);

for i = 1:n-1
    dy(i,:) = polyval(diff1(i,:),x);
end

for i = 1:n-1
    d2y(i,:) = polyval(diff2(i,:),x);
end
disp('Blue:Main Plot ');
disp('Purple:First Derivative ');
disp('Pink:Second Derivative ');
disp('First Derivative');
disp(dy);
disp('Second Derivative');
disp(d2y);
plot(gx,gy);
hold on
scatter(x,y,'green','filled');

hold off
saveas(gcf,'cs.png')