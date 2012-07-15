function [Z X Y] = applicability(a, b, rmax)
% APPLICABILITY - generate an applicability function used in normalized convolution
% Z is the applicability matrix and X, Y are the grid coordinates if a 3D
% plot is required.

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

[X Y] = meshgrid(-rmax:rmax, -rmax:rmax);

Z = sqrt(X.^2+Y.^2).^(-a).*cos((pi*sqrt(X.^2+Y.^2))/(2*rmax)).^b;
Z = Z .* double(sqrt(X.^2+Y.^2) < rmax); % We want Z=0 outside of rmax
Z(rmax+1, rmax+1) = 1;