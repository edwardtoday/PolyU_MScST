% The function computes phase congruency features from an input image
% 
% PROTOTYPE
% [pc,EO] = produce_phase_congruency_PhD(X,filter_bank,nscale);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       X=double(imread('sample_face.bmp'));
%       filter_bank = construct_Gabor_filters_PhD(8,5, [128 128]);
%       [pc,EO] = produce_phase_congruency_PhD(X,filter_bank);
%       figure(1)
%       title('Phase congrunecy at first filter oreintation')
%       imshow(pc{1},[])
%       figure(2)
%       title('One of the magnitude responses of the filtering operation')
%       imshow(abs(EO{5,5}),[])
%       figure(3)
%       title('Original input image')
%       imshow(X,[])
% 
%     Example 2:
%       X = double(imread('sample_face.bmp'));
%       X = imresize(X,[128,100]);
%       filter_bank = construct_Gabor_filters_PhD(8,5, [128 100]);
%       [pc,EO] = produce_phase_congruency_PhD(X,filter_bank,4);
%       figure(1)
%       title('Phase congrunecy at second filter oreintation')
%       imshow(pc{2},[])
%       figure(2)
%       title('One of the magnitude responses of the filtering operation')
%       imshow(abs(EO{3,4}),[])
%       figure(3)
%       title('Original input image')
%       imshow(X,[])
%
% 
% GENERAL DESCRIPTION
% The function computes phase congruency features from an input image X 
% using a precomputed filter bank of complex Gabor filters (created with 
% the construct_Gabor_filters_PhD function). Optionally, the nscale 
% argument can be used to specifically set the number of scales over which 
% to compute the phase congruency features. The function outputs two cell 
% arrays, where the first (i.e., pc) contains the phase congruency of the 
% input image for each of the filter orientation in the filter bank and the 
% second contains the complex Gabor reponses of the filtering operation. 
% Hence, the second output cell array EO contains a similar result as the 
% filtered_image that represents the output of the filter_image_with_Gabor_bank_PhD
% function called with a downsampling factor of 1. The only difference here 
% is that this function returns a cell array with the compley responses 
% in image form (and no downsampling), while the filter_image_with_Gabor_bank_PhD
% function returns (potentially downsampled) magnitude reponses concatenated 
% into a large feature vector.
%
% 
% REFERENCES
% A good reference to phase congruency is Peter Kovesi's paper:
% 
% P. Kovesi, Image features from phase congruency, Videre: Journal of 
% Computer Vision Research, vol. 1, no. 3, pp. 1–26, 1999.
%
%
% INPUTS:
% X                     - an input grey-scale face image (obligatory
%                         argument)
% filter_bank           - a filter bank of coplex Gabor filters created
%                         using the construct_Gabor_filters_PhD function
%                         from the PhD toolbox (obligatory
%                         argument)
% nscale                - a scalar value determining the number of scales
%                         over which to compute phase congrunecy; note that
%                         this value can in general be smaller than the
%                         number of filter scales available in the 
%                         filter_bank structure; if no value is specified,
%                         the default (i.e., filter_bank.scales) is used 
%                         (optional parameter)
% 
% OUTPUTS:
% pc                    - a cell array of size 1 x no_of_orient; where 
%                         no_of_orient is the umber of orientations for
%                         which the phase congrunecy was computed; each
%                         entry in the array corresponds to the pahse
%                         congrunecy in a specific orinetation
% EO                    - a cell array of complex Gabor filter reponses of
%                         size (nscale x orentations); where nscale stands
%                         for the number of Gabor filter scales used in the 
%                         computation (see third input parameter) and 
%                         orentations stands for the number of filter
%                         orientations in the employed Gabor filter bank
%                         
%
% NOTES / COMMENTS
% The function is a modification of Peter Kovesis phase congruency
% function, which requires that the following part of the header is 
% included:
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References:
%
%     Peter Kovesi, "Image Features From Phase Congruency". Videre: A
%     Journal of Computer Vision Research. MIT Press. Volume 1, Number 3,
%     Summer 1999 http://mitpress.mit.edu/e-journals/Videre/001/v13.html
%
%     Peter Kovesi, "Phase Congruency Detects Corners and
%     Edges". Proceedings DICTA 2003, Sydney Dec 10-12
% 
% Copyright (c) 1996-2009 Peter Kovesi
% School of Computer Science & Software Engineering
% The University of Western Australia
% http://www.csse.uwa.edu.au/
% 
% Permission is hereby  granted, free of charge, to any  person obtaining a copy
% of this software and associated  documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% The software is provided "as is", without warranty of any kind.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% RELATED FUNCTIONS (SEE ALSO)
% filter_image_with_Gabor_bank_PhD
% construct_Gabor_filters_PhD
% 
% 
% ABOUT
% Created:        10.2.2010
% Last Update:    15.11.2011
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

function [pc,EO] = produce_phase_congruency_PhD(X,filter_bank,nscale);

%% Init 
pc = [];
EO = [];

%% Input parameter check

if(nargin<2)
    disp('The function requires at least two input argument.');
    return;
elseif(nargin >3)
    disp('The function takes at most three input arguments.');
    return;
elseif(nargin == 2)
    if(~isfield(filter_bank,{'spatial','freq','scales','orient'}))
        disp('The filter_bank argument needs to be created with the construct_Gabor_filters_PhD function');
        return;
    end
    nscale = filter_bank.scales;
elseif(nargin == 3)
    if(~isfield(filter_bank,{'spatial','freq','scales','orient'}))
        disp('The filter_bank argument needs to be created with the construct_Gabor_filters_PhD function');
        return;
    end
end


%% Main part

% get size
[aa,bb] = size(filter_bank.spatial{1,1});
start_y = round(aa/4);
start_x = round(bb/4);
[aaa,bbb] = size(X);
aaa=aaa-1;
bbb=bbb-1;

%get filter bank data
norient = filter_bank.orient;
fil = cell(filter_bank.scales,filter_bank.orient);
for i=1:filter_bank.scales
    for j=1:norient
        tmp = filter_bank.spatial{i,j};
        fil{i,j}= tmp(start_y:start_y+aaa,start_x:start_x+bbb);
    end
end


[rows,cols] = size(X);

image = zeros(2*rows,2*cols);
image(1:rows,1:cols)=X;
imagefft = fft2(image);

for j=1:nscale 
    for i=1:norient    
        Gabors1{j,i} = fil{j,i};
        fftGabors{j,i} = fil{j,i};
            
        Gabors1{j,i} = filter_bank.spatial{j,i};
        tmp = filter_bank.spatial{j,i};
        fftGabors1{j,i} = fft2(tmp);
    end
end


%fourier transform of the image
%imagefft = fft2(X);  
epsilon         = .0001;
zero = zeros(rows,cols);
totalEnergy = zero;               % Total weighted phase congruency values (energy).
totalSumAn  = zero;               % Total filter response amplitude values.
orientation = zero;               % Matrix storing orientation with greatest
                                  % energy for each pixel.
EO = cell(nscale, norient);       % Array of convolution results.                                 
covx2 = zero;                     % Matrices for covariance data
covy2 = zero;
covxy = zero;

estMeanE2n = [];
ifftFilterArray = cell(1,nscale); % Array of inverse FFTs of filters

%for each orientation
for or = 1:norient
   
  sumE_ThisOrient   = zero;          % Initialize accumulator matrices.
  sumO_ThisOrient   = zero;       
  sumAn_ThisOrient  = zero;      
  Energy            = zero;
  
  for sc = 1:nscale        
        
      filter1 = fftGabors1{sc,or};
      filter = fftGabors{sc,or};
      
      ifftFilt = real(ifft2(filter))*sqrt(rows*cols);  % Note rescaling to match power
      ifftFilterArray{sc} = ifftFilt;                   % record ifft2 of filter
        
        
      tmp = ifft2(imagefft .* filter1);
      EO{sc,or} = (tmp(rows+1:2*rows,cols+1:2*cols)); 
      
      An = abs(EO{sc,or});                         % Amplitude of even & odd filter response.
      sumAn_ThisOrient = sumAn_ThisOrient + An;  % Sum of amplitude responses.
      sumE_ThisOrient = sumE_ThisOrient + real(EO{sc,or}); % Sum of even filter convolution results.
      sumO_ThisOrient = sumO_ThisOrient + imag(EO{sc,or}); % Sum of odd filter convolution results.

      if sc==1                                 % Record mean squared filter value at smallest
         EM_n = sum(sum(abs(filter).^1));           % scale. This is used for noise estimation.
         maxAn = An;                           % Record the maximum An over all scales.
      else
         maxAn = max(maxAn, An);
      end     
  end

  XEnergy = sqrt(sumE_ThisOrient.^2 + sumO_ThisOrient.^2) + epsilon;   
  MeanE = sumE_ThisOrient ./ XEnergy; 
  MeanO = sumO_ThisOrient ./ XEnergy; 
%   imshow(MeanE,[])
%   figure
%   imshow(MeanO,[])
%   pause
  
  for sc = 1:nscale,       
      E = real(EO{sc,or}); O = imag(EO{sc,or});    % Extract even and odd
                                               % convolution results.
      Energy = Energy + E.*MeanE + O.*MeanO - abs(E.*MeanO - O.*MeanE);
  end
    
  medianE2n = median(reshape(abs(EO{1,or}).^2,1,rows*cols));
  meanE2n = -medianE2n/log(0.5);
  estMeanE2n(or) = meanE2n;

  noisePower = meanE2n/EM_n;                       % Estimate of noise power.

  EstSumAn2 = zero;
  for sc = 1:nscale
    EstSumAn2 = EstSumAn2 + ifftFilterArray{sc}.^2;
  end

  EstSumAiAj = zero;
  for si = 1:(nscale-1)
    for sj = (si+1):nscale
      EstSumAiAj = EstSumAiAj + ifftFilterArray{si}.*ifftFilterArray{sj};
    end
  end
  sumEstSumAn2 = sum(sum(EstSumAn2));
  sumEstSumAiAj = sum(sum(EstSumAiAj));

%  end % if o == 1

  EstNoiseEnergy2 = 2*noisePower*sumEstSumAn2 + 4*noisePower*sumEstSumAiAj;

  tau = sqrt(EstNoiseEnergy2/2);                     % Rayleigh parameter
  EstNoiseEnergy = tau*sqrt(pi/2);                   % Expected value of noise energy
  EstNoiseEnergySigma = sqrt( (2-pi/2)*tau^2 );
% whos EstNoiseEnergySigma EstNoiseEnergy
  k=2;
  T =  EstNoiseEnergy + k*EstNoiseEnergySigma;       % Noise threshold

  % The estimated noise effect calculated above is only valid for the PC_1 measure. 
  % The PC_2 measure does not lend itself readily to the same analysis.  However
  % empirically it seems that the noise effect is overestimated roughly by a factor 
  % of 1.7 for the filter parameters used here.

  T = T/1.7;        % Empirical rescaling of the estimated noise effect to 
                % suit the PC_2 phase congruency measure

  Energy = max(Energy - T, zero);          % Apply noise threshold
  
  
  cutOff=0.5;
  g=10;
  width = sumAn_ThisOrient ./ (maxAn + epsilon) / nscale; 
  weight = 1.0 ./ (1 + exp( (cutOff - width)*g));
  
  pc{or} = weight.*Energy./sumAn_ThisOrient;
end















