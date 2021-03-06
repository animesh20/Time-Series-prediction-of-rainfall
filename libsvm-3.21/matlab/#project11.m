load rainfall.txt;
load min_temp.txt;
load avg_temp.txt;
load max_temp.txt;
load cloud_cover.txt;
load vapour_pressure.txt;
load wet_day_freq.txt;
load diurnal_temp_range.txt;
load ground_frost_freq.txt;
load ref_crop_evap.txt;
load pot_evap.txt;
target=rainfall;
a1=min_temp;
a2=avg_temp;
a3=max_temp;
a4=cloud_cover;
a5=vapour_pressure;
a6=wet_day_freq;
a7=diurnal_temp_range;
a8=ground_frost_freq;
a9=ref_crop_evap;
a10=pot_evap;
train_t=zeros(972,1);
n=1;
for i=1:81
    for j=1:12
        train_t(n)=target(i,j);
        n=n+1;
    end
end
test_t=zeros(240,1);
n=1;
for i=82:101
    for j=1:12
        test_t(n)=target(i,j);
        n=n+1;
    end
end
train_i=zeros(972,10);
o=1;
for i=1:81
    for j=1:12
        train_i(o,1)=a1(i,j);
        train_i(o,2)=a2(i,j);
        train_i(o,3)=a3(i,j);
        train_i(o,4)=a4(i,j);
        train_i(o,5)=a5(i,j);
        train_i(o,6)=a6(i,j);
        train_i(o,7)=a7(i,j);
        train_i(o,8)=a8(i,j);
        train_i(o,9)=a9(i,j);
        train_i(o,10)=a10(i,j);
        o=o+1;
    end
end
test_i=zeros(240,10);
o=1;
for i=82:101
    for j=1:12
        test_i(o,1)=a1(i,j);
        test_i(o,2)=a2(i,j);
        test_i(o,3)=a3(i,j);
        test_i(o,4)=a4(i,j);
        test_i(o,5)=a5(i,j);
        test_i(o,6)=a6(i,j);
        test_i(o,7)=a7(i,j);
        test_i(o,8)=a8(i,j);
        test_i(o,9)=a9(i,j);
        test_i(o,10)=a10(i,j);
        o=o+1;
    end
end

%arg = '-s 3 -c 00 -g 0.00019 -p 19.6 -t 2';
arg1 = '-s 3 -c ';
arg2 = ' -g 0.00019 -p 19.6 -t 2';

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
