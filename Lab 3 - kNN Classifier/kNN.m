%Enrique Rebollo González (5350720)
%Machine Learning I
%Lab 3 - KNN Classifier

function [MostFreq, Error, CumulErr, E]= kNN(Training, TraLab, Test, k, TestLab)
    n=nargin;
    [r1,c1] = size(Training);
    [r2,c2] = size(Test);

    if (n ~= 4) && (n ~= 5)
        error('The number of input arguments is not valid')
    end
    if c1~=c2
        error('The Training and the Test set have diffent number of columns')
    end
    if k<1 || k>r1
        error('The value of k is not valid')
    end
    
    %Compute the distance between each point from the Test set (the ones 
    %that we want to classify) and each point from the Training set
    Pos = zeros(r2,k);
    Values = zeros(r2,k);
    MostFreq = zeros(r2,1);
    
    Dist = pdist2(Test, Training);
    for i=1:r2
        [~, Pos(i,:)] = mink(Dist(i,:), k); %stores the position in the array
        Values(i,:) = TraLab(Pos(i,:),1); %stores the values of the kNN found
        MostFreq(i,1) = mode(Values(i,:)); %obtains the most frequent value for the kNN
    end
    
    %If nargin = 5, calculates the error
    Error = zeros(r2,3);
    E=zeros(10,10);
    if n == 5
        No=0;
        for i=1:r2
            Error(i,1) = MostFreq(i,1);
            Error(i,2) = TestLab(i,1);
            if Error(i,1) == Error(i,2)
                Error(i,3) = 1;
            else
                Error(i,3) = 0;
                No = No+1;
                E(Error(i,1),Error(i,2))= E(Error(i,1),Error(i,2))+1;
            end
        end
        CumulErr = (No/r2)*100;
%         E = (E/No)*100;
    end
end



