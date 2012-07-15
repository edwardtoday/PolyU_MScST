%% Basic Matrix Operations
% This is a demonstration of some aspects of the MATLAB language.

% First, let's create a simple vector with 9 elements called |a|.

a = [1 2 3 4 6 4 3 4 5]

fprintf('press enter to continue \n');
pause

% Now let's add 2 to each element of our vector, |a|, and store the result in a
% new vector.
% 
% Notice how MATLAB requires no special handling of vector or matrix math.

b = a + 2

fprintf('press enter to continue \n');
pause

% Creating graphs in MATLAB is as easy as one command.  Let's plot the result of
% our vector addition with grid lines.
figure(1);
plot(b)
grid on

fprintf('press enter to continue \n');
pause

% MATLAB can make other graph types as well, with axis labels.

bar(b)
xlabel('Sample #')
ylabel('Pounds')

fprintf('press enter to continue \n');
pause

% MATLAB can use symbols in plots as well.  Here is an example using stars
% to mark the points.  MATLAB offers a variety of other symbols and line
% types.

plot(b,'*')
axis([0 10 0 10])

fprintf('press enter to continue \n');
pause

close all; %close all the figure windows

% One area in which MATLAB excels is matrix computation.
 
% Creating a matrix is as easy as making a vector, using semicolons (;) to
% separate the rows of a matrix.

A = [1 2 0; 2 5 -1; 4 10 -1]

fprintf('press enter to continue \n');
pause

% We can easily find the transpose of the matrix |A|.

B = A'

fprintf('press enter to continue \n');
pause

% Now let's multiply these two matrices together.
% 
% Note again that MATLAB doesn't require you to deal with matrices as a
% collection of numbers.  MATLAB knows when you are dealing with matrices and
% adjusts your calculations accordingly.

C = A * B

fprintf('press enter to continue \n');
pause

% Instead of doing a matrix multiply, we can multiply the corresponding elements
% of two matrices or vectors using the .* operator.

C = A .* B

fprintf('press enter to continue \n');
pause

% Let's find the inverse of a matrix ...

X = inv(A)

fprintf('press enter to continue \n');
pause

% ... and then illustrate the fact that a matrix times its inverse is the
% identity matrix.

I = inv(A) * A

fprintf('press enter to continue \n');
pause

% At any time, we can get a listing of the variables we have stored in memory
% using the |who| or |whos| command.

whos

fprintf('press enter to continue \n');
pause

%%
% You can get the value of a particular variable by typing its name.

A

fprintf('press enter to continue \n');
pause

%%
% You can have more than one statement on a single line by separating each
% statement with commas or semicolons.
% 
% If you don't assign a variable to store the result of an operation, the result
% is stored in a temporary variable called |ans|.

sqrt(-1)

fprintf('press enter to continue \n\n');
pause

%%
% As you can see, MATLAB easily deals with complex numbers in its
% calculations.


fprintf('End of the introduction \n');
