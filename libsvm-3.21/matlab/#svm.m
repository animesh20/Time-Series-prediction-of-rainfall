%x is the input and y is the target. 
x = (-1:0.05:1)';
y=0.6*sin(pi*x)+0.3*sin(3*pi*x)+0.1*sin(5*pi*x);
er = 0;
poly = 1;
for deg = 1:10
    m = svmtrain(y,x, strcat({'-s 3 -t 1 -d '},{num2str(deg)}));
    [a, b, c] = svmpredict(y, x, m);
    if (er > b(2))
        er = b(2);
        poly = deg;
    end
end
m = svmtrain(y,x, '-s 3 -t 2 -g 6.0 -c 100');
[a, b, c] = svmpredict(y, x, m);
plot(x,y,x,a)
