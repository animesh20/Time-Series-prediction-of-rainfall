load rainfall.txt;
target=reshape(rainfall',1212,1);
train_t=zeros(872,1);
n=1;
for i=121:992
    train_t(n)=target(i);
    n=n+1;
end
test_t=zeros(220,1);
n=1;
for i=993:1212
    test_t(n)=target(i);
    n=n+1;
end
train_i=zeros(872,21);
n=1;
for i=121:992
    for j=1:12
        train_i(n,j)=target(i-j);
    end
    for k=1:9
        train_i(n,k+12)=target(i-((k+1)*12));
    end
    n=n+1;
end
test_i=zeros(220,21);
n=1;
for i=993:1212
    for j=1:12
        test_i(n,j)=target(i-j);
    end
    for k=1:9
        test_i(n,k+12)=target(i-((k+1)*12));
    end
    n=n+1;
end

%arg = '-s 3 -c 00 -g 0.0000017 -p 19.5 -t 2';
arg1 = '-s 3 -c ';
arg2 = ' -g 0.0000017 -p 19.5 -t 2';

% this c_val gives 100 percent performance
% vary c parameter from 0 to 2000
len = 200;
inc = (200-0)/len;
values = zeros(1,len);
c_val = 0;
arg(9) = 48; % ascii value of 0 is 48
arg(10) = 48; % ascii value of 0 is 48

perf = zeros(1,len);

for j = 1:len
    % the c parameter of arg is at 9 and 10 position
    c_val = c_val + inc*10;
    temp = num2str(c_val);
    temp = [arg1 temp arg2];
   % Train the SVM network
   model = svmtrain(train_t, train_i, temp);
   [predict_label, accuracy, dec_values] = svmpredict(test_t, test_i, model);
   c_val
   perf(j) = accuracy(2);
   values(j) = c_val;
end

plot(values, perf);
title('MSE vs Penalty parameter C');
xlabel('Penalty parameter C');
ylabel('MSE');
