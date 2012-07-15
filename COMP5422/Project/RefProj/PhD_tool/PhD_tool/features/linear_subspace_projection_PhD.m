% The function computes features for linear subspace methods, such as PCA, LDA, ICA, etc.
% 
% PROTOTYPE
% feat = linear_subspace_projection_PhD(X, model, orthogon);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       %we randomly initialize the model with all of its fields; in
%       %practice this would be done using one of the appropriate functions
%       %from the RELATED_FUNCTIONS section
%       X = double(imread('sample_face.bmp'));
%       model.P = randn(length(X(:)),1);    %random 10 dimensional model
%       model.dim = 10;
%       model.W = randn(length(X(:)),10);
%       feat = linear_subspace_projection_PhD(X(:), model, 0);
% 
%
%
% GENERAL DESCRIPTION
% The function computes the features (or subspace projection coefficients)
% for linear subspace projection techniques (or subspace methods), such as
% PCA, LDA, ICA and others, given a model containing the parameters of the 
% subspace method. Note that this function does not compute the transforms 
% (i.e., the subspaces, transformation matrices, etc.), it only uses a 
% precomputed model to calculate the subspace projection.
% 
% Here, the input data in X has to be arranged into a column data matrix.
% This means that if the test-data matrix X is of size BxA, then there are
% A test samples (images) each having B variables (pixels). While the
% case where the X is transposed is handeled automatically (an input test-data
% matrix of size AxB), it is necessary that the dimensionality of the test 
% data matches that of the training data - the images in vector form need 
% to have the same number of pixels.
% 
% The input data can be a single image (in vector) form, in which case the
% the output "feat" contains the feature vector corresponding to the input 
% test sample X, or it can be a data matrix, in which case the output "feat" 
% is also a matrix, containing in its columns the feature vectors 
% corresponding to the test samples in X. 
%
% To see an example of usage of the function look at the demo folder.
%
% 
% REFERENCES
% The function implements a simple projection of the test data into a
% low-dimensioanl subspace, which is documented in a lot of references, see
% for example:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
%
%
% INPUTS:
% X                     - test-data matrix of size BxA, where each of
%                         the columns contains A samples, each having a
%                         dimensionality of B
% model                 - the subspace model generated using the
%                         appropriate function (see the RELATED FUNCTIONS 
%                         part of this help)
% orthogon              - a parameter defining whether the subspace basis is
%                         orthogonal or not; if you are not sure select the
%                         non-orthogonal option, the result is the same,
%                         however, the computation is slower
%                         orthogon ... 1 - is orthogonal (e.g., PCA ,LDA)
%                                  ... 0 - is not orthogonal (e.g., ICA1, ICA2)
%
% OUTPUTS:
% feat                  - a vector or matrix (depending on the input)
%                         containing the subspace features of the input 
%                         test samples 
%
% NOTES / COMMENTS
% The dimensionality of the feature vectors produced here is defined by the
% dimensionality of the transformation matrix in "model.W". I have not
% included an option so far to reduce the dimensionality of the feature 
% vectors at this point. I will do that in the classification stage. 
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
% 
% 
% RELATED FUNCTIONS (SEE ALSO)
% perform_lda_PhD   
% perform_pca_PhD 
% nonlinear_subspace_projection_PhD
% 
% 
% ABOUT
% Created:        10.2.2010
% Last Update:    24.11.2011
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

function feat = linear_subspace_projection_PhD(X, model, orthogon);

%% Init 
feat=[];

%% Check inputs

%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin >3
    disp('Wrong number of input parameters! The function takes no more than three input arguments.')
    return;
elseif nargin==2
    orthogon = 1;
end

%check model
if isfield(model,'W')~=1
    disp('There is no subspace basis defined. Missing model.W!')
    return;
end

if isfield(model,'P')~=1
    disp('There is no mean face defined. Missing model.P!')
    return;
end

if isfield(model,'dim')~=1
    disp('There is no subspace dimensionality defined. Missing model.dim!')
    return;
end

%% Init operations

%check the size of the test data and report to command prompt
[a,b]=size(X);
[c,d]=size(model.W);

if c==a 
    %this is ok
elseif c==b
    %we need to transpose the test data
    X=X';
    [a,b]=size(X); %check the dimensionality again
else
    disp('The dimensionality of the test data does not match that of the data used for training.')
    return;
end

%% Compute the features (i.e., the subspace projection)
%centering
X = X-repmat(model.P,1,b); %if you have memory problems put this in a for loop

%we now have two options, depending on whether the subspace is determined
%by a orthogonal basis (e.g., PCA or LDA) or a non-orthogonal one (e.g.,
%ICA)

if orthogon == 1 %the subspace is orthogonal
    feat = model.W'*X;
else
    feat = inv(model.W'*model.W)*model.W'*X;
end


