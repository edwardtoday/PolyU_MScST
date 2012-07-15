function impolar = c2p(im)
% IMPOLAR - compute the polar coordinates of the pixels of an image
%    impolar = c2p(im)
%    convert an image in cartesian coordinates IM
%    to an image in polar coordinates IMPOLAR

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

[nrows, ncols] = size(im);

% create the regular rho,theta grid
r = ones(nrows,1)*[0:nrows-1]/2;
th = [0:nrows-1]'*ones(nrows,1)'*2*pi/nrows-pi;

% convert the polar coordinates to cartesian
[xx,yy] = pol2cart(th,r);
xx = xx + nrows/2+0.5;
yy = yy + nrows/2+0.5;

% interpolate using bilinear interpolation to produce the final image
partx = xx-floor(xx); partx = partx(:);
party = yy-floor(yy); party = party(:);

impolar = (1-partx).*(1-party).*reshape(im(floor(yy)+nrows*(floor(xx)-1)),[nrows*ncols 1])...
    + partx.*(1-party).*reshape(im(floor(yy)+nrows*(ceil(xx)-1)),[nrows*ncols 1])...
    + (1-partx).*party.*reshape(im(ceil(yy)+nrows*(floor(xx)-1)),[nrows*ncols 1])...
    + partx.*party.*reshape(im(ceil(yy)+nrows*(ceil(xx)-1)),[nrows*ncols 1]);

impolar = reshape(impolar,[nrows ncols]);
