%%% Some examples of basic array and matrix manipulations

%% Cleanup the environment
clear; % clear the workspace 
clc; % clean the screen

%% To create a vector
v = [1.0 2 3.0 4.0]
fprintf('press enter to continue \n');
pause

%% To create a a 2x4 matrix
A = [4.0 5.0 7.0 8.0;  9.0 10.0 11.0 12.0]
fprintf('press enter to continue \n');
pause

%% To create a main diagonal matrix
D = diag(v)
fprintf('press enter to continue \n');
pause

%%4x4 identity matrix
eye(4)
fprintf('press enter to continue \n');
pause

%% Combine the blocks D and the 4x4 identity into an 8x4 matrix
%% notice the answer is left in the special variable ans
[D; eye(4)]
fprintf('press enter to continue \n');
pause

%% a 3x3 matrix of all zeros (done 2 different ways)
Z = zeros(3)
Z = zeros(3,3)
fprintf('press enter to continue \n');
pause

%% a matrix of all ones
O = ones(2,3)

