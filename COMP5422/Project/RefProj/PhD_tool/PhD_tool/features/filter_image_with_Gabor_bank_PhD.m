% The function filters the input image using a bank of gabor filters and returns the magnitudes of the results
% 
% PROTOTYPE
% filtered_image = filter_image_with_Gabor_bank_PhD(image,filter_bank,down_sampling_factor);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       img = imread('sample_face.bmp');
%       [a,b,c] = size(img);
%       filter_bank = construct_Gabor_filters_PhD(8, 5, [a b]);
%       filtered_image = filter_image_with_Gabor_bank_PhD(img,filter_bank,32);
%       num_of_pixels = sqrt(length(filtered_image)/(8*5));
%       imshow(reshape(filtered_image(24*num_of_pixels*num_of_pixels+1:25*num_of_pixels*num_of_pixels),num_of_pixels,num_of_pixels),[]);
% 
%     Example 2:
%       img = imread('sample_face.bmp');
%       [a,b,c] = size(img);
%       filter_bank = construct_Gabor_filters_PhD(8, 5, [a b]);
%       filtered_image = filter_image_with_Gabor_bank_PhD(img,filter_bank,1);
%       num_of_pixels = sqrt(length(filtered_image)/(8*5));
%       figure,imshow(reshape(filtered_image(14*num_of_pixels*num_of_pixels+1:15*num_of_pixels*num_of_pixels),num_of_pixels,num_of_pixels),[]);
%       figure,imshow(reshape(filtered_image(37*num_of_pixels*num_of_pixels+1:38*num_of_pixels*num_of_pixels),num_of_pixels,num_of_pixels),[]);
% 
% 
% GENERAL DESCRIPTION
% The function computes the magnitude reponses of an image filtered with a 
% filter bank of complex Gabor filters. It takes three input parameters
% among which the first wo are obligatory. The first input parameter stands
% for the image to be filtered, the second stands for the filter bank of
% complex Gabor filters that was constructed using the function
% "construct_Gabor_filters_PhD" and the third stands for the downsampling
% factor by which to reduce the size of filtered images to make further
% processing more efficient. The magnitude responses of the filtering
% operations are normalized after downscaling using zero-mean and unit
% variance normalization. After that they are added to the output vector 
% filtered_image. After the function is executed all magnitude filter
% responses are in vector form concatenated into the vector filtered_image. 
% This vector has a size of approximatelly (there are some differences due 
% to rounding errors):
%   (number_of_filters*img_width*img_height/downsampling_factor) x 1 
%
% 
% REFERENCES
% There is a lot of references out there that describe how to filter an
% input image with a bank of filters. Some information on this topic can be
% found in:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
%
%
% INPUTS:
% image                 - a grey-scale input image of arbitrary size that 
%                         needs to be filtered with a bank of Gabor
%                         filters; note that the default parameters are set
%                         in a way that favours 128x128 pixel images
%                         (obligatory argument)
% filter_bank           - a structure containing a bank of Gabor filters in 
%                         the spatial and frequency domains created with 
%                         the function "construct_Gabor_filters_PhD"; 
%                         (obligatory argument) 
% down_sampling_factor  - a scalar value determining the downsampling
%                         factor by which to downscale the filtering 
%                         outputs; (optional parameter; default = 64)  
%
% OUTPUTS:
% filtered_image        - a vector containing the concatenated magnitude 
%                         responses of the filtering operation; 
%                         considering a filter bank of 40 filters, an 
%                         input image of size 128x128 pixels and a 
%                         down-sampling factor of 1 (i.e., no downsampling), 
%                         the resulting vector filtered_image would have  
%                         a size of 655360x1 (40filters*16384 pixels X 1);
%                         we could extract an individual filter response
%                         from the result vector using: 
%  
% response_to_filter_no_i = filtered_image((i-1)*num_of_pixels+1:i*num_of_pixels),
% 
% where num_of_pixels is the number of pixels of a downsampled magnitude 
% response; for a downsampling factor of 1, this equals the number of 
% pixels of the original input image.
% 
%
% NOTES / COMMENTS
% It is possible to modify the function to return the real part of the
% filtering responses or the imaginary part of the filtering responses by
% adjusting the source code of this function. The code for this
% modification is already included in the function, you just have to
% uncomment the appropriate line of code and comment out the currently 
% active line of code. The lines are clearly marked in the code.
% 
% Furthermore it is possible to change the normalization used after the 
% downsampling procedure. The default here is zero mean normalization, 
% however, you can use distribution mapping by again uncommenting the 
% appropriate lines of code. For that you need the INFace toolbox as well.   
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% RELATED FUNCTIONS (SEE ALSO)
% construct_Gabor_filters_PhD
% produce_phase_congruency_PhD
% 
% 
% ABOUT
% Created:        10.2.2010
% Last Update:    23.11.2011
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

function filtered_image = filter_image_with_Gabor_bank_PhD(image,filter_bank,down_sampling_factor);

%% Init ops
filtered_image = [];

%% Check inputs

%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin >3
    disp('Wrong number of input parameters! The function takes at most three input arguments.')
    return;
elseif nargin==2
    down_sampling_factor = 64;
end

%check down-sampling factor
if isnumeric(down_sampling_factor)~=1
    disp('The down-sampling factor needs to be a numeric value between larger or equal than 1! Swithing to defaults: 64');
    down_sampling_factor=64;
end

if size(down_sampling_factor,1)==1 && size(down_sampling_factor,2)==1 && down_sampling_factor>=1
    %ok
else
    disp('The downsampling factor needs to be a single number, greater or equal to one!')
    return;
end

%check filter bank   
    if isfield(filter_bank,'spatial')~=1
        disp('Could not find filters in the spatial domain. Missing filter_bank.spatial!')
        return;
    end
    
    if isfield(filter_bank,'freq')~=1
        disp('Could not find filters in the frequency domain. Missing filter_bank.freq!')
        return;
    end
    
    if isfield(filter_bank,'orient')~=1
        disp('Could not determine angular resolution. Missing filter_bank.orient!')
        return;
    end
    
    if isfield(filter_bank,'scales')~=1
        disp('Could not determine frequency resolution. Missing filter_bank.scales!')
        return;
    end
    
    %check image and filter size
    [a,b]=size(image);
    [c,d]=size(filter_bank.spatial{1,1}); %lets look at the first
    
    if a==2*c && d==2*b
        disp('The dimension of the input image and Gabor filters do not match! Damn! Terminating!')
        return;
    end
    
%% Compute output size
[a,b]=size(image);
dim_spec_down_sampl = round(sqrt(down_sampling_factor));
new_size = [floor(a/dim_spec_down_sampl) floor(b/dim_spec_down_sampl)];

%% Filter image in the frequency domain
image_tmp = zeros(2*a,2*b);
image_tmp(1:a,1:b)=image;
image = fft2(image_tmp);

for i=1:filter_bank.scales
    for j=1:filter_bank.orient
        
        %filtering
        Imgabout = ifft2((filter_bank.freq{i,j}.*image));
        gabout = abs(Imgabout(a+1:2*a,b+1:2*b));  
        
        % if you prefer to compute the real or imaginary part of the
        % filtering, uncomment the approapriate line below; the return 
        % value of the function will then be changed accordingly 
%         gabout = real(Imgabout(a+1:2*a,b+1:2*b));
%         gabout = imag(Imgabout(a+1:2*a,b+1:2*b));
    
        %down-sampling (the proper way to go is to use resizing (interpolation!!), sampling introduces high frequencies)
        y=imresize(gabout,new_size,'bilinear');
        
        y=(y(:)-mean(y(:)))/std(y(:)); %we use zero mean unit variance normalization - even though histogram equalization and gaussianization works better
        % comment out the line above and use
        % this one if you want to map a normal distribution to the filtered
        % image instead of only adjusting the mean and variance (you 
        % need my INface toolbox for that)
        % y = fitt_distribution(y);    
        y=y(:);
        
        %add to image
        filtered_image=[filtered_image;y];     
    end
end














