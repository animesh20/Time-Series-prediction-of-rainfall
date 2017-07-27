%x is the input and y is the target. 
x = (-1:0.05:1)';
y=0.6*sin(pi*x)+0.3*sin(3*pi*x)+0.1*sin(5*pi*x);
m = svmtrain(y,x, '-s 3 -t 2 -g 6.0 -c 100');
[a, b, c] = svmpredict(y, x, m);
plot(x,y,x,a)
