function PSF = generatePSF(v, h, I)
% GENERATEPSF - generate a point spread function matrix
% This function generates a PSF (point spread function) matrix to use in a
% matrix multiplication (i.e. not a convolution) with the image I
% V is the vector containing the first non-zero values of the first column
% of the resulting Toeplitz matrix
% H is the vector containing the first non-zero values of the first line
% of the resulting Toeplitz matrix
% I is the image the PSF matrix is for (the resulting PSF matrix will thus
% have the same dimsensions as I)

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
% Latest modifications: November 6, 2006 by Karim Krichane

PSF = toeplitz([v zeros(1, size(I, 1)-length(v))], [h zeros(1, size(I, 2)-length(h))]);
PSF = PSF / (sum(v) + sum(h(2:end))); % normalization factor