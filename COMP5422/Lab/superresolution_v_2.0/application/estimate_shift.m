function delta_est = estimate_shift(s,n)
% ESTIMATE_SHIFT - shift estimation using algorithm by Vandewalle et al.
%    delta_est = estimate_shift(s,n)
%    estimate shift between every image and the first (reference) image
%    N specifies the number of low frequency pixels to be used
%    input images S are specified as S{1}, S{2}, etc.
%    DELTA_EST is an M-by-2 matrix with M the number of images

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

h = waitbar(0, 'Shift Estimation');
set(h, 'Name', 'Please wait...');

nr = length(s);
delta_est=zeros(nr,2);
p = [n n]; % only the central (aliasing-free) part of NxN pixels is used for shift estimation
sz = size(s{1});
S1 = fftshift(fft2(s{1})); % Fourier transform of the reference image
for i=2:nr
  waitbar(i/nr, h, 'Shift Estimation');
  S2 = fftshift(fft2(s{i})); % Fourier transform of the image to be registered
  S2(S2==0)=1e-10;
  Q = S1./S2;
  A = angle(Q); % phase difference between the two images

  % determine the central part of the frequency spectrum to be used
  beginy = floor(sz(1)/2)-p(1)+1;
  endy = floor(sz(1)/2)+p(1)+1;
  beginx = floor(sz(2)/2)-p(2)+1;
  endx = floor(sz(2)/2)+p(2)+1;
  
  % compute x and y coordinates of the pixels
  x = ones(endy-beginy+1,1)*[beginx:endx];
  x = x(:);
  y = [beginy:endy]'*ones(1,endx-beginx+1);
  y = y(:);
  v = A(beginy:endy,beginx:endx);
  v = v(:);

  % compute the least squares solution for the slopes of the phase difference plane
  M_A = [x y ones(length(x),1)];
  r = M_A\v;
  delta_est(i,:) = -[r(2) r(1)].*sz/2/pi;
end

close(h);