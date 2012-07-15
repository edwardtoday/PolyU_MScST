% The function computes the specified kernel matrix from the input data.
% 
% PROTOTYPE
% kermat = compute_kernel_matrix_PhD(X,Y,kernel_type,kernel_args);
% 
% USAGE EXAMPLE(S)
% 
% %   In all examples X and Y represent image data arranged into
% %   matrices/vectors
% 
%     Example 1:
%       kermat = compute_kernel_matrix_PhD(X,Y,'poly',[1 2]);
% 
%     Example 2:
%       kermat = compute_kernel_matrix_PhD(X,Y,'poly');
% 
%     Example 3:
%       kermat = compute_kernel_matrix_PhD(X,X,'fpp',[1 0.5]);
% 
%     Example 4:
%       kermat = compute_kernel_matrix_PhD(X,Y,'fpp');
% 
%     Example 5:
%       kermat = compute_kernel_matrix_PhD(X,X,'tanh',1);
% 
%     Example 6:
%       kermat = compute_kernel_matrix_PhD(X,Y,'tanh');
%
%
% GENERAL DESCRIPTION
% The function computes a kernel matrix using the kernel type defined by 
% "kernel_type" and with the input arguments in "kernel_args". The matrices 
% X and Y represent the data matrices, where each column of the two
% matrices has to contain a valid data sample of dimensionality d. Suppose 
% we have in each matrix N images (in vector form), each image having d 
% pixels. Then, the two matrices would have to be of size dxN. The function
% curently supports three kernel types, namely, the polynomial kernel, the
% fractional power polinomial kernel and the sigmoidal kernel. Each kernel
% type requires a specific form for its input arguments. If none are given,
% the defaults are used.
%
% 
% REFERENCES
% If you are interested in the theory of kernel function a good starting
% point for reading would be Scholkops paper on kernel PCA:
% 
% B. Scholkopf, A. Smola, K.-R. Muller, Nonlinear Component Analysis as a
% Kernel Eigenvalue Problem, Technical Report No. 44, December 1996, 
% 18 pages
%
%
%
% INPUTS:
% X                     - a data matrix of size dxN, where d is
%                         dimensionality of the N data samples, e.g., in 
%                         case of images this would correspond to N images 
%                         with d pixels (obligatory argument)
% Y                     - a data matrix of size dxN1, where d is
%                         dimensionality of the N1 data samples, e.g., in 
%                         case of images this would correspond to N1 images 
%                         with d pixels (of course N1 can be 1) (obligatory
%                         argument)
% kernel_type           - a string determining the type of the kernel;
%                         depending on the selected type appropriate kernel
%                         parameters have to used; valid strings for this
%                         argument are:
% 
%                         'poly' - the polynomial kernel, which requires
%                         two input arguments arranged in a 1x2 matrix in
%                         "kernel_args", (e.g., kernel_args = [0 2], which
%                         are also the defaults). If the second argument
%                         equals one, i.e., [0 1], then the polynomial
%                         kernel turns into the linear kernel, resulting in
%                         linear subspaces. The two arguments are used as
%                         follows: 
%                           k(x,y)=(x'*y+kernel_args(1))^(kernel_args(2))
% 
%                         'fpp' - the fractional power polynomial kernel, 
%                         which requires two input arguments arranged in a 
%                         1x2 matrix in "kernel_args", (e.g., kernel_args = 
%                         [0 0.8], which are also the defaults).  The two 
%                         arguments are used as follows: 
%                           k(x,y)=sign(x'*y+kernel_args(1))*abs(x'*y+kernel_args(1))^(kernel_args(2))
% 
%                         'tanh' - the sigmoidal kernel, which requires
%                         one numerical input argument in "kernel_args",
%                         (e.g., kernel_args = [0], which is also the
%                         default). The argument is used as follows: 
%                         
%                               k(x,y)=tanh(x'*y+kernel_args(1))
% kerenl_args           - the parameters of the kernel function; their use
%                         is explained above.
% 
% 
% 
%                         
%
% OUTPUTS:
% kermat                - the computed kernel matrix of size NxN1
%                         
%
% NOTES / COMMENTS
% Note that with a lot of samples in the input data matrices X and Y, the
% kernel matrix can get very large. Unlike linear methods, where the upper
% bound of the size of the covariance or scatter matrices (usually needed for 
% computing the subspace) is given by the dimensionality of the images - in
% this case this would be dxd, the non-linear methods require kernel
% matrices which scale with the number of samples. Yuo should have that in
% mind when using this function
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b).
%
% 
% RELATED FUNCTIONS (SEE ALSO)  
% perform_kpca_PhD 
% perform_kfa_PhD  
% nonlinear_subspace_projection_PhD 
% 
% 
% ABOUT
% Created:        11.2.2010
% Last Update:    21.11.2011
% Revision:       1.0
% 
%
% WHEN PUBLISHING A PAPER AS A RESULT OF RESEARCH CONDUCTED BY USING THIS CODE
% OR ANY PART OF IT, MAKE A REFERENCE TO THE FOLLOWING PUBLICATIONS:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
% Štruc V., Pavešic, N.:Gabor-Based Kernel Partial-Least-Squares 
% Discrimination Features for Face Recognition, Informatica (Vilnius), vol.
% 20, no. 1, pp. 115-138, 2009.
% 
% 
% The BibTex entries for the papers are here
% 
% @Article{ACKNOWL1,
%     author = "Vitomir \v{S}truc and Nikola Pave\v{s}i\'{c}",
%     title  = "The Complete Gabor-Fisher Classifier for Robust Face Recognition",
%     journal = "EURASIP Advances in Signal Processing",
%     volume = "2010",
%     pages = "26",
%     year = "2010",
% }
% 
% @Article{ACKNOWL2,
%     author = "Vitomir \v{S}truc and Nikola Pave\v{s}i\'{c}",
%     title  = "Gabor-Based Kernel Partial-Least-Squares Discrimination Features for Face Recognition",
%     journal = "Informatica (Vilnius)",
%     volume = "20",
%     number = "1",
%     pages = "115–138",
%     year = "2009",
% }
% 
% Official website:
% If you have down-loaded the toolbox from any other location than the
% official website, plese check the following link to make sure that you
% have the most recent version:
% 
% http://luks.fe.uni-lj.si/sl/osebje/vitomir/face_tools/PhDface/index.html
%
% 
% OTHER TOOLBOXES 
% If you are interested in face recognition you are invited to have a look
% at the INface toolbox as well. It contains implementations of several
% state-of-the-art photometric normalization techniques that can further 
% improve the face recognition performance, especcially in difficult 
% illumination conditions. The toolbox is available from:
% 
% http://luks.fe.uni-lj.si/sl/osebje/vitomir/face_tools/INFace/index.html
% 
%
% Copyright (c) 2011 Vitomir Štruc
% Faculty of Electrical Engineering,
% University of Ljubljana, Slovenia
% http://luks.fe.uni-lj.si/en/staff/vitomir/index.html
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files, to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.
% 
% November 2011

function kermat = compute_kernel_matrix_PhD(X,Y,kernel_type,kernel_args);
%% Dummy
kermat = [];

%% Check inputs

%check number of inputs
if nargin <3
    disp('Wrong number of input parameters! The function requires at least three input arguments.')
    return;
elseif nargin >4
    disp('Wrong number of input parameters! The function takes no more than four input arguments.')
    return;
elseif nargin==3
    %check if the kernel type definition is valid
    
    %is it a string
    if ischar(kernel_type)~=1
        disp('The parameter "kernel_type" needs to be a STRING - a valid one!')
        return;
    end
    
    %which one is it
    if strcmp(kernel_type,'poly')==1
        kernel_args = [0 2];
    elseif strcmp(kernel_type,'fpp')==1
        kernel_args = [0 .8];
    elseif strcmp(kernel_type,'tanh')==1
        kernel_args = 0;
    else
        disp('The entered kernel type was not recognized as a supported kernel type.')
        return;
    end
end

%checking the validity of the kernel arguments
[a,b]=size(kernel_args);
if strcmp(kernel_type,'poly')==1
    if a==1 && b==2
        %ok
    elseif a==2 && b==1
        %ok
    else
        disp('The polynomial kernel requires the two arguments arranged into a 1x2 matrix. Switching to default values: kernel_args = [0 2].');
        kernel_args = [0 2];
    end
elseif strcmp(kernel_type,'fpp')==1
    if a==1 && b==2
        %ok
    elseif a==2 && b==1
        %ok
    else
       disp('The fractional power polynomial kernel requires the two arguments arranged into a 1x2 matrix. Switching to default values: kernel_args = [0 0.8].');
       kernel_args = [0 .8];
    end
elseif strcmp(kernel_type,'tanh')==1
    if a==1 && b==1
            %ok
    else
        disp('The sigmoidal kernel requires its argument to be a single numerical value. Switching to default: kernel_args = [0].');
        kernel_args = 0;
    end
else
    disp('The entered kernel name was not recognized as a supported kernel type.')
    return;
end

%% Compute kernel matrices
if strcmp(kernel_type,'poly')==1
    kermat = (X'*Y + kernel_args(1)).^(kernel_args(2));
elseif strcmp(kernel_type,'fpp')==1
    kermat = sign(X'*Y+kernel_args(1)).*((abs(X'*Y+kernel_args(1))).^(kernel_args(2)));
elseif strcmp(kernel_type,'tanh')==1
    kermat = tanh(X'*Y+kernel_args(1));
end
    

















