function [delta_est, phi_est] = estimate_motion(s,r_max,d_max)
% ESTIMATE_MOTION - shift and rotation estimation using algorithm by Vandewalle et al.
%    [delta_est, phi_est] = estimate_motion(s,r_max,d_max)
%    R_MAX is the maximum radius in the rotation estimation
%    D_MAX is the number of low frequency components used for shift estimation
%    input images S are specified as S{1}, S{2}, etc.

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

if (nargin==1) % default values
   r_max = 0.8;
   d_max = 8;
end

% rotation estimation
[phi_est, c_est] = estimate_rotation(s,[0.1 r_max],0.1);

% rotation compensation, required to estimate shifts
s2{1} = s{1};
nr=length(s);
for i=2:nr
    s2{i} = imrotate(s{i},-phi_est(i),'bicubic','crop');
end

% shift estimation
delta_est = estimate_shift(s2,d_max);


