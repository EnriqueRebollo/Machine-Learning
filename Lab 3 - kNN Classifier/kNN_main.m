%Enrique Rebollo González (5350720)
%Machine Learning I
%Lab 3 - KNN Classifier

%Loading each class by itself
Tra0 = loadMNIST(0,10); %Label for 0 is 10
Tra1 = loadMNIST(0,1);
Tra2 = loadMNIST(0,2);
Tra3 = loadMNIST(0,3);
Tra4 = loadMNIST(0,4);
Tra5 = loadMNIST(0,5);
Tra6 = loadMNIST(0,6);
Tra7 = loadMNIST(0,7);
Tra8 = loadMNIST(0,8);
Tra9 = loadMNIST(0,9);

Test0 = loadMNIST(1,10); %Label for 0 is 10
Test1 = loadMNIST(1,1);
Test2 = loadMNIST(1,2);
Test3 = loadMNIST(1,3);
Test4 = loadMNIST(1,4);
Test5 = loadMNIST(1,5);
Test6 = loadMNIST(1,6);
Test7 = loadMNIST(1,7);
Test8 = loadMNIST(1,8);
Test9 = loadMNIST(1,9);

TraLab=[]; TestLab=[];
for i=1:10
    TraLab = [TraLab; ones(600,1)*i];
end
for i=1:10
    TestLab = [TestLab; ones(100,1)*i];
end

row_idx = randperm(5421, 5421); %5421 size of smaller Training set
Training = [Tra1(row_idx(1:600),:); Tra2(row_idx(1:600),:); Tra3(row_idx(1:600),:); Tra4(row_idx(1:600),:); Tra5(row_idx(1:600),:); Tra6(row_idx(1:600),:); Tra7(row_idx(1:600),:); Tra8(row_idx(1:600),:); Tra9(row_idx(1:600),:); Tra0(row_idx(1:600),:)];
row_idx = randperm(892, 892); %892 size of smaller Test set
Test = [Test1(row_idx(1:100),:); Test2(row_idx(1:100),:); Test3(row_idx(1:100),:); Test4(row_idx(1:100),:); Test5(row_idx(1:100),:); Test6(row_idx(1:100),:); Test7(row_idx(1:100),:); Test8(row_idx(1:100),:); Test9(row_idx(1:100),:); Test0(row_idx(1:100),:)];

row_idx = randperm(6000, 6000);
Training = Training(row_idx(1:6000),:);
TraLab = TraLab(row_idx(1:6000),:);
row_idx = randperm(1000, 1000);
Test = Test(row_idx(1:1000),:);
TestLab = TestLab(row_idx(1:1000),:);

[MostFreq, Error, CumulErr, E] = kNN(Training, TraLab, Test, 10, TestLab);
% All(a)=CumulErr;
T=["Value Obtained" "Real Value" "1=Correct/0=Incorrect"];
Result=[T;Error];
% disp(Result)
fprintf('Error Rate: %.2f%%\n', CumulErr)
V=[1;2;3;4;5;6;7;8;9;0];
E=[V E];
E=["Errors" transpose(V); E];
disp(E)   


%reshape(X(1,:),28,28); %The images are a vector and we have to reshape them into a matrix


