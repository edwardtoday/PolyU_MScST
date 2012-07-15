% Performs matching score calculation based on the nearest neighbor classifier
% 
% PROTOTYPE
% results = nn_classification_PhD(train, train_ids, test, test_ids, n, dist, match_kind);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       % we randomly generate a few 100-dimensional training and testing  
%       % feature vectors belonging to 20 classes; 
%       % this shows the use of the 'all' match_kind option; each feature 
%       % vector ID is in the training as well as the testing set
%         n=100;
%         train_feature_vectors=[];
%         test_feature_vectors=[];
%         test_ids = [];
%         train_ids = [];
%         for i=1:20
%             for j=1:10
%                 train_feature_vectors=[train_feature_vectors,i+1.5*randn(n,1)];
%                 train_ids = [train_ids,i];
%                 test_feature_vectors=[test_feature_vectors,i+1.5*randn(n,1)];
%                 test_ids = [test_ids,i];
%             end
%         end    
%         results = nn_classification_PhD(train_feature_vectors, train_ids, test_feature_vectors, test_ids, n, 'euc','all');
% 
%     Example 2:
%       % we randomly generate a few 100-dimensional training and testing  
%       % feature vectors belonging to 20 classes; 
%       % this shows the use of the 'sep' match_kind option; there are a 
%       % few feature vector IDs that are in our testing set but not in the
%       % training set
%         n=100;
%         train_feature_vectors=[];
%         test_feature_vectors=[];
%         test_ids = [];
%         train_ids = [];
%         for i=1:20
%             for j=1:10
%                 if(i<10)
%                   train_feature_vectors=[train_feature_vectors,i+1.5*randn(n,1)];
%                   train_ids = [train_ids,i];
%                 end
%                 test_feature_vectors=[test_feature_vectors,i+1.5*randn(n,1)];
%                 test_ids = [test_ids,i];
%             end
%         end
%         results = nn_classification_PhD(train_feature_vectors, train_ids, test_feature_vectors, test_ids, n, 'euc','sep');
%       
%
%
% GENERAL DESCRIPTION
% The function performs matching score calculation based on the input data 
% and returns a structure that among other fields also contains a 
% similarity matrix that can be used to compute ROC curves, CMC curves and 
% other statistics such as equal erro rates, rank one recognition rates and 
% others. The function takes either four, five, six or seven input 
% arguments. For a detailed description of the input arguments have a look 
% at the section below.
% 
% The function is capable of producing complete similarity matrices, where
% each of the feature vectors from the training/target/gallery feature 
% vector matrix is matched again each of the feature vector in the
% test/query/evaluation feature vector matrix, or two separate similarity
% matrices with only client/genuine and only impsotor matching scores. 
% 
% Note that this function is intended to be used for baseline comparisons,
% you can implement the matching and classification steps yourselves and
% use the remaining tools from this toolbox to evaluate your results.
%
% To see an example of usage of the function look at the examples above or 
% find an appropriate demo in the demo folder.
%
% 
% REFERENCES
% Nearest neigbor matching is fairly common. Some info on the topic can be 
% found in:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
%
%
% INPUTS:
% train                 - training/target/gallery feature-vector matrix of 
%                         size BxA, where each of the A columns represents 
%                         a feature vector (or sample) each having a 
%                         dimensionality of B (i.e., each feature vector 
%                         contains B features) - obligatory argument
% train_ids             - a vector of size 1xA (or Ax1), where each numeric 
%                         value in "train_ids" encodes the class memebership 
%                         of the corresponding sample in "train" - 
%                         obligatory argument  
% test                 -  test/query/evaluation feature-vector matrix of 
%                         size CxD, where each of the D columns represents 
%                         a feature vector (or sample) each having a 
%                         dimensionality of C (i.e., each feature vector 
%                         contains C features) - obligatory argument
% test_ids              - a vector of size 1xC (or Cx1), where each numeric 
%                         value in "test_ids" encodes the class memebership 
%                         of the corresponding sample in "test" - 
%                         obligatory argument
% n                     - a scalar value specifying the number of features
%                         to be used in the matching process; if this
%                         argument is omitted a default value of
%                         "size(train,1)" is used (optional argument)
% dist                  - a string identitifer determining the type 
%                         distance measure to use:                       
%                           dist = 'cos'(default) | 'euc' | 'ctb' | 'mahcos'
% match_kind            - a string identifier determining the
%                         classification logic to use; valid options are: 
%                           match_kind = 'all' (default) | 'sep'
%                         Here, the 'all' option causes that comparisons
%                         between all feature vectors from the 
%                         training/gallery/target and test/query/evaluation
%                         matrices are conducted and that the 
%                         corresponding matching scores are generated. Thus
%                         the final similarity matrix looks something like
%                         this:
% 
%                               [q1][q2][q3] ... [qC]
%                           [g1]  x   x   x  ...   x   
%                           [g2]  x   x   x  ...   x
%                           [g3]  x   x   x  ...   x
%                            ... ... ... ... ...  ...
%                           [gA]  x   x   x  ...   x
% 
%                         In the case, where the 'sep' option is used, two
%                         similarity matrices are computed, which actually
%                         represent two sub-matrices pulled from the 
%                         similarity matrix generated with the 'all' option.
%                         The first similarity matrix is the client 
%                         similarity matrix, which is computed only for
%                         the images of those subjects that are both in the
%                         training/gallery/target and test/query/evaluation
%                         feature vector matrices. The second similarity is
%                         the impostor similarity matrix, which is computed
%                         only for the images of those subjects from the
%                         test feature vector matrix that are not also in the
%                         training/gallery/target feature vector matrix.
%                           
%                         For a detailed description of the role of this 
%                         argument and its impact on the result of this 
%                         function please look at the toolbox manual. 
%                         
% 
% 
% OUTPUTS:
% results               - an output structure, whose fields depend on the 
%                         value of the input argument "match_kind"; 
%                         if match_kind = 'all', then the results structure
%                         has the following fields:
% 
%   results.mode           . . . the value of the match_kind input argument:
%                                 'all' | 'sep'
%   results.match_dist     . . . the actual similarity matrix containing
%                                 at every location the distance (or 
%                                 dissimilarity) between the row and column 
%                                 feature vectors; here, each row and each 
%                                 column feature vector corresponds to an 
%                                 ID that is specified in train_ids and test_ids                                 
%   results.same_cli_id    . . . a binary matrix of the same size as the
%                                 actual similarity matrix containing ones at
%                                 matrix locations with identitcal row and
%                                 column IDs and zeros elsewhere
%   results.horizontal_ids . . . the IDs correponsing to the column
%                                 feature vectors; these IDs represent the 
%                                 IDs provided in test_ids 
%   results.vertical_ids   . . . the IDs correponsing to the row
%                                 feature vectors; these IDs represent the 
%                                 IDs provided in train_ids 
%   results.dist           . . . the distance used to compute the
%                                 similarity matrix: 
%                                    'cos'| 'euc' | 'ctb' | 'mahcos'
%   results.dim            . . . the feature vector dimensionality used to
%                                 compute the similarity matrix
% 
%                           if match_kind = 'sep' then the results structure
%                           contains the following fields:
% 
%   results.mode           . . . the value of the match_kind input argument:
%                                 'all' | 'sep'
%   results.client_dist    . . . the client similarity matrix containing
%                                 at every location the distance (or 
%                                 dissimilarity) between the row and column 
%                                 feature vectors; here, only those test 
%                                 feature vectors from test_ids are considered 
%                                 that correspond to IDs also present in 
%                                 the target set (i.e., train)                                  
%   results.same_cli_id    . . . a binary matrix of the same size as the
%                                 client similarity matrix containing ones at
%                                 matrix locations with identitcal row and
%                                 column IDs and zeros elsewhere
%   results.client_horizontal_ids . . . the IDs correponsing to the column
%                                 feature vectors; these IDs represent the 
%                                 IDs provided in part of test_ids 
%   results.client_vertical_ids   . . . the IDs correponsing to the row
%                                 feature vectors; these IDs represent the 
%                                 IDs provided in train_ids 
%   results.imp_dist        . . . the impostor similarity matrix containing
%                                 at every location the distance (or 
%                                 dissimilarity) between the row and column 
%                                 feature vectors; here, only those test 
%                                 feature vectors from test_ids are considered 
%                                 that correspond to IDs not also present 
%                                 in the target set (i.e., train)   
%   results.same_imp_id     . . . a binary matrix of the same size as the
%                                 impostor similarity matrix containing 
%                                 ones at matrix locations with identitcal 
%                                 row and column IDs and zeros elsewhere 
%                                 (since in 'sep' mode there is no overlap 
%                                 between the target and query IDs, this 
%                                 matrix sould contain only zeros)
%   results.imp_horizontal_ids  . . . the IDs correponsing to the column
%                                 feature vectors; these IDs represent the 
%                                 IDs provided in part of test_ids
%   results.imp_vertical_ids    . . . the IDs correponsing to the row
%                                 feature vectors; these IDs represent the 
%                                 IDs provided in train_ids 
%   results.dist:           . . . the distance used to compute the
%                                 similarity matrix: 
%                                    'cos'| 'euc' | 'ctb' | 'mahcos'
%   results.dim:            . . . the feature vector dimensionality used to
%                                 compute the similarity matrix
%  
%
% NOTES / COMMENTS
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
% 
% 
% RELATED FUNCTIONS (SEE ALSO)
% evaluate_results_PhD
% return_distance_PhD
% 
% 
% ABOUT
% Created:        10.2.2010
% Last Update:    20.12.2011
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
% December 2011

function results = nn_classification_PhD(train, train_ids, test, test_ids, n, dist, match_kind);


%% Init 
results = [];


%% Check inputs

%check number of inputs
if nargin <4
    disp('Wrong number of input parameters! The function requires at least four input arguments.')
    return;
elseif nargin >7
    disp('Wrong number of input parameters! The function takes no more than seven input arguments.')
    return;
elseif nargin==4
    n = size(train,1);
    dist = 'cos';
    match_kind = 'all'
elseif nargin ==5
    dist = 'cos';
    match_kind = 'all';
elseif nargin ==6
    match_kind = 'all';    
end

%check distance
if ischar(dist)~=1
    disp('The parameter "dist" needs to be a string - a valid one!')
    return;
end

%check if test and train features are of same size
[a,b]=size(train);
[c,d]=size(test);
if a~=c
    disp('The number of features in the training and test vectors needs to be identical.')
    return;
end

%check the matching type 
if ischar(match_kind)~=1
    disp('The parameter "match_kind" has to be a string - a valid one!')
    return;
end

%check if match_kind is a valid string
if strcmp(match_kind,'all')==1 || strcmp(match_kind,'sep')==1 || strcmp(match_kind,'allID')==1
    %ok
else
    disp('The input string "match_kind" is not a valid identifier: all|sep.')
    return;
end

%check if n is not to big
if n>a
    disp('The parameter "n" cannot be larger than the dimensionality of your feature vectors. Decreasing "n" to maximal allowed size.')
    n=a;
end

%check if the distance is valid
if strcmp(dist,'cos')==1 || strcmp(dist,'euc')==1 || strcmp(dist,'ctb')==1 || strcmp(dist,'mahcos')==1
    %ok
else
    disp('The parameter "dist" need to be a valid string identifier: cos, euc, ctb, or mah. Switching to deafults (cos).')
    dist = 'cos';
end

%check if ids (class labels) are vectors
if isvector(train_ids)==0 
    disp('The second parameter "train_ids" needs to be a vector of numeric values.')
    return;
end

if isvector(test_ids)==0
    disp('The second parameter "train_ids" needs to be a vector of numeric values.')
    return;
end

%check that each feature vector has a label
[a,b]=size(train);
if b~=length(train_ids)
    disp('The label vector "train_ids" needs to be the same size as the number of samples in "train".')
    return;
end

[c,d]=size(test);
if d~=length(test_ids)
    disp('The label vector "test_ids" needs to be the same size as the number of samples in "test".')
    return;
end

%% Prepare data and do the matching - main part

%get sample sizes
[a,b]=size(train);
[c,d]=size(test);

%precompute the inverse of the covariance if needed
covar = inv(cov(train(1:n,:)'));

%select type of matching
if strcmp(match_kind,'sep')==1
    %the "sep" option separates the test data into two groups - clients and 
    %impostors (needed by some protocols) - this is useful for verification
    %with an unseen impostor set (e.g., XM2VTS), the identification score
    %can still be computed from the client similarity matrix
    
    %write matching mode to result structure
    results.mode = 'sep';
    
    %find impostor labels
    impostor_ids = setdiff(test_ids,train_ids);
    if size(impostor_ids,1)==0 || size(impostor_ids,2)==0
        disp('In separation mode, the query data matrix has to feature at least some subjects that are not in the target set.')
        return;
    end
    
    %find client labels
    client_ids = intersect(test_ids,train_ids);
    if size(client_ids,1)==0 || size(client_ids,2)==0
        disp('In separation mode, the query data matrix has to feature at least some subjects that are also in the target set.')
        return;
    end
    
    
    %some reporting
    disp('Entering separation mode!')
    
    
    %seperate and compute the distances 
    
    %clients - extract client data
    num_of_experiments = 0;
    for i=1:length(client_ids)
        [incr,dummy] = find(client_ids(i)==test_ids); 
        num_of_experiments = num_of_experiments + sum(incr);
    end
    
    %we rather add another for loop now that we know the size - this is
    %faster than realocating space in each iteration - štrikam
    test_cli = zeros(n,num_of_experiments);
    test_cli_ids = zeros(1,num_of_experiments);
    cont=1;
    for i=1:length(client_ids)
        [incr,dummy] = find(client_ids(i)==test_ids); 
        test_cli(:,cont:cont+length(incr)-1) = test(1:n,dummy);
        test_cli_ids(1,cont:cont+length(incr)-1) = client_ids(i);
        cont = cont+length(incr);
    end
    
    
    %some reporting
    disp('Computing client similarity matrix ...')
    
    
    %compute distances
    results.client_dist = zeros(num_of_experiments,b);
    results.same_cli_id = zeros(num_of_experiments,b);
    for i=1:num_of_experiments
        for j=1:b
            results.client_dist(i,j) = return_PhD_distance(train(1:n,j),test_cli(1:n,i),dist,covar);
            if train_ids(j)==test_cli_ids(i)
                results.same_cli_id(i,j)=1;
            else
                results.same_cli_id(i,j)=0;
            end
        end
    end
    results.client_horizontal_ids = train_ids;
    results.client_vertical_ids = test_cli_ids;
    
    disp('Done.')
    
    
    disp('Computing impostor scores ...')
    %impostors - extract impostor data
    num_of_experiments = 0;
    for i=1:length(impostor_ids)
        [incr,dummy] = find(impostor_ids(i)==test_ids); 
        num_of_experiments = num_of_experiments + sum(incr);
    end
    
    
    %we rather add another for loop now that we know the size - this is
    %faster than realocating space in each iteration - štrikam
    test_imp = zeros(n,num_of_experiments);
    test_imp_ids = zeros(1,num_of_experiments);
    cont=1;
    for i=1:length(impostor_ids)
        [incr,dummy] = find(impostor_ids(i)==test_ids); 
        test_imp(:,cont:cont+length(incr)-1) = test(1:n,dummy);
        test_imp_ids(1,cont:cont+length(incr)-1) = impostor_ids(i);
        cont = cont+length(incr);
    end
    
    %compute distances
    results.imp_dist = zeros(num_of_experiments,b);
    results.same_imp_id = zeros(num_of_experiments,b);
    for i=1:num_of_experiments
        for j=1:b
            results.imp_dist(i,j) = return_PhD_distance(train(1:n,j),test_imp(1:n,i),dist,covar);
            if train_ids(j)==test_imp_ids(i)
                results.same_imp_id(i,j)=1;
            else
                results.same_imp_id(i,j)=0;
            end
        end
    end
    results.imp_horizontal_ids = train_ids;
    results.imp_vertical_ids = test_imp_ids;
    results.dist = dist;
    results.dim = n; 
    disp('Done.')
elseif strcmp(match_kind,'all')==1
    %the "all" option matches each samples from the test matrix against all
    %samples form the train matrix
    
    %write matching mode to result structure
    results.mode = 'all';
    
    %find client labels
    client_ids = intersect(test_ids,train_ids);
    if size(client_ids,1)==0 || size(client_ids,2)==0
        disp('In all mode, the query data matrix has to feature at least some subjects that are also in the target set.')
        return;
    end
    
    
    %some reporting
    disp('Entering all mode!')
    disp('Computing similarity matrix ...')
    
    %compute distances
    results.match_dist = zeros(d,b);
    %results.same_id = zeros(d,b);
    for i=1:d
        for j=1:b
            results.match_dist(i,j) = return_PhD_distance(train(1:n,j),test(1:n,i),dist,covar);
            if train_ids(j)==test_ids(i)
                results.same_cli_id(i,j)=1;
            else
                results.same_cli_id(i,j)=0;
            end
        end
    end
    results.horizontal_ids = train_ids;
    results.vertical_ids = test_ids;
    results.dist = dist;
    results.dim = n; 
    disp('Done.')
elseif strcmp(match_kind,'allID')==1
    %the "allID" option matches each samples from the test matrix against all
    %IDs form the train matrix - each ID here is represented with the mean
    %feature vector of that ID - this is just for me and I will not
    %document it
    
    %write matching mode to result structure
    results.mode = 'all';
    
    %find client labels
    client_ids = intersect(test_ids,train_ids);
    if size(client_ids,1)==0 || size(client_ids,2)==0
        disp('In all mode, the query data matrix has to feature at least some subjects that are also in the target set.')
        return;
    end
    
    
    
    
%     [incr,dummy] = find(impostor_ids(i)==test_ids); 
%         test_imp(:,cont:cont+length(incr)-1) = test(1:n,dummy);
%         test_imp_ids(1,cont:cont+length(incr)-1) = impostor_ids(i);
%         cont = cont+length(incr);
        
        
        
        
    %some reporting
    disp('Entering allID mode!')
    
    disp('Computing client prototypes ...')
%     prototypes = zeros(size(train_ids,1),length(client_ids));
    cont=1;
    for i=1:length(client_ids);
       [incr,dummy] = find(client_ids(i) == train_ids);
       train(1:n,cont:cont+length(incr)-1) = repmat(mean(train(1:n,dummy),2),1,length(incr));        
    end
    
    
    disp('Computing similarity matrix ...')
    
    %compute distances
    results.match_dist = zeros(d,b);
    results.same_id = zeros(d,b);
    for i=1:d
        for j=1:b
            results.match_dist(i,j) = return_PhD_distance(train(1:n,j),test(1:n,i),dist,covar);
            if train_ids(j)==test_ids(i)
                results.same_cli_id(i,j)=1;
            else
                results.same_cli_id(i,j)=0;
            end
        end
    end
    results.horizontal_ids = train_ids;
    results.vertical_ids = test_ids;
    results.dist = dist;
    results.dim = n; 
    disp('Done.')  
end



















%% This is an auxilary function that returns the specified distance
% 
% Protoype:
%   d = return_PhD_distance(x,y,dist)
% 
% Inputs:
%   x       - a target feature vector
%   y       - a query feture vector
%   dist    - a string identitifer determining the type similarity function
%                       dist = 'cos' | 'euc' | 'ctb' | 'mahcos'
%   covar   - the inverse of the covariance matrix of the trainign samples
%             (required only for mahcos) - I do not perform any parameter
%             checking!!!!!
% 
% Outputs:
%   d       - the computed "distance" between x and y
% 
% Notes:
% In each case a small distance means a similar sample a large distance means
% a dissimilar smaple
% 
function d = return_PhD_distance(x,y,dist,covar)

if nargin==3
    [a,b]=size(x);
    covar = eye(a,a);
end

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




