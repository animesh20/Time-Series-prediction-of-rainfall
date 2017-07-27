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
m = svmtrain(train_t,train_i, '-s 3 -t 2 -g 0.0000017 -c 80 -p 19.5 -e 0.0001');
[a, b, c] = svmpredict(test_t,test_i, m);
mean_error=(sum(abs(a-test_t)))/220;