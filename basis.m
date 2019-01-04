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
nx = size(x);
nx = nx(2);
ny = size(y);
ny = ny(2);
if nx~=ny
    disp('n(x) is not equal to n(y)!');
    return;
end
zero = input('1.Non-zero Intercept\n2.Zero Intercept');
zero = 0;
deg = input('Degree of polynomial to be fitted: ');
M0 = zeros(deg+1);
Y0 = ones(deg+1);
Y0 = Y0(:,1);
M1 = zeros(deg);
Y1 = ones(deg);
Y1 = Y1(:,1);
if zero==0
    for i=0:deg
        for j=0:deg
            M0(i+1,j+1) = dot((x.^i),(x.^j));
        end
    end
    for i=0:deg
        Y0(i+1) = dot(y,x.^i);
    end
elseif zero==1
    for i=1:deg
        for j=1:deg
            M1(i+1,j+1) = dot((x.^i),(x.^j));
        end
    end
    
    for i=1:deg
        Y1(i+1) = dot(y,x.^i);
    end
    
end
if zero==0
    A = M0;
    Y = Y0;
elseif zero==1
    A = M1;
    Y = Y1;
end
Id = eye(size(A,1));
i = 1;

while i<=size(A,1)
    j = 1;
    if A(i,i)==0
        if i~=size(A,1)
            B = A(i,:);
            A(i,:) = A(i+1,:);
            A(i+1,:)= B;
            B = Id(i,:);
            Id(i,:) = Id(i+1,:);
            Id(i+1,:)= B;
        end
    end
    temp = A(i,i);
    A(i,:) = A(i,:)/temp;
    Id(i,:) = Id(i,:)/temp;
    
    while j<=size(A,1)
        
        if j~=i
            temp = A(j,i);
            A(j,:) = A(j,:)- temp*A(i,:);
            Id(j,:) = Id(j,:)- temp*Id(i,:);
            
        end
        j = j+1;
    end
    i = i+1;
end

C = Id*Y;
C = C.';
disp(C);
c = linspace(x(1),x(nx),5000);
p = polyval(fliplr(C),c);
plot(c,p,'red');
hold on
scatter(x,y,'green','filled');
hold off
saveas(gcf,'basis.png')