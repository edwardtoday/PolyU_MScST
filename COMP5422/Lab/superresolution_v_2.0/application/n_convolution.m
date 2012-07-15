function [rec, Frames] = n_convolution(cols,rows,values,ss,factor, imOrig, noiseCorrect, TwoPass)
% NORMALIZEDCONVOLUTION - reconstruct high resolution image using normalized convolution algorithm
%    [rec, Frames] = n_convolution(cols,rows,values,ss,factor, imOrig, noiseCorrect, TwoPass)
%    reconstruct an image with FACTOR times more pixels in both dimensions
%    using normalized convolution and using the shift and rotation 
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

% %% LITTLE TEST CODE TO SEE DIFFERENT APPLICABILITY FUNCTIONS
% n=8; %work with basis matrices of size 2n+1 by 2n+1
% [X, Y] = meshgrid(-n:n, -n:n);
% I = ones(2*n+1);
% x = X;
% y = Y;
% x2 = X.^2;
% y2 = Y.^2;
% xy = X.*Y;
% alphas = [0 1 2];
% betas = [0 0.5 1 1.5 2 2.5];
% for i = 1:length(alphas)
%     figure('name', ['a = ' num2str(alphas(i))], 'NumberTitle', 'off');
%     for j = 1:length(betas)
%         subplot(2,3,j);
%         a = applicability(i,j,n);
%         surf(x,y,a); title(['b=' num2str(betas(j))]);
%     end
% end
% %% ---------------------------------------------------


%% Initialization
%set outputFrames to true if you need every frame of the process as an output. This is
%useful for creating a movie showing the effect of the HR processing.
wait_handle = waitbar(0.5, 'Initialization...', 'Name', 'SuperResolution GUI');
if nargout > 1
    outputFrames = true;
else
    outputFrames = false;
end

if nargin < 6
    errordlg('Not enough input arguments', 'Error...');
elseif nargin == 6
    noiseCorrect = false;
    TwoPass = false;
end

rec = zeros(ss);

%By default, all certainties are set to 1
certainty = ones(length(rows),1);

%Parameters for the applicability function
alpha = 2;
beta = 2;
r_max = 4; %radius of the filters used in the convolution
% -- End of initialization


%% Certainty optimization for noise robustness

if noiseCorrect %optional noise cancelation

    values_hat = zeros(length(rows),1);
    sigma_noise = 1;
    numRows = length(rows);
    waitbar(0, wait_handle, 'Certainty Optimization');

    for k = 1:numRows
        waitbar(k/numRows, wait_handle);
        i = rows(k);
        j = cols(k);
        q11coord = find(abs(i-rows) <= r_max);
        rows_temp = rows(q11coord);
        cols_temp = cols(q11coord);
        values_temp = values(q11coord);
        certainty_temp = certainty(q11coord);
        coord_temp = find(abs(j-cols_temp) <= r_max);
        %         if(length(coord_temp)<1)
        %             length(coord_temp)
        %         end
        x_temp = rows_temp(coord_temp);
        y_temp = cols_temp(coord_temp);
        dx = abs(i - x_temp);
        dy = abs(j - y_temp);
        r = sqrt(dx.^2 + dy.^2); %distance from (i,j) to every other point of interest (x,y)
        a = r.^(-alpha).*cos((pi*r)/(2*r_max)).^beta; %applicability function
        a(isinf(a))=1;

        %basis functions
        B = zeros(length(dx), 6);
        B(:,1) = ones(length(dx),1);
        B(:,2) = x_temp - i; %x
        B(:,3) = y_temp - j; %y
        B(:,4) = dx.^2; %x^2
        B(:,5) = B(:,2).*B(:,3); %xy
        B(:,6) = dy.^2; %y^2

        F = values_temp(coord_temp);
        C = certainty_temp(coord_temp);
        W = diag(C.*a);
        % -- Optimization of the built-in pinv function --
        %       t = pinv(B' * W * B) * B' * W * F;
        [u,s,v]=svd(B'*W*B);
        %invert singular values only if they're greater than an epsylon
        if(s(1,1)>1e-5)
            s(1,1)=1./s(1,1);
            if(s(2,2)>1e-5)
                s(2,2)=1./s(2,2);
                if(s(3,3)>1e-5)
                    s(3,3)=1./s(3,3);
                    if(s(4,4)>1e-5)
                        s(4,4)=1./s(4,4);
                        if(s(5,5)>1e-5)
                            s(5,5)=1./s(5,5);
                            if(s(6,6)>1e-5)
                                s(6,6)=1./s(6,6);
                            end
                        end
                    end
                end
            end
        end
        pin = u*s*v';
        t = pin * B' * W * F;
        % -- End of pinv optimization -------
        values_hat(k) = t(1);

    end %k

    certainty = robustnorm2(values, values_hat, sigma_noise);
    certainty = certainty > 0.98;

end %if
% -- End of certainty optimization

%% Movie variables
movieCounter = 1;
imOrigBig = imresize(imOrig, factor, 'nearest');
rec = imOrigBig;
if(outputFrames)
    figure;
end
% -- End of Movie Variables

%% HR Reconstruction using normalized convolution
waitbar(0, wait_handle, 'HR Reconstruction (1st pass)');
for i = 1:ss(1) %For all lines of the HR image...
    waitbar(i/ss(1), wait_handle);
    q11coord = find(abs(i-rows) <= r_max);
    rows_temp = rows(q11coord);
    cols_temp = cols(q11coord);
    values_temp = values(q11coord);
    certainty_temp = certainty(q11coord);
    % --- Save each movie frame ---
    if(outputFrames)
        imshow(rec);
        Frames(movieCounter) = getframe;
        movieCounter = movieCounter + 1;
    end
    % -----------------------------
    for j = 1:ss(2) %For all columns of the HR image...
      
        coord_temp = find(abs(j-cols_temp) <= r_max);
%         if(length(coord_temp)<1)
%             length(coord_temp)
%         end
        x_temp = rows_temp(coord_temp);
        y_temp = cols_temp(coord_temp);
        dx = abs(i - x_temp);
        dy = abs(j - y_temp);
        r = sqrt(dx.^2 + dy.^2); %distance from (i,j) to every other point of interest (x,y)
        a = r.^(-alpha).*cos((pi*r)/(2*r_max)).^beta; %applicability function
        a(isinf(a))=1;
        
        %basis functions
        B = zeros(length(dx), 6);
        B(:,1) = ones(length(dx),1);
        B(:,2) = x_temp - i; %x
        B(:,3) = y_temp - j; %y
        B(:,4) = dx.^2; %x^2
        B(:,5) = B(:,2).*B(:,3); %xy
        B(:,6) = dy.^2; %y^2
        
        F = values_temp(coord_temp);
        C = certainty_temp(coord_temp);
        W = diag(C.*a);
        % -- Optimization of the built-in pinv function --
%       t = pinv(B' * W * B) * B' * W * F;
        [u,s,v]=svd(B'*W*B);
        %invert singular values only if they're greater than an epsylon
        if(s(1,1)>1e-5)
            s(1,1)=1./s(1,1);
            if(s(2,2)>1e-5)
                s(2,2)=1./s(2,2);
                if(s(3,3)>1e-5)
                    s(3,3)=1./s(3,3);
                    if(s(4,4)>1e-5)
                        s(4,4)=1./s(4,4);
                        if(s(5,5)>1e-5)
                            s(5,5)=1./s(5,5);
                            if(s(6,6)>1e-5)
                                s(6,6)=1./s(6,6);
                            end
                        end
                    end
                end
            end
        end
        pin = u*s*v';
        t = pin * B' * W * F; 
        % -- End of pinv optimization -------
        rec(i,j) = t(1);
        
        
    end %j
end %i
% -- End of HR Reconstruction


%% Structure-Adaptive Normalized Convolution
% This final processing is done as a second pass, only on pixels that have
% a high anisotropy

if TwoPass % optional second pass, which will sharpen all edges

    derivY = [0 0 0;...
        -1 0 1;...
        0 0 0];

    derivX = [0 -1 0;...
        0 0 0;...
        0 1 0];

    gaussFilter = gausswin(7)*gausswin(7)';
    gaussFilter = gaussFilter(2:6, 2:6);
    gaussFilter = gaussFilter / sum(gaussFilter(:));
    Ix = (imfilter(rec, derivX, 'symmetric'));
    Iy = (imfilter(rec, derivY, 'symmetric'));
    Ix2 = Ix .^ 2;
    Iy2 = Iy .^ 2;
    IxIy = Ix .* Iy;
    Ix2 = imfilter(Ix2, gaussFilter, 'symmetric');
    Iy2 = imfilter(Iy2, gaussFilter, 'symmetric');
    IxIy = imfilter(IxIy, gaussFilter, 'symmetric');


    % Creation of the density image. To create it, the certainty of each
    % irregular sample is split to its four nearest HR grid points in a
    % bilinear-weighting fashion.
    D = zeros(ss);
    for k = 1:length(values)
        x_temp = rows(k);
        y_temp = cols(k);
        c_temp = certainty(k);
        x1 = floor(x_temp);
        x2 = x1 + 1;
        y1 = floor(y_temp);
        y2 = y1 + 1;
        p = y_temp - y1;
        q = x_temp - x1;

        D(max(min(x1, ss(1)), 1), max(min(y1, ss(2)), 1)) = ...
            D(max(min(x1, ss(1)), 1), max(min(y1, ss(2)), 1)) + (1-p)*(1-q)*c_temp;

        D(max(min(x1, ss(1)), 1), max(min(y2, ss(2)), 1)) = ...
            D(max(min(x1, ss(1)), 1), max(min(y2, ss(2)), 1)) + p*(1-q)*c_temp;

        D(max(min(x2, ss(1)), 1), max(min(y1, ss(2)), 1)) = ...
            D(max(min(x2, ss(1)), 1), max(min(y1, ss(2)), 1)) + (1-p)*q*c_temp;

        D(max(min(x2, ss(1)), 1), max(min(y2, ss(2)), 1)) = ...
            D(max(min(x2, ss(1)), 1), max(min(y2, ss(2)), 1)) + p*q*c_temp;

    end %k
    % -- End of density image creation

    % Scale-space responses
    i_try = [];
    for i = -1:0.1:3
        i_try = [i_try i];
    end


    SSR = zeros(ss(1),ss(2),length(i_try));
    for i = 1:length(i_try)
        SSR(:,:,i) = imfilter(D, gausswin(5, 2^(-2*i_try(i)))*gausswin(5, 2^(-2*i_try(i)))'); %Filter with a gaussian of sigma 2^i
    end %i

    [x i_opt] = min(abs(3-SSR), [], 3);
    sigma_c = 2.^i_try(i_opt);
    % -- End of scale-space responses

    waitbar(0, wait_handle, 'Structure-Adaptive reconstruction (2nd pass)');
    % Reconstruction process
    r_max = 4; %redefine a new r_max now that the applicability function will be oriented
    A = zeros(ss);
    phi = zeros(ss);

    %rec = imOrigBig;

    for i = 1:ss(1) %For all lines of the HR image...
        waitbar(i/ss(1), wait_handle);
        q11coord = find(abs(i-rows) <= r_max);
        rows_temp = rows(q11coord);
        cols_temp = cols(q11coord);
        values_temp = values(q11coord);
        certainty_temp = certainty(q11coord);
        % --- Save each movie frame ---
        if(outputFrames)
            imshow(rec);
            Frames(movieCounter) = getframe;
            movieCounter = movieCounter + 1;
        end
        % -----------------------------
        for j = 1:ss(2) %For all columns of the HR image...
            tempMat = [Ix2(i,j) IxIy(i,j); IxIy(i,j) Iy2(i,j)];
            [v, d] = eig(tempMat);
            %         if(d(1,1) ~= 0)
            %             [d(1,1) d(2,2)]
            %         end
            %[i j]
            %         if(d(1,1)==0 && d(2,2)==0)
            %             disp(['all eig values zero: ' num2str(i) ' ' num2str(j)]);
            %         end



            if(abs(d(1,1)) >= abs(d(2,2)))
                lambda1 = d(1,1);
                lambda2 = d(2,2);
                vp1 = v(:,1);
            else
                lambda1 = d(2,2);
                lambda2 = d(1,1);
                vp1 = v(:,2);
            end

            if(abs(lambda1)>0.00001)
                if(vp1(1) ~= 0)
                    phi(i,j) = atan(vp1(2)/vp1(1));
                    %phi(i,j) = pi-pi/6;
                else
                    phi(i,j) = atan(Inf);
                    %phi(i,j) = pi-pi/6;
                end

                A(i,j) = (lambda1 - lambda2)/(lambda1 + lambda2);
            else
                phi(i,j) = 0;
                A(i,j) = 0;
            end

            %phi(i,j) = - phi(i,j) - pi/2;
            %phi(i,j) = pi/2;
            %phi(i,j) = (-(phi(i,j)+pi/4)) + pi/4;

            if(A(i,j)<0)
                disp('Problem! Negative anisotropy...')
            end

            if(A(i,j)>0.5) %Only do the second pass where the anisotropy is high

                coord_temp = find(abs(j-cols_temp) <= r_max);
                %         if(length(coord_temp)<1)
                %             length(coord_temp)
                %         end
                x_temp = rows_temp(coord_temp);
                y_temp = cols_temp(coord_temp);
                dx = x_temp - i;
                dy = y_temp - j;
                %r = sqrt(dx.^2 + dy.^2); %distance from (i,j) to every other point of interest (x,y)
                alpha_T = 0.5; %Tuning parameter to set an upper-bound on the eccentricity of the applicability function
                sigma_u = (alpha_T/(alpha_T+A(i,j))) * 3 * sigma_c(i,j);
                sigma_v = ((alpha_T+A(i,j))/alpha_T) * 3 * sigma_c(i,j);
                a = exp( ...
                    -( (dx.*cos(phi(i,j)) + dy.*sin(phi(i,j))) ./ sigma_u ).^2 ...
                    -( (-dx.*sin(phi(i,j)) + dy.*cos(phi(i,j))) ./ sigma_v ).^2 ...
                    );%Structure-adaptive applicability function
                %             a(isinf(a))=1;
                %             a(isnan(a))=0;
                %a = a > 0.6;

                %basis functions
                B = zeros(length(dx), 6);
                B(:,1) = ones(length(dx),1);
                B(:,2) = x_temp - i; %x
                B(:,3) = y_temp - j; %y
                B(:,4) = dx.^2; %x^2
                B(:,5) = B(:,2).*B(:,3); %xy
                B(:,6) = dy.^2; %y^2

                F = values_temp(coord_temp);
                C = certainty_temp(coord_temp);
                W = diag(C.*a);
                % -- Optimization of the built-in pinv function --
                %       t = pinv(B' * W * B) * B' * W * F;
                [u,s,v]=svd(B'*W*B);
                %invert singular values only if they're greater than an epsylon
                if(s(1,1)>1e-5)
                    s(1,1)=1./s(1,1);
                    if(s(2,2)>1e-5)
                        s(2,2)=1./s(2,2);
                        if(s(3,3)>1e-5)
                            s(3,3)=1./s(3,3);
                            if(s(4,4)>1e-5)
                                s(4,4)=1./s(4,4);
                                if(s(5,5)>1e-5)
                                    s(5,5)=1./s(5,5);
                                    if(s(6,6)>1e-5)
                                        s(6,6)=1./s(6,6);
                                    end
                                end
                            end
                        end
                    end
                end
                pin = u*s*v';
                t = pin * B' * W * F;
                % -- End of pinv optimization -------
                rec(i,j) = t(1);
                %[i j]
                %dbstop if i=34 && j==55;
            end %if

        end %j
    end %i

end %if
% -- End of Reconstruction process

% -- End of Structure-Adaptive Normalized Convolution


close(wait_handle);


%% Final adjustments
if(outputFrames == false)
    Frames = [];
end

