function [I Frames] = robustSR(s, delta_est, phi_est, factor)
% ROBUSTSR - Implementation of a robust superresolution technique from Assaf Zomet, Alex Rav-Acha and Shmuel Peleg 
%    s: images in cell array (s{1}, s{2},...)
%    delta_est(i,Dy:Dx) estimated shifts in y and x
%    phi_est(i) estimated rotation in reference to image number 1
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
% Latest modifications: November 6, 2006 by Karim Krichane

if nargout > 1
    outputFrames = true;
else
    outputFrames = false;
end

%% Movie variables
movieCounter = 1;
imOrigBig = imresize(s{1}, factor, 'nearest');
if(outputFrames)
    figure;
end
% -- End of Movie Variables

%% Initialization
lambda = 0.05; % define the step size for the iterative gradient method
max_iter = 50;
iter = 1;

% Start with an estimate of our HR image: we use an upsampled version of
% the first LR image as an initial estimate.
X = imOrigBig;
X_prev = X;
E = [];

%imshow(X);

%PSF = generatePSF([1 0 0], [1 2 1], X);
blur = [0 1 0;...
        1 2 1;...
        0 1 0];
blur = blur / sum(blur(:));

sharpen = [0 -0.25 0;...
          -0.25 2 -0.25;...
           0 -0.25 0];

wait_handle = waitbar(0, 'Reconstruction...', 'Name', 'SuperResolution GUI');

while iter < max_iter
    waitbar(min(5*iter/max_iter, 1), wait_handle);
    % Compute the gradient of the total squared error of reassembling the HR
    % image:
    % --- Save each movie frame ---
    if(outputFrames)
        imshow(X); title(num2str(iter));
        Frames(movieCounter) = getframe;
        movieCounter = movieCounter + 1;
    end
    % -----------------------------
    for i=1:length(s)
        temp = circshift(X, -[round(factor * delta_est(i,1)), round(factor * delta_est(i,2))]);
        temp = imrotate(temp, phi_est(i), 'crop');
        
        %temp = PSF * temp;
        temp = imfilter(temp, blur, 'symmetric');
        
        temp = temp(1:factor:end, 1:factor:end);
        temp = temp - s{i};
        temp = imresize(temp, factor, 'nearest');
        
        %temp = PSF' * temp;
        temp = imfilter(temp, sharpen, 'symmetric');
        
        temp = imrotate(temp, -phi_est(i), 'crop');
        G(:,:,i) = circshift(temp, [round(factor * delta_est(i,1)), round(factor * delta_est(i,2))]);
    end
    % Take the median of G, element by element
    M = median(G, 3);
    % Now that we have the median, we will go in its direction with a step
    % size of lambda
    X = X - length(s)*lambda * M;   
   
    delta = norm(X-X_prev)/norm(X);
    E=[E; iter delta];
    if iter>3 
      if abs(E(iter-3,2)-delta) <1e-4
         break  
      end
    end
    X_prev = X;
    iter = iter+1;
   
end

disp(['Ended after ' num2str(iter) ' iterations.']);
disp(['Final error is ' num2str(abs(E(iter-3,2)-delta)) ' .']);
%figure;
%imshow(X);
I = X;
close(wait_handle);