%Enrique Rebollo González (5350720)
%Machine Learning I
%Lab 4 - Neural Networks

%These rows are commented and uncommented depending on the numbers we want
%to compare
% Tra0 = loadMNIST(0,10); %Label for 0 is 10
% Tra1 = loadMNIST(0,1);
% Tra2 = loadMNIST(0,2);
% Tra3 = loadMNIST(0,3);
Tra4 = loadMNIST(0,4);
% Tra5 = loadMNIST(0,5);
% Tra6 = loadMNIST(0,6);
% Tra7 = loadMNIST(0,7);
% Tra8 = loadMNIST(0,8);
Tra9 = loadMNIST(0,9);

row_idx = randperm(5421, 5421); %5421 size of smaller Training set
Training = [Tra4(row_idx(1:600),:); Tra9(row_idx(1:600),:)];
nh = 2; %number of hidden layers

myAutoencoder = trainAutoencoder(transpose(Training), nh);
myEncodedData = encode(myAutoencoder, transpose(Training));

t = ones(600,1);
t = [t; ones(600,1)*2];
myEncodedData = transpose(myEncodedData);
plot(myEncodedData(1:600,1), myEncodedData(1:600,2), '.r')
hold on
plot(myEncodedData(601:1200,1), myEncodedData(601:1200,2), '.b')

