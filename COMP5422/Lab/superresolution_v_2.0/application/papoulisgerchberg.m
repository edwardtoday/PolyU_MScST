function rec = papoulisgerchberg(s,delta_est,factor)
% PAPOULISGERCHBERG - reconstruct high resolution image using Papoulis Gerchberg algorithm
%    rec = papoulisgerchberg(s,delta_est,factor)
%    reconstruct an image with FACTOR times more pixels in both dimensions
%    using Papoulis Gerchberg algorithm and using the shift and rotation 
%    information from DELTA_EST and PHI_EST
%    in:
%    s: images in cell array (s{1}, s{2},...)
%    delta_est(i,Dy:Dx) estimated shifts in y and x
%    factor: gives size of reconstructed image

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
% Written by Karim Krichane, August 2006

max_iter = 25;

temp = upsample(upsample(s{1}, factor)', factor)';
y = zeros(size(temp));
coord = find(temp);
y(coord) = temp(coord);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% construction of zero_cols, zero_rows
% factor_size_FFT is introduced in case that
% in PG2D the size of the FFT2 is increased
% fft2(y,factor_size_FFT*N(1),factor_size_FFT*N(2))
% !!! see if borders to be included or not!!!
NHR = size(temp);
NLR = floor(sqrt(length(s))*size(s{1})/2)*2;
zero_rows = (1+NLR(1)/2+1)-1:(NHR(1)-NLR(1)/2-1)+1;
zero_cols = (1+NLR(2)/2+1)-1:(NHR(2)-NLR(2)/2-1)+1;


for i = length(s):-1:1
    temp = upsample(upsample(s{i}, factor)', factor)';
    temp = shift(temp, round(delta_est(i, 2)*factor), round(delta_est(i, 1)*factor));
    coord = find(temp);
    y(coord) = temp(coord);
end
   
y_prev=y;

E=[];
iter=1;


wait_handle = waitbar(0, 'Reconstruction...', 'Name', 'SuperResolution GUI');
while iter < max_iter
   waitbar(min(4*iter/max_iter, 1), wait_handle);
   Y=fft2(y);
   Y(zero_rows,:)=0;
   Y(:,zero_cols)=0;
   y=ifft2(Y);
   
   for i = length(s):-1:1
        temp = upsample(upsample(s{i}, factor)', factor)';
        temp = shift(temp, round(delta_est(i, 2)*factor), round(delta_est(i, 1)*factor));
        coord = find(temp);
        y(coord) = temp(coord);
   end
   
   delta= norm(y-y_prev)/norm(y);
   E=[E; iter delta];
   iter= iter+1;
   if iter>3 
     if abs(E(iter-3,2)-delta) <1e-8
        break  
     end
   end
   y_prev=y;
%    if mod(iter,10)==2
%        disp(['iteration ' int2str(E(iter-1,1)) ', error ' num2str(E(iter-1,2))])
%    end
end

close(wait_handle);
% reconstructed image
rec = real(y);