function [delta_est, phi_est] = keren(im)
% KEREN - estimate shift and rotation parameters using Keren et al. algorithm
%    [delta_est, phi_est] = keren(im)

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
%                       February 2, 2006, by Patrick Vandewalle
%                          removed bug in implementation
%                       August 22, 2006, by Karim Krichane

for imnr = 2:length(im)
    % construct pyramid scheme
    lp = fspecial('ga',5,1);
    im0{1} = im{1};
    im1{1} = im{imnr};
    for i=2:3
        im0{i} = imresize(conv2(im0{i-1},lp,'same'),0.5,'bicubic');
        im1{i} = imresize(conv2(im1{i-1},lp,'same'),0.5,'bicubic');
    end
    
    stot = zeros(1,3);
    % do actual registration, based on pyramid
    for pyrlevel=3:-1:1
        f0 = im0{pyrlevel};
        f1 = im1{pyrlevel};
        
        [y0,x0]=size(f0);
        xmean=x0/2; ymean=y0/2;
        x=kron([-xmean:xmean-1],ones(y0,1));
        y=kron(ones(1,x0),[-ymean:ymean-1]');
        
        sigma=1;
        g1 = zeros(y0,x0); g2 = g1; g3 = g1;
        for i=1:y0
            for j=1:x0
                g1(i,j)=-exp(-((i-ymean)^2+(j-xmean)^2)/(2*sigma^2))*(i-ymean)/2/pi/sigma^2; % d/dy
                g2(i,j)=-exp(-((i-ymean)^2+(j-xmean)^2)/(2*sigma^2))*(j-xmean)/2/pi/sigma^2; % d/dx
                g3(i,j)= exp(-((i-ymean)^2+(j-xmean)^2)/(2*sigma^2))/2/pi/sigma^2;
            end
        end
        
        a=real(ifft2(fft2(f1).*fft2(g2))); % df1/dx, using circular convolution
        c=real(ifft2(fft2(f1).*fft2(g1))); % df1/dy, using circular convolution
        b=real(ifft2(fft2(f1).*fft2(g3)))-real(ifft2(fft2(f0).*fft2(g3))); % f1-f0
        R=c.*x-a.*y; % df1/dy*x-df1/dx*y
        
        a11 = sum(sum(a.*a)); a12 = sum(sum(a.*c)); a13 = sum(sum(R.*a));
        a21 = sum(sum(a.*c)); a22 = sum(sum(c.*c)); a23 = sum(sum(R.*c)); 
        a31 = sum(sum(R.*a)); a32 = sum(sum(R.*c)); a33 = sum(sum(R.*R));
        b1 = sum(sum(a.*b)); b2 = sum(sum(c.*b)); b3 = sum(sum(R.*b));
        Ainv = [a11 a12 a13; a21 a22 a23; a31 a32 a33]^(-1);
        s = Ainv*[b1; b2; b3];
        st = s;
        
        it=1;
        while ((abs(s(1))+abs(s(2))+abs(s(3))*180/pi/20>0.1)&it<25)
            % first shift and then rotate, because we treat the reference image
            f0_ = shift(f0,-st(1),-st(2));
            f0_ = imrotate(f0_,-st(3)*180/pi,'bicubic','crop');
            b = real(ifft2(fft2(f1).*fft2(g3)))-real(ifft2(fft2(f0_).*fft2(g3)));
            s = Ainv*[sum(sum(a.*b)); sum(sum(c.*b)); sum(sum(R.*b))];
            st = st+s;
            it = it+1;
        end
        % it
        
        st(3)=-st(3)*180/pi;
        st = st';
        st(1:2) = st(2:-1:1);
        stot = [2*stot(1:2)+st(1:2) stot(3)+st(3)];
        if pyrlevel>1
            % first rotate and then shift, because this is cancelling the
            % motion on the image to be registered
            im1{pyrlevel-1} = imrotate(im1{pyrlevel-1},-stot(3),'bicubic','crop');
            im1{pyrlevel-1} = shift(im1{pyrlevel-1},2*stot(2),2*stot(1)); % twice the parameters found at larger scale
        end
    end
    phi_est(imnr) = stot(3);
    delta_est(imnr,:) = stot(1:2);
end