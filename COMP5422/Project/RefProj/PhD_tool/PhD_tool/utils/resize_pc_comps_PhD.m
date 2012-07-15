% The function resizes the phase congruency component and concatenates them into a high dimensional feature vector
% 
% PROTOTYPE
% feature_vector = resize_pc_comps_PhD(pc, down_fak);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       X=double(imread('sample_face.bmp'));
%       filter_bank = construct_Gabor_filters_PhD(8,5, [128 128]);
%       [pc,EO] = produce_phase_congruency_PhD(X,filter_bank);
%       feature_vector_extracted_from_X = resize_pc_comps_PhD(pc, 32); 
% 
%
% GENERAL DESCRIPTION
% The function downsamples all phase congruency components in the cell 
% array pc in accordance with the specified downsampling factor down_fak. 
% After the downsampling procedure all components are converted to vector 
% form and ultimatelly concatenated into a high dimensional feature vector 
% that is returned by the function as the result.    
% 
% After downsampling the function also performs zero mean and unit variance
% normalization on the downsampled pc compnents. Note that other
% normalization techniques often give a superior result (see the
% REFERENCES). To make use of another normalization technique, you have to 
% change the source code of this function by adding an additional function 
% call to, for example, the fitt_distribution function from my INFace 
% toolbox or Matlabs histeq function.    
%
% 
% REFERENCES
% The function is an implementation of part of the face recognition 
% technique described in:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
%
%
% INPUTS:
% pc                    - a cell array of phase congruency components 
%                         computed using the produce_phase_congruency_PhD
%                         function from the PhD toolbox (obligatory
%                         argument)
% down_fak              - a scalar value determining the downsampling 
%                         factor by which to reduce the size of the original 
%                         phase congruency components; default = 1 (no 
%                         downsampling); (optional argument).
%
% OUTPUTS:
% feature_vector        - a feature vector of phase congruency features
%                         
%
% NOTES / COMMENTS
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% RELATED FUNCTIONS (SEE ALSO)
% produce_phase_congruency_PhD
% filter_image_with_Gabor_bank_PhD
% construct_Gabor_filters_PhD
% 
% 
% ABOUT
% Created:        10.2.2010
% Last Update:    25.11.2011
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

function Y = resize_pc_comps_PhD(pc, down_fak);

%% Init ops.
Y=[];

%% Check inputs
if(nargin<1)
    disp('The funciton takes at least one input argument.')
    return;
elseif (nargin >2)
    disp('The funtion takes at most two input arguments.')
    return;
elseif nargin == 1
    down_fak  = 1;
end

if(~iscell(pc))
    disp('The input is not of the expected format.');
    return;
end

% get number of pc-s
[a,b] = size(pc);
norient = max([a,b]);

% get approxiate new size
[a,b] = size(pc{1});
down_fak = round(sqrt(down_fak));
new_size = [floor(a/down_fak) floor(b/down_fak)];

%% Main part

for i=1:norient
    tmp = imresize(pc{i},new_size,'bilinear');
    tmp = (tmp(:)-mean(tmp(:)))/std(tmp(:));
    %the above line could be replaced by, for example, the fitt_distribution
    %function from the INFace toolbox; hence, we could map an actual 
    %standardized normal distribution to the vector instead of only 
    %adjusting the mean and variance 
    Y=[Y;tmp];
end















