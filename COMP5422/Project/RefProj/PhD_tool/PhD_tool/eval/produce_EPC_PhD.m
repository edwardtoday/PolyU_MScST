% The function produces EPC curve data from genuine and impostor scores belonging to development and evaluation data
% 
% PROTOTYPE
% [alpha,errors,rates_and_threshs1] = produce_EPC_PhD(true_d,false_d,true_e,false_e,rates_and_threshs,points);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       %we generate the scores needed for this example ourselves
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.5 + 0.9*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
%       true_scores1 = 0.6 + 0.8*randn(1000,1);
%       false_scores1 = 3.3 + 0.8*randn(1000,1);
%       [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1,rates,20);
% 
% 
%     Example 2:
%       %we generate the scores needed for this example ourselves
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.5 + 0.9*randn(1000,1);
%       true_scores1 = 0.6 + 0.8*randn(1000,1);
%       false_scores1 = 3.3 + 0.8*randn(1000,1);
%       [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1,[],40);
% 
% 
%     Example 3:
%       %we generate the scores needed for this example ourselves
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.5 + 0.9*randn(1000,1);
%       true_scores1 = 0.6 + 0.8*randn(1000,1);
%       false_scores1 = 3.3 + 0.8*randn(1000,1);
%       [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1);
% 
% 
% 
% GENERAL DESCRIPTION
% The function computes EPC curve data from the input data. The function 
% takes either four, five or six input arguments. Here, the first four 
% input arguments are obligatory and in order represent the 
% genuine/true/client scores (i.e., true_d) computed from a development 
% image set, the impostor/false matching scores (i.e., false_d) computed 
% from a development image set, hte genuine/true/client matching scores 
% (i.e., true_e) computed from an evaluation/test image set and the 
% impostor/false matching scores (i.e., false_e) computed from an 
% evaluation/test image set. Obviously, two separate image sets are needed 
% to generate the matching scores needed by this function. Note that EPC 
% curves provide information of how well a face recognition system is 
% "calibrated". Or to put it differently, they show how a threshold set on 
% some development set affects the trade-off between the FAR and FRR on 
% some evaluation/test image set. The fifth and sixth input argument of the
% function are optional and denote the characteristic error rates computed
% from the true_d and false_d vecor using the produce_ROC_PhD function and 
% the number of points at which to compute the EPC curve. Thiese last two 
% arguemnts can be omitted, in which case the defaults are used, i.e.,
% rates_and_threshs = [], and points = 10;   
% 
% Note that the function assumes that a distance rather than a similarity 
% measure is used for matching-score calculation. This means that the 
% client scores (true_d, true_e) are expected to be below the impostor 
% scores (false_d,false_e) on average.
% 
% The function return three parameter; a vector of alphas "alpha", where
% alpha is aweighting factor weighting the relative importance of the FAR
% and FRR, i.e., 
%             WER = alpha*FAR + (1-alpha)*FRE;
% a vector of corresponding error rates "errors" and the rates_and_threshs1
% structure that contains characteristic values of the error rates at 
% different operating points on the EPC curve as well as the correspodning 
% decision thresholds.  
% 
% 
% REFERENCES
% A useful reference, wher you can learn about EPC curves is:
% 
% S. Bengio and J. Marithoz, “The expected performance curve: a new 
% assessment measure for person authentication,” in Proceedings of the 
% Speaker and Language Recognition Workshop Oddyssey, pp. 279–284, Toledo, 
% Spain, 2004.
%
%
%
% INPUTS:
% true_d                - a vector of genuine/client/true scores, which is 
%                         expected to have been produced using a distance 
%                         measure and not a similarity measure on a 
%                         development image set (obligatory argument)
% false_d               - a vector of impostor/false scores, which is 
%                         expected to have been produced using a distance 
%                         measure and not a similarity measure on a 
%                         development image set (obligatory argument)
% true_e                - a vector of genuine/client/true scores, which is 
%                         expected to have been produced using a distance 
%                         measure and not a similarity measure on an 
%                         evaluation/test image set (obligatory argument)
% false_e               - a vector of impostor/false scores, which is 
%                         expected to have been produced using a distance 
%                         measure and not a similarity measure on an 
%                         evaluation/test image set (obligatory argument)
% rates_and_threshs     - a structure computed based on true_d and false_d
%                         using the produce_ROC_PhD function; this argument 
%                         is only needed if you want to compute 
%                         characteristic error rates on the EPC curve, 
%                         otherwise set to [] (optional argument)  
% points                - a parameter determining the number of points at
%                         which to compute the EPC curve data; default=10 
%                         (optional argument)
%
% OUTPUTS:
% alpha                 - a 1 x points vector of alpha vealues of the EPC
%                         curve
% errors                - a 1 x points vector of error values corresponding
%                         to the alpha values in the vector described above
% rates_and_threshs1    - a structure with data computed at characteristic
%                         operating points on the ROC and ECP curves; the 
%                         structure is identitcal to the structure 
%                         described in the help paret of the 
%                         produce_ROC_PhD function with a few additional 
%                         fields; the additional fields correspond to some 
%                         characteristic error rates at the EPC curve and 
%                         carry a prefix "test"; their meaninig is
%                         identitcal to that described in 
%                         the produce_ROC_PhD function 
% 
%
% NOTES / COMMENTS
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% 
% RELATED FUNCTIONS (SEE ALSO)
% plot_EPC_PhD  
% produce_CMC_PhD
% produce_ROC_PhD
% 
% 
% ABOUT
% Created:        11.2.2010
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

function [alpha,errors,rates_and_threshs1] = produce_EPC_PhD(true_d,false_d,true_e,false_e,rates_and_threshs,points);

%% Init Operations
alpha = [];
errors = [];
rates_and_threshs1 = [];

%% Check inputs
Thresh_flag=0;

%check number of inputs
if nargin <4
    disp('Wrong number of input parameters! The function requires at least four input arguments.')
    return;
elseif nargin >6
    disp('Wrong number of input parameters! The function takes no more than six input arguments.')
    return;
elseif nargin==4
    rates_and_threshs = [];
    points = 10;
elseif nargin == 5
    %set points and flag
    points = 10;
    Thresh_flag=1;
elseif nargin ==6
    Thresh_flag=1;
end

if(isempty(rates_and_threshs))
    Thresh_flag = 0;
end

%I have some copying to do - because I do not want to change the rest of
%the code ;) - just copying from the old function
dmax_d=true_d;
clear true_d
dmin_d=false_d;
clear false_d
dmax_e=true_e;
clear true_e
dmin_e=false_e;
clear false_e

%check for other values
if isnumeric(dmax_d)==1 && isvector(dmax_d)==1
    %ok
else
    disp('The first argument needs to be a numeric vector!')
    return;
end

if isnumeric(dmin_d)==1 && isvector(dmin_d)==1
    %ok
else
    disp('The second argument needs to be a numeric vector!')
    return;
end

if isnumeric(dmax_e)==1 && isvector(dmax_e)==1
    %ok
else
    disp('The third argument needs to be a numeric vector!')
    return;
end
    
if isnumeric(dmin_e)==1 && isvector(dmin_e)==1
    %ok
else
    disp('The fourth argument needs to be a numeric vector!')
    return;
end


if~(isempty(rates_and_threshs))
%check rates and threshs - just the first of all, we assume that others
    %are also present - no time to do it wright
    if isfield(rates_and_threshs,'EER_er')~=1
        disp('Missing EER data! Terminating.')
        return;
    end
    
    if isfield(rates_and_threshs,'FRR_01FAR_er')~=1
        disp('Missing FRR = 0.1 FAR data! Terminating.')
        return;
    end
    
    if isfield(rates_and_threshs,'FRR_10FAR_er')~=1
        disp('Missing FRR = 10 FAR data! Terminating.')
        return;
    end
    
    if isfield(rates_and_threshs,'VER_001FAR_er')~=1
        disp('Missing VER @ 0.01% FAR data! Terminating.')
        return;
    end
    
    if isfield(rates_and_threshs,'VER_01FAR_er')~=1
        disp('Missing VER @ 0.1% FAR data! Terminating.')
        return;
    end
    
    if isfield(rates_and_threshs,'VER_1FAR_er')~=1
        disp('Missing VER @ 1% FAR data! Terminating.')
        return;
    end
else
    Thresh_flag = 0;
end
    
if isnumeric(points) ~=1
    disp('The last argument needs to be a numeric value.')
end

if points<1
    disp('The last argument needs to be larger than one! Switching to defaults: points = 10.')
    points = 10;
end


%% Compute EPC curve data

mores=points-1;

%first some opertations on the development set
[a,b]=size(dmax_d);
[c,d]=size(dmin_d);

if a~=1
    dmax_d=dmax_d';
    [a,b]=size(dmax_d);
end

if c~=1
    dmin_d=dmin_d';
    [c,d]=size(dmin_d);
end

dminx = min(dmax_d);
dmaxx = max(dmin_d);

%computing FRE curve
delta = (dmaxx-dminx)/10000;
counter=1;
for trash=dminx:delta:dmaxx
        num_ok = sum((dmax_d<trash));
        fre(counter) = 1-(num_ok/(b));
        counter = counter+1;
end

%copmuting FAE curve
counter=1;
for trash=dminx:delta:dmaxx
    num_ok = sum((dmin_d<trash));
    fae(counter) = (num_ok/(d));
    counter = counter+1;
end

% figure,plot(fae,fre)
dist = (0.9-0.1)/mores; %we set the limits of alpha to 0.1-0.9
trashes = zeros(1,points);
cont=1;
for beta = 0.1:dist:0.9
    C = beta*fae + (1-beta)*fre;
    [dummy,index] = min(C);
    trashes(cont) = dminx+(index-1)*delta;
    cont=cont+1;       
end

%one output
alpha = 0.1:dist:0.9;

%now use the evaluation or test set
clear fae fre 
[a,b]=size(dmax_e);
[c,d]=size(dmin_e);

if a~=1
    dmax_e=dmax_e';
    [a,b]=size(dmax_e);
end

if c~=1
    dmin_e=dmin_e';
    [c,d]=size(dmin_e);
end

%second output
errors=zeros(1,points);
for i=1:points
    num_ok = sum((dmax_e<trashes(i)));
    fre = 1-(num_ok/(b));
    num_ok = sum((dmin_d<trashes(i)));
    fae = (num_ok/(d));
    errors(1,i) = (fre+fae)/2;
end

if Thresh_flag==1
    %EER on the development set
    rates_and_threshs.test_EER_frr = sum(dmax_e>rates_and_threshs.EER_tr)/b;
    rates_and_threshs.test_EER_ver = 1-rates_and_threshs.test_EER_frr;
    rates_and_threshs.test_EER_far = sum(dmin_e<rates_and_threshs.EER_tr)/d;

    %FRR = 0.1FAR on the development set
    rates_and_threshs.test_FRR_01FAR_frr = sum(dmax_e>rates_and_threshs.FRR_01FAR_tr)/b;
    rates_and_threshs.test_FRR_01FAR_ver = 1-rates_and_threshs.test_FRR_01FAR_frr;
    rates_and_threshs.test_FRR_01FAR_far = sum(dmin_e<rates_and_threshs.FRR_01FAR_tr)/d;

    %FRR = 10FAR on the development set
    rates_and_threshs.test_FRR_10FAR_frr = sum(dmax_e>rates_and_threshs.FRR_10FAR_tr)/b;
    rates_and_threshs.test_FRR_10FAR_ver = 1- rates_and_threshs.test_FRR_10FAR_frr;
    rates_and_threshs.test_FRR_10FAR_far = sum(dmin_e<rates_and_threshs.FRR_10FAR_tr)/d;

    %001FAR on the development set
    rates_and_threshs.test_VER_001FAR_frr = sum(dmax_e>rates_and_threshs.VER_001FAR_tr)/b;
    rates_and_threshs.test_VER_001FAR_ver = 1-rates_and_threshs.test_VER_001FAR_frr;
    rates_and_threshs.test_VER_001FAR_far = sum(dmin_e<rates_and_threshs.VER_001FAR_tr)/d;

    %01FAR on the development set
    rates_and_threshs.test_VER_01FAR_frr = sum(dmax_e>rates_and_threshs.VER_01FAR_tr)/b;
    rates_and_threshs.test_VER_01FAR_ver = 1-rates_and_threshs.test_VER_01FAR_frr;
    rates_and_threshs.test_VER_01FAR_far = sum(dmin_e<rates_and_threshs.VER_01FAR_tr)/d;

    %1FAR on the development set
    rates_and_threshs.test_VER_1FAR_frr = sum(dmax_e>rates_and_threshs.VER_1FAR_tr)/b;
    rates_and_threshs.test_VER_1FAR_ver = 1-rates_and_threshs.test_VER_1FAR_frr;
    rates_and_threshs.test_VER_1FAR_far = sum(dmin_e<rates_and_threshs.VER_1FAR_tr)/d;
else
    rates_and_threshs=[];
end
rates_and_threshs1=rates_and_threshs;





























