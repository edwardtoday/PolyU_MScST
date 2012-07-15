% 
% This is an implementation of the image denoising algorithm
% "Multiresolution bilateral filtering for image denoising" 
% Ming Zhang and Bahadir K. Gunturk
% IEEE Trans. Image Processing,  vol.17, no.12, pp.2324-2333, December 2008.
% 
% The software is provided "as is", without warranty of any kind. 
% In no event shall the authors be liable for any claim, damages or 
% other liability, in connection with the software. The software 
% can be used for non-commercial purposes only. 
% 
% Please contact B. K. Gunturk (bahadir@ece.lsu.edu) if you have any 
% questions or suggestions.
% 

clear all; close all; clc;

% ---- READ THE IMAGE ---- %
original = imread('IMG_1365.jpg'); original = original(652:652+511,201:201+511,:); %original = imcrop(original);
original = double(original);
[width,height,depth]=size(original); figure;imshow(uint8(original));


% ---- SET THE PARAMETERS ---- %

% Set the sigma_d and window size parameters
sigma_d=1.8;
window_d=5;

% Set the number of decomposition levels for the L, a, b channels
%  L a b
L=[2,4,4];
% Set the alpha in sigma_r = alpha * sigma_n for each level/channel, 
% where sigma_n will be the estimated noise standard deviation
%        0  1  2  3  4  5 
alpha = [3  3  3  3  3  3;  %L
         3  3  3  3  3  3;  %a
         3  3  3  3  3  3]; %b

% Set the wavelet decomposition filter
dec='db8'; %'db4','db8','sym8'

% ---- PREPARE FOR DENOISING ---- %     
     
% If it is a color image, transform to Lab space
if depth>1,
    original = original/255;
    cform = makecform('srgb2lab');
    original = applycform(original,cform);
end
     
% Allocate space for the output image     
output = zeros(size(original));     
     

% ---- DENOISE THE IMAGE ---- %
for k=1:depth 
    k
    % Read a channel of the image
    a = original(:,:,k);
    % Decompose image to the L(k)th (last) level
    [cA,cH,cV,cD] = waved(a,L(k),dec);
    % Estimate noise standard deviation (sigmahat) and get sigma_r parameter
    sigmahat = median(abs(cD(:)))/0.6745;
    sigma_r = alpha(k,L(k)+1)*sigmahat;
    % Apply bilateral filter to the approximation subband at the L(k)th level
    temp = gen_bilateral1(cA,sigma_d,sigma_r,window_d);
    %
    %
    % Apply bilateral filter and wavelet thresholding at all levels,
    % starting with the last
    i = L(k);
    while i>=1
        %i
        % Apply wavelet decomposition
        [cA,cH,cV,cD] = waved(a,i,dec); 
        % Estimate noise using the robust median estimator
        sigmahat = median(abs(cD(:)))/0.6745;
        sigma_r = alpha(k,i)*sigmahat;
        % Wavelet threshold the detail subbands
        cH=sthresh(cH,sigmahat);        
        cV=sthresh(cV,sigmahat);
        cD=sthresh(cD,sigmahat);
        % Get the bilateral filter applied approximation subband
        [h,w] = size(cH); temp = temp(1:h,1:w); % In case sizes do not match due to decomposition filters
        % Apply inverse wavelet decomposition
        temp2 = idwt2(temp,cH,cV,cD,dec); 
        % Apply bilateral filter for the next level
        temp = gen_bilateral1(temp2,sigma_d,sigma_r,window_d);
        i=i-1;
    end
    temp = temp(1:width,1:height);
    output(:,:,k) = temp;
end

% Go back to RGB space of color image
if depth>1,
    cform = makecform('lab2srgb');
    output = applycform(output,cform);
    output = output*255;
end

% Display the result
figure;imshow(uint8(output));




