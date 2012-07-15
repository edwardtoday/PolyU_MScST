function s_low = lowpass(s,part)
% LOWPASS - low-pass filter an image by setting coefficients to zero in frequency domain
%    s_low = lowpass(s,part)
%    S is the input image
%    PART indicates the relative part of the frequency range [0 pi] to be kept

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

% set coefficients to zero
if size(s,1)>1 % 2D signal
    S = fft2(s); % compute the Fourier transform of the image
    S(round(part(1)*size(S,1))+1:round((1-part(1))*size(S,1))+1,:) = 0;
    S(:,round(part(2)*size(S,2))+1:round((1-part(2))*size(S,2))+1) = 0;
    s_low = real(ifft2(S)); % compute the inverse Fourier transform of the filtered image
else % 1D signal
    S = fft(s); % compute the Fourier transform of the image
    S(round(part*length(S))+1:round((1-part)*length(S))+1) = 0;
    s_low = real(ifft(S)); % compute the inverse Fourier transform of the filtered signal
end
