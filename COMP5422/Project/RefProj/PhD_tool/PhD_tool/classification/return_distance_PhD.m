% This is an auxilary function that returns the specified distance
% 
% PROTOTYPE
%   d = return_distance_PhD(x,y,dist,covar)
% 
% USAGE EXAMPLE(S)
%   
%     Example 1:
%       %we generate the feature vectors ourselves
%       x  = randn(1,20);
%       y  = randn(1,20);
%       d = return_distance_PhD(x,y);
% 
%     Example 2:
%       %we generate the feature vectors ourselves
%       x  = randn(1,20);
%       y  = randn(1,20);
%       d = return_distance_PhD(x,y,'euc');
% 
%     Example 3:
%       %we generate the feature vectors ourselves
%       x  = randn(1,20);
%       y  = randn(1,20);
%       invcovar = randn(20,20);
%       d = return_distance_PhD(x,y,'mahcos',invcovar);
% 
% 
% GENERAL DESCRIPTION
% The function computes the specified distance between two feature vectors
% x and y. The function takes either two, three or four arguments as input.
% The first two represent the feature vectors and are obligatory, the third
% specifies the distance to be used, and the fifth stands for the inverse
% of the covariance matrix of the trainig data.
% 
% 
% INPUTS:
% x       - a target feature vector
% y       - a query feture vector
% dist    - a string identitifer determining the type similarity function
%                dist = 'cos'(default) | 'euc' | 'ctb' | 'mahcos'
% covar   - the inverse of the covariance matrix of the trainign samples
%             (required only for mahcos) - I do not perform any parameter
%             checking!!!!!
% 
% OUTPUTS:
% d       - the computed "distance" between x and y
% 
% 
% NOTES / COMMENTS
% In each case a small distance means a similar sample a large distance means
% a dissimilar sample.
% 
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
% 
% 
% RELATED FUNCTIONS (SEE ALSO)
% produce_EPC_PhD  
% produce_CMC_PhD
% produce_ROC_PhD
% 
% 
% ABOUT
% Created:        30.11.2011
% Last Update:    30.11.2011
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
function d = return_distance_PhD(x,y,dist,covar)

%% Init
d=[];

%% Parameter check
if nargin < 2
    disp('The funciton takes at least two input arguments.');
    return;
elseif nargin>4
    disp('The function takes at most 4 input arguments.');
elseif nargin==2
    dist = 'cos';
    [a,b]=size(x);
    tmp = max([a,b]);
    covar = eye(tmp,tmp);
elseif nargin==3
    [a,b]=size(x);
    tmp = max([a,b]);
    covar = eye(tmp,tmp);
end

[a,b]=size(x);
[g,h]=size(y);

if~(a==g && b==h)
   disp('Both feature vectors need to be of the same size.')
   return;
end

cov_siz = max([a,b]);
[g,h] = size(covar);
if~(cov_siz==g && cov_siz==h)
   disp('The covariance matrix is not of the appropriate size considering the size of the feature vector.')
   return;
end

if~(strcmp(dist,'euc') || strcmp(dist,'ctb') || strcmp(dist,'cos') || strcmp(dist,'mahcos'))
    disp('The parameter dist does not have a valid value.')
    return;
end

if b~=1
    x=x';
    y=y';
end

%% Main part

%I assume that x and y are column vectors
if strcmp(dist,'euc')==1
    d = norm(x-y);
elseif strcmp(dist,'ctb')==1
    d = sum(abs(x-y));
elseif strcmp(dist,'cos')==1
    norm_x = norm(x);
    norm_y = norm(y);
    d = - (x'*y)/(norm_x*norm_y);
elseif strcmp(dist,'mahcos')==1
    norm_x = sqrt(x'*covar*x);
    norm_y = sqrt(y'*covar*y);
    d = - (x'*covar*y)/(norm_x*norm_y);
else
    disp('The specified distance is not supported!')
    return;
end