%x is the input and y is the target. 
x = (-1:0.01:1)';
y=0.6*sin(pi*x)+0.3*sin(3*pi*x)+0.1*sin(5*pi*x);

trainx=x(1:2:201);
trainy=y(1:2:201);

testx=x(2:2:201);
testy=y(2:2:201);

m = svmtrain(trainy,trainx, '-s 3 -t 2 -p 0.005 -g 30 ');
[a, b, c] = svmpredict(testy, testx, m);
plot(trainx,trainy,testx,a)