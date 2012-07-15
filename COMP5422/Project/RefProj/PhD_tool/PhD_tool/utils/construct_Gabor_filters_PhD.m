% The function constructs a filter bank of complex Gabor filters
% 
% PROTOTYPE
% filter_bank = construct_Gabor_filters_PhD(num_of_orient, num_of_scales, size, fmax, ni, gamma, separation);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       filter_bank = construct_Gabor_filters_PhD(8, 5, [128 128]);
%       figure
%       imshow(real(filter_bank.spatial{3,4}(64:64+128,64:64+128)),[])
%       title('An example of the real part of a Gabor filter.')
%       figure
%       imshow(abs(filter_bank.spatial{3,4}(64:64+128,64:64+128)),[])
%       title('An example of the magnitude of a Gabor filter.')
% 
%     Example 2:
%       filter_bank = construct_Gabor_filters_PhD(6, 5, 100);
%       figure
%       imshow(real(filter_bank.spatial{3,4}(50:50+100,50:50+100)),[])
%       title('An example of the real part of a Gabor filter.')
%       figure
%       imshow(abs(filter_bank.spatial{3,4}(50:50+100,50:50+100)),[])
%       title('An example of the magnitude of a Gabor filter.')
% 
%     Example 3:
%       filter_bank = construct_Gabor_filters_PhD(8, 4, [100 128]);
%       figure
%       imshow(real(filter_bank.spatial{3,4}(50:50+100,64:64+128)),[])
%       title('An example of the real part of a Gabor filter.')
%       figure
%       imshow(abs(filter_bank.spatial{3,4}(50:50+100,64:64+128)),[])
%       title('An example of the magnitude of a Gabor filter.')
% 
%
% GENERAL DESCRIPTION
% The function constructs a bank of complex Gabor filters determined by the 
% parameters num_of_orient, num_of_scales, size, fmax, ni, gamma, and separation. 
% These filter are often used for extraction of Gabor magnitude features (or 
% lately Gabor phase features) from facial images. Typically, a filter bank
% of 40 filters (8 orientations and 5 scales) is used for the purpose of
% facial feature extraction.
% 
% The function returns a structure with several memebers including the
% filters themselves defined in the spatial and frequency domains.
% 
% In this function the following definition of Gabor filters is used in
% the implementation:
% 
%   filter(x,y) = (fu^2/(pi*ni*gamma)) * exp(-(xp^2/gamma^2+yp^2/ni^2)) *
%                 * exp(j*2*pi*fu*xp);
% 
%   where
% 
%   xp = x*cos(theta_v)+y*sin(theta_v)
%   yp = -x*sin(theta_v)+y*cos(theta_V)
% 
%   and
% 
%   fu = fmax/separation^u,    theta_v = (v/pi)*pi   
% 
%   and
% 
%   u = 0,1,...,num_of_scales-1;     v = 0,1,...,num_of_orient-1
% 
% 
% REFERENCES
% The definition of the Gabor filters used in this function is in more
% detail described in: 
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
%
%
% INPUTS:
% num_of_orient         - a scalar value determining the number of filter 
%                         orientations of the filter bank (obligatory
%                         argument)
% num_of_scales         - a scalar value determining the number of filter
%                         scales of the filter bank (obligatory argument)
% size                  - a scalar value or matrix of size 1x2, which
%                         determines the size of the constructed Gabor 
%                         filters; the size has to be equal to the size of 
%                         the image that you would like to filter; if you 
%                         provide only a scalar a bank of square filters of 
%                         size "size x size" will be build (obligatory argument)
% fmax                  - the maximal frequency of the filters in the bank
%                         (default: 0.25)
% gamma                 - a scalar value determining the x-axis sharpness; 
%                         default: gamma = sqrt(2)
% ni                    - a scalar value determining the y-axis sharpness; 
%                         default: ni    = sqrt(2)
% separation            - a scalar value determinig the step between two
%                         consequtive filter scales; default: sqrt(2)
%
% OUTPUTS:
% filter_bank           - a structure containing members that define the 
%                         constructed Gabor filter bank; the structure has 
%                         the following members:
% 
%  filter_bank.spatial  . . . a cell array of size "num_of_scales X num_of_orient"
%                             containing the Gabor filter bank in the
%                             spatial domain
%  filter_bank.freq     . . . a cell array of size "num_of_scales X num_of_orient"
%                             containing the Gabor filter bank in the
%                             frequency domain
%  filter_bank.scales   . . . a scalar value containing the value of filter
%                             scales in the constructed filter bank 
%  filter_bank.orient   . . . a scalar value containing the value of filter
%                             orientations in the constructed filter bank                   
%                         
%
% NOTES / COMMENTS
% The function constructs a set of Gabor filters in the spatial and
% frequency domains and stores them together with their parameters into the
% output structure. This function is provided in the toolbox not be used on
% its own, but as means to construct Gabor filters that can be deployed for
% facial feature extraction. You can also easily visualize the real,
% imaginary, phase and magnitude part of the filters.
%
% The function was tested with Matlab ver. 7.11.0.584 (R2010b) running on a
% 64-bit Windows 7 OS.
%
% 
% RELATED FUNCTIONS (SEE ALSO)
% filter_image_with_Gabor_bank_PhD
% produce_phase_congruency_PhD
% 
% 
% ABOUT
% Created:        17.11.2011
% Last Update:    17.11.2011
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


function filter_bank = construct_Gabor_filters_PhD(num_of_orient, num_of_scales, size1, fmax, ni, gamma, separation);

%% Init
filter_bank = [];

%% Check inputs

%check number of inputs
if nargin <3
    disp('Wrong number of input parameters! The function requires at least three input arguments.')
    return;
elseif nargin >7
    disp('Wrong number of input parameters! The function takes no more than seven input arguments.')
    return;
elseif nargin==3
    fmax = 0.25;
    ni = sqrt(2);
    gamma = sqrt(2);
    separation = sqrt(2);
elseif nargin==4
    ni = sqrt(2);
    gamma = sqrt(2);
    separation = sqrt(2);
elseif nargin==5
    gamma = sqrt(2);
    separation = sqrt(2);
elseif nargin==6
    separation = sqrt(2);    
end

%check size
[a,b]=size(size1);
if a == 1 && b==1
    size1 = [size1 size1];
elseif a==1 && b==2
    %ok
elseif a==2 && b==1
    size1=size1'; %this is actually not needed
else
    disp('The parameter determining the size of the filters is not valid.')
    return;
end

%% Construct Gabor filter bank

%init
filter_bank.spatial = cell(num_of_scales,num_of_orient);
filter_bank.freq = cell(num_of_scales,num_of_orient);

%construct filters
for u = 0:num_of_scales-1 %for each scale
    fu = fmax/(separation)^u;
    alfa = fu/gamma;
    beta = fu/ni;
    sigma_x = size1(2); 
    sigma_y = size1(1);
    for v = 0:num_of_orient-1 %for each orientation
        theta_v = (v/8)*pi;
        %clear gabor
        for x=-sigma_x:sigma_x-1      %we use double the size for frequency-domain computation
            for y=-sigma_y:sigma_y-1
                xc = x*cos(theta_v)+y*sin(theta_v);
                yc = -x*sin(theta_v)+y*cos(theta_v);
                gabor(sigma_y+y+1,sigma_x+x+1)= ((fu^2)/(pi*gamma*ni))*exp(-(alfa^2*xc^2 + beta^2*yc^2))*...
                    exp((2*pi*fu*xc)*i);
            end
        end 
        filter_bank.spatial{u+1,v+1} = gabor;
        filter_bank.freq{u+1,v+1}=fft2(gabor); 
    end
end

filter_bank.scales = num_of_scales;
filter_bank.orient = num_of_orient;











