% The function performs the Linear Discriminant Analysis (LDA)
% 
% PROTOTYPE
% model = perform_lda_PhD(X,ids,n)
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       %In this example we generate the training data randomly and also 
%       %generate the class labels manualy; for a detailed example have a 
%       %look at the LDA demo
%       X = randn(300,100); %generate 100 samples with a dimension of 300
%       ids = repmat(1:25,1,4); %generate 25-class id vector
%       model = perform_lda_PhD(X,ids,24); %generate LDA model
%
%
% GENERAL DESCRIPTION
% The function computes the LDA subspace based on the training data X.
% Here, the data has to be arranged into the columns of the input training
% data matrix X. This means that if you have A inputs (input images in 
% vector form) and each of these inputs has B elements (e.g., pixels), then
% the training-data matrix has to be of size BxA. The second input
% parameter "ids" represents a vector of class labels, where the class
% labels take numeric values. For example, if the first three images in X 
% would belong to the first subject and second three images would belong to 
% the second subject, and there would be 6 images in total in the matrix X, 
% then the input parameter would take the following form: ind = [1 1 1 2 2
% 2]. In any case, the length of the parameter "ids" has to fit the nummber
% of samples in X. The third input parameter n determines the number of the 
% retained LDA components. Note that n mustn't exceed the number of classes 
% minus one, which equals the rank of the between class scatter matrix. 
% 
% It should be noted that this function is not an implementation of the
% linear discriminant analysis (LDA) algorithm, as it does not operate on 
% the actual data. This function is an implementation of the Fisherface 
% algorithm which applies LDA in the PCA subspace to aviod singularity 
% issues. It is intended and was also only tested for cases where the 
% number of samples is smaller than the dimensionality of the samples. If 
% you require a function working properly in other situations please use a 
% different toolbox. 
% 
% The function does not perform any normalization of the input data, it just
% computes the LDA (or better said the Fisherface) subspace. If you would like 
% to perform data normalization (e.g., remove illumination variations) have 
% a look at the INFace toolbox.
%
% 
% REFERENCES
% The function is an implementation of the Fisherface technique presented
% in:
% 
% P.N. Belhumeur, J.P. Hespanha, D.J. Kriegman, Eigenfaces vs. Fisherfaces:
% Recognition using Class Specific Linear Projection, Proc. of the 4th 
% European Conference on Computer Vision, ECCV'96, 15-18 April 1996, 
% Cambridge, UK, pp. 45-58
%
%
%
% INPUTS:
% X                     - training-data matrix of size BxA, where each of
%                         the A columns contains one sample - each sample 
%                         having a dimensionality of B (obligatory argument)
% ids                   - a vector of size 1xA, where each numeric value in
%                         "ids" encodes the class-label of the corresponding
%                         sample in X (obligatory argument)
% n                     - a parameter determining the number of LDA 
%                         basis vectors to retain in the LDA model; if the 
%                         parameter is omitted when calling the function, a 
%                         default value of n = number_of_classes-1 is used.
%                         (optional argument)
%
% OUTPUTS:
% model                 - a structure containing the LDA subspace parameters 
%                         needed to project a given test sample into the 
%                         LDA subspace, the model has the following 
%                         structure:
% 
%                         model.P     . . . the mean face in vector form
%                         model.dim   . . . the dimensionality of the
%                                           LDA subspace
%                         model.W     . . . the tranformation matrix (the eigenfaces)
%                         model.train . . . LDA fetures corresponding to
%                                           the training data 
%                         
%
% NOTES / COMMENTS
% The function is implemented to produce the LDA subspace using as few for 
% loops as possible. Therefore, the function may not succeed if you have a realy,
% realy big input training-data matrix (a lot of samples and high-dimensional 
% images). You can (partialy) overcome this by reducing the size of the
% training images or adding for loops when computing the scatter matrices - 
% this is indicated in the code for the Fib case.
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
% 
% 
% RELATED FUNCTIONS (SEE ALSO)
% perform_pca_PhD  
% perform_kpca_PhD 
% perform_kfa_PhD  
% linear_subspace_projection_PhD 
% 
% 
% ABOUT
% Created:        11.2.2010
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

function model = perform_lda_PhD(X, ids, n);
%% Dummy 
model=[];

%% Check inputs

%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin >3
    disp('Wrong number of input parameters! The function takes no more than three input arguments.')
    return;
elseif nargin==2
    [a,b]=size(unique(ids));
    n = max([a,b])-1;
end

%check if ids is a vector
if isvector(ids)==0
    disp('The second parameter "ids" needs to be a vector.')
    return;
end

% check if n is not to big
[a,b]=size(unique(ids));
if n>max([a,b])-1;
    disp('The parameter "n" must not be larger than the number of classes minus one. Decreasing "n"!')
    n = max([a,b])-1;
end

%check that each image in X has a class label
[a,b]=size(X);
if b~=length(ids)
    disp('The label vector "ids" needs to be the same size as the number of samples in X.')
    return;
end

%we assume that the data is contained in the columns
disp(sprintf('The training data comprises %i samples (images) with %i variables (pixels).', b, a))
disp('If this should be the other way around, please transpose the training-data matrix.')


%% First we compute the PCA subspace 

%first model output
model.P = mean(X,2); %this is the mean face 
model.dim = n;

%center data
Fi = X-repmat(model.P,1,b); %if you have memory problems put this in a for loop

%compute PCA transform using the Eigenface trick
[U,V,L] = svd(Fi'*Fi);
clear V L %save some memory
PCA = normc(Fi*U(:,1:b-1)); %here are the eigenfaces - display a column in image form to visualize them  
clear U

%sphere the PCA vectors (so that Sww is whitened after projection)
tmp = sqrt(diag(PCA'*Fi*Fi'*PCA)); %find whitening tranform
PCA = PCA./repmat(tmp',a,1);


%% We compute the LDA transform in the PCA subspace - Fisherfaces

%compute class conditional means
id_unique = unique(ids);
[c,d]=size(id_unique);
num_of_class = max([c,d]); %this is the number of classes

%compute class-conditional means
meanclass = zeros(a,num_of_class);
class_id = zeros(1,num_of_class);
for i=1:num_of_class
    [dummy,ind]=find(id_unique(i)==ids);
    meanclass(:,i) =  mean(X(:,ind),2);  
end

%compute Fiw
Fiw = zeros(a,b);
cont = 1;
for i=1:num_of_class
    [dummy,ind]=find(id_unique(i)==ids);
    num_of_sampl = length(ind);
    for j=1:num_of_sampl
        Fiw(:,cont) = X(:,ind(j))-meanclass(:,i);
        cont=cont+1;
    end
end

%compute Fib
Fib = meanclass-repmat(model.P,1,num_of_class);

%this would be in a loop for larger problems
% Fib =zeros(a,num_of_class);
% for i=1:num_of_class
%     Fib(:,i) = meanclass(:,i) - model.P;    
% end

%compute dimensionality reduction needed for inversion
max_dim = b - num_of_class;
%if you have duplicated images or the images in your trainnig data is 
% highly correlated this might not be true; in this case I would suggest to
% check the actual rank, i.e., max_dim = rank(Fiw);



%compute scatter matrices and projection into PCA subspace
Sbb = PCA(:,1:max_dim)'*Fib*Fib'*PCA(:,1:max_dim);
Sww = PCA(:,1:max_dim)'*Fiw*Fiw'*PCA(:,1:max_dim);
clear Fib Fiw %save some memory


% %solve the eigenproblem - option 1 (fixed)
% [U1,D1,QP] = svd(inv(Sww)*Sbb);
% clear D1 QP

%solve the eigenproblem via whitening - option 2 (could be extended to EFM I or II)
[U1,D1,QP] = svd(Sww); %eigneproblem
U1_scaled = normc(U1);    %normalized to unit norm
clear U1_norm U1 D1 QP
%we could check now that U1_scaled produces a whitened matrix:  tmp = U1_scaled'*Sww*U1_scaled;

%change space
Sbbb = U1_scaled'*Sbb*U1_scaled;
[U1,D1,QP] = svd(Sbbb); %eigenproblem


%backtrack to produce Fisherfaces
fisher = PCA(:,1:max_dim)*U1_scaled*U1(:,1:num_of_class-1);
clear PCA U1 U1_scaled

%exclude all that correspond to non-zero eignevalues
model.W = normc(fisher(:,1:num_of_class-1));
model.train = model.W'*Fi;















