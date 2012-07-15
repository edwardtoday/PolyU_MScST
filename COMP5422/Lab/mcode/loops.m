%%% loops.m: to run this script, at the matlab prompt type
%%% loops
%%% 

clear;%clear the workspace

% example 1
%%% this is an example of for and if-then-else statements:
%%% define an array filled with 8 random numbers, loop
%%% through and if value < 0.5 then set to zero, otherwise
%%% set to 1.0

n = 8;
A = rand(1,8) %%generate a vector A radomly

for i = 1:n,
	if A(i) < 0.5;
	   A(i) = 0.0;
	else
	   A(i) = 1.0;
	end
end

A

fprintf('press enter to continue \n');
pause

%'example 2'
%%% Divide a large number x by 2 until x<=1.
%%% Keep track of the number of iterations and display it.

x = 100000000000000;
iter = 0;
while (x > 1)
  x = x / 2;
  iter = iter + 1;
end
x
sprintf('Number of iterations = %d', iter)

