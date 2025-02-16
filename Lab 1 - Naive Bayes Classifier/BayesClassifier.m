%Enrique Rebollo González (5350720)
%Machine Learning I
%Lab 1 - Naive Bayes Classifier

function [Decision, ErrRate] = BayesClassifier(matrix1, matrix2)
    %The function BayesClassifier receives as input:
    %Training Set (matrix1)
    %Test Set (matrix2)
    
    %It returns the Error Rate and the Decision Matrix:
    %Column 1: Probability of Yes
    %Column 2: Probability of No
    %Column 3: Decision (2='Yes' or 1='No')
    %Column 4: 1='Correct' or 0='Incorrect'
    
    [r1,c1] = size(matrix1);
    [r2,c2] = size(matrix2);
    
    %1: Check size of the Test Set and values smaller than 1
        if c2<(c1-1)
            error('The Test Set does not have enough columns')
        end
    
        
        for i=1:r1
            for j=1:c1
                if matrix1(i,j) < 1
                    error('A value in the Training Set is smaller than 1')
                end
            end
        end
        for i=1:r2
            for j=1:c2
                if matrix2(i,j) < 1
                    error('A value in the Test Set is smaller than 1')
                end
            end
        end
    
    
    %2: Probabilities computation
        %Compute probability of Yes and No
        Yes=0;No=0;
        for i=1:r1
            if matrix1(i,c1)==2
                Yes=Yes+1;
            elseif matrix1(i,c1)==1
                No=No+1;
            else
                error('Unexpected target value')
            end
        end
        ProbYes=Yes/r1;
        ProbNo=No/r1;
        
        %Compute the probabilities for each variable
        %Laplace Smoothing parameter (s)
        s=0.1;
        
        for j=1:(c1-1)
            [a,~] = size(unique(matrix1(:,j)));
            NumVar1(j)= a;
            A = ones(1,a)*s;
            B = ones(1,a)*s;
            for i=1:r1
                if matrix1(i,c1)==2
                    for n=1:NumVar1(j)
                        if matrix1(i,j)==n
                            A(n)=A(n)+1;
                        end
                    end
                elseif matrix1(i,c1)==1
                    for n=1:NumVar1(j)
                        if matrix1(i,j)==n
                            B(n)=B(n)+1;
                        end
                    end
                end
            end
            P{1,j} = A/(Yes+(s*NumVar1(j)));
            P{2,j} = B/(No+(s*NumVar1(j)));
        end
        
        
    %3: Classify the Test Set
        for i=1:r2
            Y=zeros(1,(c2-1));
            N=zeros(1,(c2-1));
            %Checking if the Test set contains values not present in the Training set
%             for j=1:(c2-1)
%                 Var1 = unique(matrix1(:,j));
%                 NumVar1 = size(unique(matrix1(:,j)));
%                 Var2 = unique(matrix2(:,j));
%                 NumVar2 = size(unique(matrix2(:,j)));
%                 for a=1:NumVar2
%                     aux = 0;
%                     for b=1:NumVar1
%                         if Var1(b) == Var2(a)
%                             aux = 1;
%                         end
%                     end
%                     if aux == 0
%                         error('Value from Test set not present in Training set')
%                     end
%                 end
%             end
                for n=1:NumVar1(j)
                    if matrix2(i,j)==n
                        A=P{1,j}; B=P{2,j};
                        Y(j) = A(n);
                        N(j) = B(n);
                    end
                end
            Y(1)=Y(1)*ProbYes;
            N(1)=N(1)*ProbNo;
            for j=2:(c2-1)
                Y(1)=Y(1)*Y(j);
                N(1)=N(1)*N(j);
            end
            Decision(i,1) = Y(1);
            Decision(i,2) = N(1);
            if Decision(i,1) < Decision(i,2) 
                Decision(i,3) = 1;
            else
                Decision(i,3) = 2;
            end
        end
 
        
    %4: Check results from the Test Set if it has target column
        if c1 == c2
            Cor=0; Incor=0;
            for i=1:r2
                if Decision(i,3) == matrix2(i,c2)
                    Decision(i,4) = 1;
                    Cor=Cor+1;
                else
                    Decision(i,4) = 0;
                    Incor=Incor+1;
                end
            end
            ErrRate=(Incor)/(Cor+Incor);
        else
            ErrRate=0;
        end

    