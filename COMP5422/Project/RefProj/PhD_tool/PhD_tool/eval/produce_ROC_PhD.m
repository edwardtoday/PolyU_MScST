% The function produces ROC curve data from genuine and impostor scores
% 
% PROTOTYPE
% [ver_rate, miss_rate, rates_and_threshs] = produce_ROC_PhD(true_scores, false_scores, resolution)
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       %we generate the guinine and impostor score data ourselves; 
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.5 + 0.9*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores,5000);
%       %now we coukd plot the ROC curve and look at some characterstics of
%       %the ROC curve by examining the value of "rates" 
% 
%     Example 2:
%       %we generate the guinine and impostor score data ourselves; 
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.5 + 0.9*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
%       %now we coukd plot the ROC curve and look at some characterstics of
%       %the ROC curve by examining the value of "rates" 
%
% GENERAL DESCRIPTION
% The function generates ROC curve data from genuine (client) and impostor 
% matching scores. The function takes either two or three input arguments 
% with the first being the a vector of genuine matching scores (i.e., the 
% client scores), the second being a vector of impostor matching scores,
% and the third being the number of points (i.e., the resolution) at which
% to compute the ROC cruve data. If the last input argument is omitted 
% during the function call, a default value of 2500 is used. Note that the 
% function assumes that a distance rather than a similarity measure is used 
% for matching-score calculation. This means that the client scores 
% (true_scores) are expected to be below the impostor scores (false_scores) 
% on average. 
% 
% The function returns three parameters: the verification rate ver_rate
% that corresponds to 1-FRR (where FRR stands for the false rejection
% rate); the miss verification rate that corresponds to the FAR (where FAR 
% stands for the false acceptance rate); and the rates_and_threshs structure
% that contains characteristic values of the error rates at different 
% operating points on the ROC curve as well as the correspodning decision 
% thresholds. 
%
% 
% REFERENCES
% There are several references available in the literature that describe 
% ROC curves and ways to plot them. A short description is alsgo given in:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
%
%
% INPUTS:
% true_scores           - a vector of genuine/client/true scores, which is 
%                         expected to have been produced using a distance 
%                         measure and not a similarity measure (obligatory 
%                         argument)
% false_scores          - a vector of impostor/false scores, which is 
%                         expected to have been produced using a distance 
%                         measure and not a similarity measure (obligatory 
%                         argument) 
% resolution            - a parameter determining the number of points at
%                         which to compute the ROC curve data; default=2500 
%                         (optional argument)
%
% OUTPUTS:
% ver_rate              - a vector of size 1 x (resolution+1) containing the 
%                         verification rates of the ROC curve evaluated at 
%                         the corresponding treshold values; the values in
%                         the vector stand for 1-FRR; where FRR is the
%                         false rejection rate
% miss_rate             - a vector of size 1 x (resolution+1) containing the miss 
%                         verification rates of the ROC curve evaluated at 
%                         the corresponding treshold values; the values in
%                         the vector stand for 1-FAR; where FAR is the
%                         false acceptance rate
% rates_and_threshs     - a structure with data computed at characteristic
%                         operating points on the ROC curve; the structure 
%                         contains the following fields: 
%                         
%         .minHTER_er   - the value of the half total error rate at the ROC
%                         operating point that ensures the minimum value of 
%                         the half total error rate; where 
%                                       HTER = (FAR+FRR)/2
%         .minHTER_tr   - the threshold needed to obtain the minimum HTER 
%         .minHTER_frr  - the value of the FRR at the minimum HTER 
%         .minHTER_ver  - the value of the verification rate at the
%                         minimum HTER
%         .minHTER_far  - the value of the FAR at the minimum HTER 
% 
% 
%         .EER_er       - the value of the half total error rate at the ROC
%                         operating point that ensures equal error rates 
%                         (EER); i.e., FAR=FRR
%         .EER_tr       - the threshold needed to obtain the EER 
%         .EER_frr      - the value of the FRR at the EER 
%         .EER_ver      - the value of the verification rate at the EER                      
%         .EER_far      - the value of the FAR at the EER 
% 
% 
%         .FRR_01FAR_er  - the value of the half total error rate at the 
%                          ROC operating point that ensures that the false 
%                          acceptance rate is 10 times higher than the 
%                          false rejection rate; i.e., FAR=0.1FRR
%         .FRR_01FAR_tr  - the threshold needed to obtain FAR=0.1FRR 
%         .FRR_01FAR_frr - the value of the FRR at FAR=0.1FRR 
%         .FRR_01FAR_ver - the value of the verification rate at FAR=0.1FRR                      
%         .FRR_01FAR_far - the value of the FAR at FAR=0.1FRR 
% 
% 
%         .FRR_10FAR_er  - the value of the half total error rate at the 
%                          ROC operating point that ensures that the false 
%                          rejection rate is 10 times higher than the 
%                          false acceptance rate; i.e., FAR=10FRR
%         .FRR_10FAR_tr  - the threshold needed to obtain FAR=10FRR 
%         .FRR_10FAR_frr - the value of the FRR at FAR=10FRR 
%         .FRR_10FAR_ver - the value of the verification rate at FAR=10FRR                      
%         .FRR_10FAR_far - the value of the FAR at FAR=10FRR
% 
% 
%         .VER_001FAR_er  - the value of the half total error rate at the 
%                           ROC operating point where the FAR equals 0.01% 
%         .VER_001FAR_tr  - the threshold needed to a FAR of 0.01%
%         .VER_001FAR_frr - the value of the FRR a FAR of 0.01% 
%         .VER_001FAR_ver - the value of the verification rate at a FAR of 
%                           0.01%                      
%         .VER_001FAR_far - the value of the FAR at a FAR of 0.01% (note 
%                           that this is the actual value of the FAR, since 
%                           there might not be anough data to obtain an FAR 
%                           of exactly 0.01%)
% 
% 
%         .VER_01FAR_er  - the value of the half total error rate at the 
%                          ROC operating point where the FAR equals 0.1% 
%         .VER_01FAR_tr  - the threshold needed to a FAR of 0.1%
%         .VER_01FAR_frr - the value of the FRR a FAR of 0.1% 
%         .VER_01FAR_ver - the value of the verification rate at a FAR of 
%                          0.1%                      
%         .VER_01FAR_far - the value of the FAR at a FAR of 0.1% (note 
%                          that this is the actual value of the FAR, since 
%                          there might not be anough data to obtain an FAR 
%                          of exactly 0.1%)
% 
% 
%         .VER_1FAR_er  - the value of the half total error rate at the 
%                          ROC operating point where the FAR equals 1% 
%         .VER_1FAR_tr  - the threshold needed to a FAR of 1%
%         .VER_1FAR_frr - the value of the FRR a FAR of 1% 
%         .VER_1FAR_ver - the value of the verification rate at a FAR of 
%                          1%                      
%         .VER_1FAR_far - the value of the FAR at a FAR of 1% (note 
%                          that this is the actual value of the FAR, since 
%                          there might not be anough data to obtain an FAR 
%                          of exactly 1%)
%                         
%
% NOTES / COMMENTS
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% 
% RELATED FUNCTIONS (SEE ALSO)
% plot_ROC_PhD  
% produce_CMC_PhD
% produce_EPC_PhD
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

function [ver_rate, miss_rate, rates_and_threshs] = produce_ROC_PhD(true_scores, false_scores, resolu)

%% Init 
ver_rate = [];
miss_rate = [];
rates_and_threshs = [];

%% Check inputs
%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin >3
    disp('Wrong number of input parameters! The function takes no more than three input arguments.')
    return;
elseif nargin==2
    resolu = 2500;
end

%check for values
    if isnumeric(resolu)~=1
        disp('The resolution parameter needs to be a numeric value!')
        return;
    end
    
    if resolu<500
        disp('Resultion for ROC is rather small. Incerasing to 500!')
        resolu = 500;
    end
    
    if isvector(true_scores)~=1
        disp('The "true scores" parameter needs to be a numeric vector!')
        return;
    end
    
    if isvector(false_scores)~=1
        disp('The "false scores" parameter needs to be a numeric vector!')
        return;
    end
    
    if isnumeric(true_scores)~=1
        disp('The "true scores" parameter needs to be a numeric vector!')
        return;
    end
    
    if isnumeric(false_scores)~=1
        disp('The "false scores" parameter needs to be a numeric vector!')
        return;
    end

%% Init operations
cli_scor = numel(true_scores);
imp_scor = numel(false_scores);

dmax = true_scores;
dmin = false_scores;


%% Compute ROC curve data

%get maximum and minimum value
dminx = min(true_scores);
dmaxx = max(false_scores);

%computing FRE curve
delta = (dmaxx-dminx)/resolu;
counter=1;
fre = zeros(1,resolu);
for trash=dminx:delta:dmaxx
    num_ok = sum(dmax<trash);
    fre(1,counter) = 1-(num_ok/cli_scor);
    counter = counter+1;
end

%copmuting FAE curve
counter=1;
fae = zeros(1,resolu);
for trash=dminx:delta:dmaxx
    num_ok = sum(dmin<trash);
    fae(1,counter) = (num_ok/imp_scor);
    counter = counter+1;
end

%% Computing characteristic error rates and corresponding thresholds

%Minimal HTER
C=fae+fre;
[dummy,index] = min(C);
rates_and_threshs.minHTER_er  = C(index)/2;
rates_and_threshs.minHTER_tr  = dminx+(index-1)*delta;
rates_and_threshs.minHTER_frr = sum(dmax>(dminx+(index-1)*delta))/cli_scor;
rates_and_threshs.minHTER_ver = 1-rates_and_threshs.minHTER_frr;
rates_and_threshs.minHTER_far = sum(dmin<(dminx+(index-1)*delta))/imp_scor;


%EER, FRR = 0.1FAR, FRR = 10FAR, @0.01%FAR, @0.1%FAR, @1%FAR
maxi1=Inf;
maxi2=Inf;
maxi3=Inf;
maxi4=Inf;
maxi5=Inf;
maxi6=Inf;
for i=1:resolu+1
    %EER
    if abs(fae(i)-fre(i))<maxi1
       index1 = i;
       maxi1=abs(fae(i)-fre(i));
    end
    
    %FRR = 0.1FAR
    if abs(0.1*fae(i)-fre(i))<maxi2
       index2 = i;
       maxi2=abs(0.1*fae(i)-fre(i));
    end
    
    %FRR = 10FAR
    if abs(10*fae(i)-fre(i))<maxi3
       index3 = i;
       maxi3=abs(10*fae(i)-fre(i));
    end
    
    %@0.01%FAR
    if abs(fae(i)-0.01/100)<maxi4
       index4 = i;
       maxi4=abs(fae(i)-0.01/100);
    end
    
    %@0.1%FAR
    if abs(fae(i)-0.1/100)<maxi5
       index5 = i;
       maxi5=abs(fae(i)-0.1/100);
    end
    
    %@1%FAR
    if abs(fae(i)-1/100)<maxi6
       index6 = i;
       maxi6=abs(fae(i)-1/100);
    end
    
end

%EER
rates_and_threshs.EER_er  = C(index1)/2;
rates_and_threshs.EER_tr  = dminx+(index1-1)*delta;
rates_and_threshs.EER_frr = sum(dmax>(dminx+(index1-1)*delta))/cli_scor;
rates_and_threshs.EER_ver = 1-rates_and_threshs.EER_frr;
rates_and_threshs.EER_far = sum(dmin<(dminx+(index1-1)*delta))/imp_scor;

%FRR = 0.1FAR
rates_and_threshs.FRR_01FAR_er  = C(index2)/2;
rates_and_threshs.FRR_01FAR_tr  = dminx+(index2-1)*delta;
rates_and_threshs.FRR_01FAR_frr = sum(dmax>(dminx+(index2-1)*delta))/cli_scor;
rates_and_threshs.FRR_01FAR_ver = 1-rates_and_threshs.FRR_01FAR_frr;
rates_and_threshs.FRR_01FAR_far = sum(dmin<(dminx+(index2-1)*delta))/imp_scor;

%FRR = 10FAR
rates_and_threshs.FRR_10FAR_er  = C(index3)/2;
rates_and_threshs.FRR_10FAR_tr  = dminx+(index3-1)*delta;
rates_and_threshs.FRR_10FAR_frr = sum(dmax>(dminx+(index3-1)*delta))/cli_scor;
rates_and_threshs.FRR_10FAR_ver = 1-rates_and_threshs.FRR_10FAR_frr;
rates_and_threshs.FRR_10FAR_far = sum(dmin<(dminx+(index3-1)*delta))/imp_scor;

%001FAR
rates_and_threshs.VER_001FAR_er  = C(index4)/2;
rates_and_threshs.VER_001FAR_tr  = dminx+(index4-1)*delta;
rates_and_threshs.VER_001FAR_frr = sum(dmax>(dminx+(index4-1)*delta))/cli_scor;
rates_and_threshs.VER_001FAR_ver = 1-rates_and_threshs.VER_001FAR_frr;
rates_and_threshs.VER_001FAR_far = sum(dmin<(dminx+(index4-1)*delta))/imp_scor;

%01FAR
rates_and_threshs.VER_01FAR_er  = C(index5)/2;
rates_and_threshs.VER_01FAR_tr  = dminx+(index5-1)*delta;
rates_and_threshs.VER_01FAR_frr = sum(dmax>(dminx+(index5-1)*delta))/cli_scor;
rates_and_threshs.VER_01FAR_ver = 1-rates_and_threshs.VER_01FAR_frr;
rates_and_threshs.VER_01FAR_far = sum(dmin<(dminx+(index5-1)*delta))/imp_scor;

%1FAR
rates_and_threshs.VER_1FAR_er  = C(index6)/2;
rates_and_threshs.VER_1FAR_tr  = dminx+(index6-1)*delta;
rates_and_threshs.VER_1FAR_frr = sum(dmax>(dminx+(index6-1)*delta))/cli_scor;
rates_and_threshs.VER_1FAR_ver = 1-rates_and_threshs.VER_1FAR_frr;
rates_and_threshs.VER_1FAR_far = sum(dmin<(dminx+(index6-1)*delta))/imp_scor;


%set outputs
ver_rate = 1- fre;
miss_rate = fae;





























