%Enrique Rebollo González (5350720)
%Machine Learning I
%Lab 1 - Naive Bayes Classifier

%1: Load data
data=load('weather_data(arrangedNumbers).txt');

%2: Split randomly into Training and Test Sets and
%3: Call Bayes Classifier
Cumulated=0;
for i=1:1000
    row_idx = randperm(14, 14);
    matrix1 = data(row_idx(1:10),:);
    matrix2 = data(row_idx(11:14),:);
    [Decision, ErrRate] = BayesClassifier(matrix1, matrix2);
    Cumulated = Cumulated + ErrRate;
end
ErrRate = Cumulated/10;

%4: Results
T=["ProbYes" "ProbNo" "1=No/2=Yes" "1=Correct/0=Incorrect"];
Result=[T;Decision];
disp(Result)
fprintf('Error Rate: %.2f%%\n', ErrRate)

