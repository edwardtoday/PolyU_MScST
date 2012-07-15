function delta_est = keren_shift(im)
% KEREN_SHIFT shift estimation using algorithm by Keren et al.
%    delta_est = keren_shift(im)
%    shift estimation algorithm implemented from the paper by Keren et al.

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

for imnr = 2:length(im)
    % construct pyramid scheme
    lp = fspecial('ga',5,1);
    im0{1} = im{1};
    im1{1} = im{imnr};
    for i=2:3
        im0{i} = imresize(conv2(im0{i-1},lp,'same'),0.5,'bicubic');
        im1{i} = imresize(conv2(im1{i-1},lp,'same'),0.5,'bicubic');
    end
    
    stot = zeros(1,2);
    % do actual registration, based on pyramid
    for pyrlevel=3:-1:1
        f0 = im0{pyrlevel};
        f1 = im1{pyrlevel};
        
        [y0,x0]=size(f0);
        xmean=x0/2; ymean=y0/2;
        sigma=1;
        x=kron([-xmean:xmean-1],ones(y0,1));
        y=kron(ones(1,x0),[-ymean:ymean-1]');
        g1 = zeros(y0,x0); g2 = g1; g3 = g1;
        for i=1:y0
            for j=1:x0
                g1(i,j)=-exp(-((i-ymean)^2+(j-xmean)^2)/2)*(i-ymean)/2/pi; % d/dy
                g2(i,j)=-exp(-((i-ymean)^2+(j-xmean)^2)/2)*(j-xmean)/2/pi; % d/dx
                g3(i,j)=exp(-((i-ymean)^2+(j-xmean)^2)/2)/2/pi;
            end
        end
        
        a=real(ifft2(fft2(f1).*fft2(g2))); % df1/dx
        c=real(ifft2(fft2(f1).*fft2(g1))); % df1/dy
        b=real(ifft2(fft2(f1).*fft2(g3)))-real(ifft2(fft2(f0).*fft2(g3))); % f1-f0
        A=[a(:) , c(:)];
        s=lsqlin(A,b(:)); 
        stot=s;
        
        while (abs(s(1))+abs(s(2))>0.05)
            f0_ = shift(f0,-stot(1),-stot(2));
            b = real(ifft2(fft2(f1).*fft2(g3)))-real(ifft2(fft2(f0_).*fft2(g3)));
            s=lsqlin(A,b(:));
            stot = stot+s;
        end
        stot = stot';
        stot(1:2) = stot(2:-1:1);
    end
    delta_est(imnr,:) = -stot;
end
