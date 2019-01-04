file_name = input('Input the file name: ','s');
file_name = strcat(file_name,'.txt');
fid = fopen(file_name,'r');
if ~exist(file_name,'file')
    disp('No such file exists!');
    return;
end
X = fgets(fid);
y = fgets(fid);
y = str2num(y); %#ok<ST2NM>
X = str2num(X); %#ok<ST2NM>
n = size(X);
n = n(2);

tst = zeros(1,n);
p = [1];
for i=1:n
    p = [1];
    for j=1:n
        if i~=j
            p = conv(p,[1/(X(i)-X(j)),-X(j)/(X(i)-X(j))]);
        end
    end
    p = p*y(i);
    tst = tst+p;
end
fid = fopen('langr.txt','w');
for i = 1:n
    fprintf(fid,'%f ',tst(i));
end
fclose(fid);
x_val = linspace(X(1),X(n),1000);
y_val = polyval(tst,x_val);
plot(x_val,y_val,'red');
hold on
scatter(X,y,'green','filled');
hold off
saveas(gcf,'m.png')