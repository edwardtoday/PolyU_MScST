% The function performs the Principal Component Analysis (PCA)
% 
% PROTOTYPE
% model = perform_pca_PhD(X,n)
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       %In this example we generate the training data randomly and set the
%       %number of retained components using the actual rank; for a detailed
%       %example have a look at the PCA demo
%       X=randn(300,100); %generate 100 samples with a dimension of 300
%       model = perform_pca_PhD(X,rank(X)-1); %generate PCA model
% 
%     Example 2:
%       %In this example we generate the training data randomly and set the
%       %number of retained components to 20; for a detailed
%       %example have a look at the PCA demo
%       X=randn(300,100); %generate 100 samples with a dimension of 300
%       model = perform_pca_PhD(X,20); %generate PCA model
%
%
% GENERAL DESCRIPTION
% The function computes the PCA subspace based on the training data X.
% Here, the data has to be arranged into the columns of the input training
% data matrix X. This means that if you have A inputs (input images in 
% vector form) and each of these inputs has B elements (e.g., pixels), then
% the training-data matrix has to be of size BxA. The second input
% parameter n determines the number of the retained PCA components. Note 
% that n mustn't exceed the rank of the training data matrix X. As it
% stands now, the function is implemented to check only for the theoretical
% rank of the matrix, i.e., n = min([A,B])-1, and not the actual rank of
% the matrix. This is done for reasons of speed, as I am working with rather
% high-dimensional data (128x128 pixel images - a lot of them). If you have
% multiple copies of the same data-sample (i.e., image) in your training
% data or you suspect that the input data is highly correlated be sure to 
% set n properly. Otherwise, you will end up with a subspace, where a few 
% of the basis vectors correspond to zero-valued eigenvalues.
% 
% The function does not perform any normalization of input data, it just
% computes the PCA subspace. If you would like to perform data
% normalization (e.g., remove illumination variations) have a look at the
% INFace toolbox.
%
% 
% REFERENCES
% The function is an implementation of the Eigenface technique presented
% in:
% 
% M. Turk, A. Pentland, Eigenfaces for Recognition, Journal of Cognitive
% Neurosicence, Vol. 3, No. 1, 1991, pp. 71-86.
%
%
%
% INPUTS:
% X                     - training-data matrix of size BxA, where each of
%                         the A columns contains one sample - each sample 
%                         having a dimensionality of B (obligatory
%                         argument)
% n                     - a parameter determining the number of PCA 
%                         eigenvectors to retain in the PCA model; if the 
%                         parameter is omitted when calling the function, a 
%                         default value of n = min([A,B])-1 is used.
%
% OUTPUTS:
% model                 - a structure containing the PCA subspace parameters 
%                         needed to project a given test sample into the 
%                         PCA subspace, the model has the following 
%                         structure:
% 
%                         model.P     . . . the mean face in vector form
%                         model.dim   . . . the dimensionality of the
%                                           PCA subspace
%                         model.W     . . . the tranformation matrix (the eigenfaces)
%                         model.train . . . PCA fetures corresponding to
%                                           the training data 
%                         
%
% NOTES / COMMENTS
% The function is implemented to produce the PCA subspace without using any
% for loops. Therefore, the function may not succeed if you have a realy,
% realy big input training-data matrix (a lot of samples and high-dimensional 
% images). You can (partialy) overcome this by reducing the size of the
% training images or adding a for loop in the centering step and the
% covariance matrix computation. If you have enough memory it should work
% fine. The function was tested on PC with a 3.2 GHz Intel Duo core 
% processor and 3GB of RAM. For a training data matrix with more than 2000
% images and an image size of 128x128 pixels there were no problems.
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% RELATED FUNCTIONS (SEE ALSO)
% perform_lda_PhD   
% perform_kpca_PhD 
% perform_kfa_PhD
% linear_subspace_projection_PhD
% 
% 
% ABOUT
% Created:        10.2.2010
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

function model = perform_pca_PhD(X, n);

%% Init
model = [];

%% Check inputs

%check number of inputs
if nargin <1
    disp('Wrong number of input parameters! The function requires at least one input argument.')
    return;
elseif nargin >2
    disp('Wrong number of input parameters! The function takes no more than two input arguments.')
    return;
elseif nargin==1
    [a,b]=size(X);
    n = min([a,b])-1;
    %n = rank(X)-1; %this would be the right (computationally expensive) way to go
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


%% Compute the PCA subspace - main part

%we center the data around the median (for robustness) - normaly this would
%be the mean (with enough data and a valid gaussian assumption on the
%variables this is identical)

%first model output
% model.P = median(X,2); %this is the mean face
model.P = mean(X,2); %this is the mean face
model.dim = n;

%center data
X = X-repmat(model.P,1,b); %if you have memory problems put this in a for loop

%compute PCA transform using the Eigenface trick
if b < a
    [U,V,L] = svd(X'*X);
    clear L %save some memory
    model.W = normc(X*U(:,1:n)); %here are the eigenfaces - display a column in image form to visualize them  
    clear U
else
    [U,V,L] = svd(X*X');
    clear L %save some memory
    model.W = normc(U(:,1:n)); %here are the eigenfaces - display a column in image form to visualize them 
    clear U
end

%% Produce traninig features for possible Mahalanobis matching

%compute features
model.train = model.W'*X;
model.eigenVal = diag(V);














