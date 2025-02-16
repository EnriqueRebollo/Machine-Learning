% Script to demonstrate that a layer of linear units in Rosenblatt's
% simple perceptron is redundant because it can be summarized in just one
% vector of weights

% Assignments don't end with semicolon, so you can see the result of each
% operation. Values are generated at random and the threshold is 0, since
% we are not interested in the numerical results but only in showing that
% the result is the same with and without the A-units.


% Generate a random 2-dimensional matrix of 1 observation with values in [-1,1]
x = 2*rand(1,2)-1

% Generate random weights for 4 A-units as a matrix with 4 columns.
% Columns are 2-dimensional because they have to multiply the 2-dimensional
% observation
Wa = 2*rand(2,4)-1

% Generate random weights for 1 R-unit as a matrix with 1 column.
% The column is 4-dimensional because it has to multiply the vector of 4
% outputs from the 4 A-units
Wr = 2*rand(4,1)-1

% Calculate the output of the A-units. There is no activation function, so
% no nonlinear part
a1 = x(1,:)*Wa  % (1)

% Calculate the output of the r-units. Linear part (r1):
r1 = a1*Wr      % (2)
% Nonlinear activation to compute y1:
y1 = f(r1)


% ALTERNATIVE

% Now let's do the same by collapsing the weights. Performing (1) and (2)
% in cascade is equivalent to doing the following:
W = Wa*Wr
r2 = x(1,:)*W

% so we have r2 directly and we can compute the corresponding output y2:
y2 = f(r2)

% Let's check if the result is the same
fprintf("r1 and r2 are the same: %s\n",mat2str(abs(r1-r2)<1e-16)); % (*)
fprintf("y1 and y2 are the same: %s\n",mat2str(y1==y2));
% comparing floating point numbers should be done with a tolerance

% This shows that a linear A-layer with weights Wa can be collapsed into
% the weights Wr of the nonlinear R-unit and achieve the same result as a
% R-unit with weights W. So linear layers are redundant.




function a = f(r)
  theta = 0;
  a = 2*double(r>theta)-1;
end