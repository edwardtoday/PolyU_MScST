function [rot_angle, c] = estimate_rotation(a,dist_bounds,precision)
% ESTIMATE_ROTATION - rotation estimation using algorithm by Vandewalle et al.
%    [rot_angle, c] = estimate_rotation(a,dist_bounds,precision)
%    DIST_BOUNDS gives the minimum and maximum radius to be used
%    PRECISION gives the precision with which the rotation angle is computed
%    input images A are specified as A{1}, A{2}, etc.

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
%                       November 6, 2006 by Karim Krichane and Ali Ajdari Rad

h = waitbar(0, 'Rotation Estimation');
set(h, 'Name', 'Please wait...');

nr = length(a); % number of inputs
d = 1*pi/180; % width of the angle over which the average frequency value is computed
s = size(a{1})/2;
center = [floor(s(1))+1 floor(s(2))+1]; % center of the image and the frequency domain matrix
x = ones(s(1)*2,1)*[-1:1/s(2):1-1/s(2)]; % X coordinates of the pixels
y = [-1:1/s(1):1-1/s(1)]'*ones(1,s(2)*2); % Y coordinates of the pixels
x = x(:);
y = y(:);
[th,ra] = cart2pol(x,y); % polar coordinates of the pixels

%***********************************************************
DB = (ra>dist_bounds(1))&(ra<dist_bounds(2));
%***********************************************************
th(~DB) = 1000000;
[T, ix] = sort(th); % sort the coordinates by angle theta

st = length(T);

%% compute the average value of the fourier transform for each segment
I = -pi:pi*precision/180:pi;
J = round(I/(pi*precision/180))+180/precision+1;
for k = 1:nr
    waitbar(k/(2*nr), h, 'Rotation Estimation');
    A{k} = fftshift(abs(fft2(a{k}))); % Fourier transform of the image
    ilow = 1;
    ihigh = 1;
    ik = 1;
    for i = 1:length(I)
        ik = ilow;
        while(I(i)-d > T(ik))
            ik = ik + 1;
        end;

        ilow = ik;
        ik = max(ik, ihigh);
        while(T(ik) < I(i)+d)
            ik = ik + 1;
            if (ik > st | T(ik) > 1000)
                break;
            end;
        end;
        ihigh = ik;
        if ihigh-1 > ilow
            h_A{k}(J(i)) = mean(A{k}(ix(ilow:ihigh-1)));
        else
            h_A{k}(J(i)) = 0;
        end
    end;
    v = h_A{k}(:) == NaN;
    h_A{k}(v) = 0;
end

% compute the correlation between h_A{1} and h_A{2-4} and set the estimated rotation angle 
% to the maximum found between -30 and 30 degrees
H_A = fft(h_A{1});
rot_angle(1) = 0;
c{1} = [];
for k = 2:nr
  H_Binv = fft(h_A{k}(end:-1:1));
  H_C = H_A.*H_Binv;
  h_C = real(ifft(H_C));
  [m,ind] = max(h_C(150/precision+1:end-150/precision));
  rot_angle(k) = (ind-30/precision-1)*precision;
  c{k} = h_C;
end

close(h);
