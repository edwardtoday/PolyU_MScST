% The function performs the (non-linear) Kernel Principal Component Analysis (KPCA)
% 
% PROTOTYPE
% model = perform_kpca_PhD(X, kernel_type, kernel_args,n);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       %In this example we generate the training data randomly; for a 
%       %detailed example have a look at the KPCA demo
%       X=randn(300,100); %generate 100 samples with a dimension of 300
%       model = perform_kpca_PhD(X, 'poly', [0 2], 90); %generate KPCA model
%
%
% GENERAL DESCRIPTION
% The function computes the KPCA subspace based on the training data X.
% Here, the data has to be arranged into the columns of the input training
% data matrix X. This means that if you have A inputs (input images in 
% vector form) and each of these inputs has B elements (e.g., pixels), then
% the training-data matrix has to be of size BxA. The second input
% parameter "kernel_type" determines the kenel matrix type. For details on
% the supproted types please type: "help compute_kernel_matrix_PhD". The
% third argument defines the parameters of the kernel function and n
% specifies the dimensionality of the kernel subspace (the number of KPCA 
% components). Note that different from PCA, KPCA scales with the number of
% samples and not the dimensionality of the samples. This means that your
% needs for memory will grow with the number of samples used for training.
% 
% The function does not perform any normalization of input data, it just
% computes the KPCA subspace. If you would like to perform data
% normalization (e.g., remove illumination variations) have a look at the
% INFace toolbox.
%
% 
% REFERENCES
% The function is an implementation of the KPCA technique described in:
% 
% Scholkopf, A. Smola, K.-R. Muller, Nonlinear Component Analysis as a
% Kernel Eigenvalue Problem, Technical Report No. 44, December 1996, 
% 18 pages
%
%
%
% INPUTS:
% X                     - training-data matrix of size BxA, where each of
%                         the A columns contains one sample - each sample 
%                         having a dimensionality of B (obligatory
%                         argument)
% kernel_type           - a string determining the type of the kernel;
%                         depending on the selected type appropriate kernel
%                         parameters have to used; valid strings for this
%                         argument are (obligatory argument):
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
%                         is explained above (obligatory argument)
% n                     - the dimensionality of the KPCA subspace (optional 
%                         argument); if the parameter is not given, a default 
%                         value is computed from the size of X
%
% OUTPUTS:
% model                 - a structure containing the KPCA subspace parameters 
%                         needed to project a given test sample into the 
%                         KPCA subspace, the model has the following 
%                         structure:
% 
%                         model.K     . . . the training kernel matrix
%                         model.dim   . . . the dimensionality of the
%                                           KPCA subspace
%                         model.W     . . . the tranformation matrix (the eigenvectors)
%                         model.J     . . . the auxilary matrix needed for
%                                           centering the trainign data
%                         model.eigs  . . . the eigenvalues that can be
%                                           used for matching
%                         model.train . . . KPCA fetures corresponding to
%                                           the training data 
%                         model.typ   . . . the string identifier of the
%                                           kernel type
%                         model.args  . . . the parameters of the kernel
%                                           function
%                         model.X     . . . the training data
%                         
%                         
%
% NOTES / COMMENTS
% The function is implemented to produce the KPCA subspace. For an example
% of usage please have a look at the demo folder.
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% RELATED FUNCTIONS (SEE ALSO)
% perform_lda_PhD
% perform_pca_PhD
% perform_kfa_PhD  
% linear_subspace_projection_PhD 
% nonlinear_subspace_projection_PhD 
% 
% 
% 
% ABOUT
% Created:        15.2.2010
% Last Update:    29.11.2011
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

function model = perform_kpca_PhD(X, kernel_type, kernel_args,n);

%% Init
model = [];

%% Check inputs
%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin >4
    disp('Wrong number of input parameters! The function takes no more than four input arguments.')
    return;
elseif nargin==2
    [a,b]=size(X);
    n = min([a,b])-1;
    %n = rank(X)-1; %this would be the right way to go
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
elseif nargin==3
    [a,b]=size(X);
    n = min([a,b])-1;
    %n = rank(X)-1; %this would be the right way to go
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

%% Init operations

%check the size of the training data and report to command prompt
[a,b]=size(X);

if n > (min([a,b])-1) %(rank(X)-1) %this would be the right way to go
    disp(sprintf('The number of retained PCA components can not exceed %i.', (min([a,b])-1)))
    return;
end

%we assume that the data is contained in the columns
disp(sprintf('The training data comprises %i samples (images) with %i variables (pixels).', b, a))
disp('If this should be the other way around, please transpose the training-data matrix.')


%% Compute the KPCA subspace - main part

%compute the training data kernel matrix
K = compute_kernel_matrix_PhD(X,X,kernel_type,kernel_args);

%center kernel
J = ones(b,b)/b;
Kc = K - J*K - K*J + J*K*J;

%solve eigenvalue problem
% [E,V] = eig(Kc);
[E,V,K] = svd(Kc);
V=real(diag(V));

% orthonormalization in F
cont=1;
for k = 1:b,
  if V(k) > 0.000000001 & V(k)>0,
     E(:,k)=E(:,k)/sqrt(V(k));
     cont=cont+1;
  end
end
cont=cont-1;

% Sort eigenvectors
[V,sorted]=sort(-V);
V=-V;
E1=E(:,sorted(1:cont));

%check if E1 has enough elements otherwise adjust n
[a,b] = size(E1);
if b<n
    n=b;
end

Kpca = E1(:,1:n);


%construct some outputs
model.W = Kpca;
model.J = J;
model.dim = n;
model.eigs = V;
model.K = K;
model.typ = kernel_type;
model.args = kernel_args;
model.X = X;

%% Construct training features
model.train = Kpca'*Kc;




























