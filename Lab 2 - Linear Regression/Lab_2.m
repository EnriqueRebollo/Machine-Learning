%Enrique Rebollo González (5350720)
%Machine Learning I
%Lab 2 - Linear Regression

%2.1 Turkish stock
turkish=load('turkish-se-SP500vsMSCI.csv');
[r,~]=size(turkish);
num=0; den=0;
for i=1:r
    num = num+(turkish(i,1)*turkish(i,2));
    den = den+(turkish(i,1)^2);
end
w = num/den;

f=@(x)w*x;
plot(turkish(:,1),turkish(:,2), 'b+', 'MarkerSize', 0.5, 'LineWidth', 0.5)
hold on
fplot(f, [-0.1 0.1])

%2.2 Turkish stock without intercept comparison of subsets
%Separate the data in 4 subsets from different periods
subset1 = turkish(1:r/4,:);
subset2 = turkish((r/4)+1:r/2,:);
subset3 = turkish((r/2)+1:(3*r/4),:);
subset4 = turkish((3*r/4)+1:r,:);
row_idx = randperm(r/4, r/4);

%1st and last 50 entries
%sample1 = turkish(1:50,:);
%sample4 = turkish(r-50:r,:);

%Obtain 4 random subsets, each one from a different period
sample1 = subset1(row_idx(1:50),:);
sample2 = subset2(row_idx(1:50),:);
sample3 = subset3(row_idx(1:50),:);
sample4 = subset4(row_idx(1:50),:);

num=0; den=0;
for i=1:50
    num = num + (sample1(i,1)*sample1(i,2));
    den = den + (sample1(i,1)^2);
end
w1 = num/den;

num=0; den=0;
for i=1:50
    num = num + (sample2(i,1)*sample2(i,2));
    den = den + (sample2(i,1)^2);
end
w2 = num/den;

num=0; den=0;
for i=1:50
    num = num + (sample3(i,1)*sample3(i,2));
    den = den + (sample3(i,1)^2);
end
w3 = num/den;

num=0; den=0;
for i=1:50
    num = num + (sample4(i,1)*sample4(i,2));
    den = den + (sample4(i,1)^2);
end
w4 = num/den;

plot(sample1(:,1),sample1(:,2), 'b+', 'MarkerSize', 0.5, 'LineWidth', 0.5)
hold on
plot(sample2(:,1),sample2(:,2), 'r+', 'MarkerSize', 0.5, 'LineWidth', 0.5)
hold on
plot(sample3(:,1),sample3(:,2), 'g+', 'MarkerSize', 0.5, 'LineWidth', 0.5)
hold on
plot(sample4(:,1),sample4(:,2), 'y+', 'MarkerSize', 0.5, 'LineWidth', 0.5)
hold on
f=@(x)w1*x; fplot(f, [-0.1 0.1], 'b')
hold on
f=@(x)w2*x; fplot(f, [-0.1 0.1], 'r')
hold on
f=@(x)w3*x; fplot(f, [-0.1 0.1], 'g')
hold on
f=@(x)w4*x; fplot(f, [-0.1 0.1], 'y')


%2.3 1D Motor Trend (mpg and weight)
cars=load('Cars.csv');
[R,~]=size(cars);
X=0; T=0;
for i=1:R
    X = X + cars(i,4);
    T = T + cars(i,1);
end
avX = X/R;
avT = T/R;

num=0; den=0;
for i=1:R
    num = num + ((cars(i,4)-avX)*(cars(i,1)-avT));
    den = den + ((cars(i,4)-avX)^2);
end
w1 = num/den;
w0 = avT - w1*avX;

f=@(x)w1*x+w0;
plot(cars(:,1),cars(:,4), 'b+', 'MarkerSize', 0.5, 'LineWidth', 0.5)
hold on
fplot(f, [-0.1 0.1])


%2.4 Multi D Motor Trend
X = [ones(R,1), cars(:,2:4)];
t = cars(:,1);
W = inv(transpose(X)*X)*transpose(X)*t;


%3.1 MSE (5% ~ 27 instances)
turkish=load('turkish-se-SP500vsMSCI.csv');
[r,~]=size(turkish);
MSEtra = zeros(20,1);
MSEtest = zeros(20,1);
for j=1:20 
    row_idx = randperm(r, r);
    training = turkish(row_idx(1:27),:);
    test = turkish(row_idx(28:r),:);
    num=0; den=0;
    for i=1:27
        num = num + (training(i,1)*training(i,2));
        den = den + (training(i,1)^2);
    end
    w = num/den;

    %Compute MSE for training
    for i=1:27
        MSEtra(j) = MSEtra(j)+((w*training(i,1))-training(i,2))^2;
    end
    MSEtra(j) = MSEtra(j)/27;

    %Compute MSE for test
    for i=1:(r-27)
        MSEtest(j) = MSEtest(j)+((w*test(i,1))-test(i,2))^2;
    end
    MSEtest(j) = MSEtest(j)/(r-27);
end

%3.3
cars=load('Cars.csv');
[R,~]=size(cars);
MSEtra = zeros(20,1);
MSEtest = zeros(20,1);
for j=1:20 
    row_idx = randperm(R, R);
    training = cars(row_idx(1:7),:);
    test = cars(row_idx(8:R),:);
    
    %Calculate w0 and w1
    Xtra=0; T=0;
    for i=1:7
        Xtra = Xtra + training(i,4);
        T = T + training(i,1);
    end
    avX = Xtra/7;
    avT = T/7;
    num=0; den=0;
    for i=1:7
        num = num + ((training(i,4)-avX)*(training(i,1)-avT));
        den = den + ((training(i,4)-avX)^2);
    end
    w1 = num/den;
    w0 = avT - w1*avX;

    %Compute MSE for training
    for i=1:7
        MSEtra(j) = MSEtra(j)+(((w1*training(i,4))+w0) - training(i,1))^2;
    end
    MSEtra(j) = MSEtra(j)/7;

    %Compute MSE for test
    for i=1:(R-7)
        MSEtest(j) = MSEtest(j)+(((w1*test(i,4))+w0) - test(i,1))^2;
    end
    MSEtest(j) = MSEtest(j)/(R-7);
end


%3.4
cars=load('Cars.csv');
[R,~]=size(cars);
MSEtra = zeros(20,1);
MSEtest = zeros(20,1);
for j=1:20 
    row_idx = randperm(R, R);
    training = cars(row_idx(1:7),:);
    test = cars(row_idx(8:R),:);
    
    %Calculate W
    Xtra = [ones(7,1), training(:,2:4)];
    Ttra = training(:,1);
    Wtra = inv(transpose(Xtra)*Xtra)*transpose(Xtra)*Ttra;
    Xtest = [ones(R-7,1), test(:,2:4)];
    Ttest = test(:,1);
    Wtest = inv(transpose(Xtest)*Xtest)*transpose(Xtest)*Ttest;
    
    %Compute MSE for training
    for i=1:7
        MSEtra(j) = MSEtra(j) + norm(Xtra*Wtra - Ttra)^2;
    end
    MSEtra(j) = sqrt(MSEtra(j)/7);

    %Compute MSE for test
    for i=1:(R-7)
        MSEtest(j) = MSEtest(j) + norm(Xtest*Wtest - Ttest)^2;
    end
    MSEtest(j) = sqrt(MSEtest(j)/(R-7));
end