function [s, ground_truth] = create_images(im,delta,phi,scale,nr,snr)
% CREATE_IMAGES - generate low resolution shifted and rotated images
%    [s, ground_truth] = create_images(im,delta,phi,scale,nr,snr)
%    create NR low resolution images from a high resolution image IM,
%    with shifts DELTA (multiples of 1/8) and rotation angles PHI (degrees)
%    the low resolution images have a factor SCALE less pixels
%    in both dimensions than the input image IM
%    if SNR is specified, noise is added to the different images to obtain
%    the given SNR value

%% -----------------------------------------------------------------------
% SUPERRESOLUTION - Graphical User Interface for Super-Resolution Imaging
% Copyright (C) 2005-2007 Laboratory of Audiovisual Communications (LCAV), 
% Ecole Polytechnique Federale de Lausanne (EPFL), 
% CH-1015 Lausanne, Switzerland 
% 
% This program is free software; you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the 
% Free Software Foundation; either version 2 of the License, or (at your 
% option) any later version. This software is distributed in the hope that 
% it will be useful, but without any warranty; without even the implied 
% warranty of merchantability or fitness for a particular purpose. 
% See the GNU General Public License for more details 
% (enclosed in the file GPL). 
%
% Latest modifications: January 12, 2006, by Patrick Vandewalle

im=resample(im,2,1)'; % upsample the image by 2
im=resample(im,2,1)';
for i=2:nr
    im2{i} = shift(im,-delta(i,2)*2*scale,-delta(i,1)*2*scale); % shift the images by integer pixels
    if (phi(i) ~= 0)
      im2{i} = imrotate(im2{i},phi(i),'bicubic','crop'); % rotate the images
    end
end
im2{1} = im; % the first image is not shifted or rotated

for i=1:nr
    im2{i} = lowpass(im2{i},[0.12 0.12]); % low-pass filter the images
                                            % such that they satisfy the conditions specified in the paper
                                            % a small aliasing-free part of the frequency domain is needed
    if (i==1) % construct ground truth image as reconstruction target
     ground_truth=downsample(im2{i},4)';
     ground_truth=downsample(ground_truth,4)';
    end
    im2{i} = downsample(im2{i},2*scale)'; % downsample the images by 8
    im2{i} = downsample(im2{i},2*scale)';
end

% add noise to the images (if an SNR was specified)
if (nargin==6)
  for i=1:nr
    S = size(im2{i});
    n = randn(S(1),S(2));
    n = sqrt(sum(sum(im2{i}.*im2{i}))/sum(sum(n.*n)))*10^(-snr/20)*n;
    s{i} = im2{i}+n;
    %snr = 10*log10(sum(sum(im2{i}.*im2{i}))/sum(sum(n.*n)))
  end
else
  s=im2;
end
