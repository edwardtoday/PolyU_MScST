function delta_est = marcel_shift(s,M)
% MARCEL_SHIFT shift estimation using algorithm by Marcel et al.
%    [delta_est, phi_est] = marcel(s,M)
%    motion estimation algorithm implemented from the paper by Marcel et al.
%    horizontal and vertical shifts DELTA_EST are estimated from the input 
%    images S (S{1},etc.). For the shift estimation, the Fourier transform 
%    images are interpolated by a factor M to increase precision.

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
%                       November 6, 2006 by Karim Krichane
                       

nr=length(s);
S = size(s{1});
if (nargin==1)
    M = 10; % magnification factor to have higher precision
end

phi_est = zeros(1,nr);
r_ref = S(1)/2/pi;
IMREF = fft2(s{1});
IMREF_C = abs(fftshift(IMREF));
IMREF_P = c2p(IMREF_C);
IMREF_P = IMREF_P(:,round(0.1*r_ref):round(1.1*r_ref)); % select only points with radius 0.1r_ref<r<1.1r_ref
IMREF_P_ = fft2(IMREF_P);
for i=2:nr
    % shift estimation
    IM = fft2(s{i});
    psi = IM./IMREF;
    PSI = fft2(psi,M*S(1),M*S(2));
    [m,ind] = max(PSI);
    [mm,iind] = max(m);
    delta_est(i,1) = (ind(iind)-1)/M;
    delta_est(i,2) = (iind-1)/M;
    if delta_est(i,1)>S(1)/2
        delta_est(i,1) = delta_est(i,1)-S(1);
    end
    if delta_est(i,2)>S(2)/2
        delta_est(i,2) = delta_est(i,2)-S(2);
    end
end
