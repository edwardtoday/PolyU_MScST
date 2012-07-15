% SUPERRESOLUTION - Graphical User Interface for Super-Resolution Imaging
% This program allows a user to perform registration of a set of low 
% resolution input images and reconstruct a high resolution image from them.
% Multiple image registration and reconstruction methods have been
% implemented. As input, the user can either select existing images, or 
% generate a set of simulated low resolution images from a high resolution 
% image. 
% More information is available online:
% http://lcavwww.epfl.ch/software/superresolution
% If you use this software for your research, please also put a reference
% to the related paper 
% "A Frequency Domain Approach to Registration of Aliased Images            
% with Application to Super-Resolution"                                     
% Patrick Vandewalle, Sabine Susstrunk and Martin Vetterli                  
% available at http://lcavwww.epfl.ch/reproducible_research/VandewalleSV05/ 

% v 1.0 - January 12, 2006 by Patrick Vandewalle, Patrick Zbinden and Cecilia Perez
% v 2.0 - November 6, 2006 by Patrick Vandewalle and Karim Krichane

%% -----------------------------------------------------------------------
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

% Graphical User Interfaces
%   superresolution   - main program
%   generation        - generate a set of low resolution shifted and 
%                       rotated images from a single input image
%
% Image Registration
%   estimate_motion   - shift and rotation estimation using algorithm 
%                       by Vandewalle et al.
%   estimate_rotation - rotation estimation using algorithm by Vandewalle et al.
%   estimate_shift    - shift estimation using algorithm by Vandewalle et al.
%   keren             - estimate shift and rotation parameters 
%                       using Keren et al. algorithm
%   keren_shift       - estimate shift parameters using Keren et al. algorithm
%   lucchese          - estimate shift and rotation parameters 
%                       using Lucchese and Cortelazzo algorithm
%   marcel            - estimate shift and rotation parameters 
%                       using Marcel et al. algorithm
%   marcel_shift      - estimate shift parameters using Marcel et al. algorithm
%
% Image Reconstruction
%   interpolation     - reconstruct a high resolution image from a set of 
%                       low resolution images and their registration parameters
%                       using bicubic interpolation
%   iteratedbackprojection - reconstruct a high resolution image from a set of 
%                       low resolution images and their registration parameters
%                       using iterated backprojection
%   n_conv (and n_convolution) - reconstruct a high resolution image from a set
%                       of low resolution images and their registration parameters
%                       using algorithm by Pham et al.
%   papoulisgerchberg - reconstruct a high resolution image from a set of 
%                       low resolution images and their registration parameters
%                       using algorithm by Papoulis and Gerchberg
%   pocs              - reconstruct a high resolution image from a set of 
%                       low resolution images and their registration parameters
%                       using POCS (projection onto convex sets) algorithm
%   robustSR          - reconstruct a high resolution image from a set of 
%                       low resolution images and their registration parameters
%                       using robust super-resolution algorithm by Zomet et al.
%
% Helper Functions
%   applicability     - compute the applicability function in normalized 
%                       convolution method
%   c2p               - compute the polar coordinates of the pixels of an image
%   create_images     - generate low resolution shifted and rotated images
%                       from a single high resolution input image
%   generate_PSF      - generate the point spread function (PSF) matrix
%   lowpass           - low-pass filter an image by setting coefficients 
%                       to zero in frequency domain
%   robustnorm2       - function used in normalized convolution reconstruction
%   shift             - shift an image over a non-integer amount of pixels
