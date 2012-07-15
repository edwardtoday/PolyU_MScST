%%% Some examples of array and matrix manipulation

%% Cleanup the environment
clear; % clear the workspace 
clc; % clean the screen

x = [1.0 2 3.0]
A = [4.0 5.0 7.0; 8.1 6.2 1.2]


A = [A ; x] % combine x and A to the new A
fprintf('press enter to continue \n');
pause

%% Inverse of A
inv(A)
fprintf('press enter to continue \n');
pause

%% Transpose of matrix A
B = A'
fprintf('press enter to continue \n');
pause

%% Sum of matrices
C = A + B
fprintf('press enter to continue \n');
pause

%% Matrix Products
C = A*B  %product of A and B
C = A.*B %multiply the corresponding elements in A and B
y = C*x' %product of a matrix with a vector gives a vector 

fprintf('press enter to continue \n');
pause

y*x	%The product of a column vector with a row vector gives a matrix
x*y   %The product of a row vector with a column vector gives a scalar number
