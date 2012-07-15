function [ca,ch]=haar1d(x)
   % haar1d performs a single-level 1-D Haar wavelet decomposition
   % x: input signal
   % ca:approximation coefficients
   % ch:detail coefficients
   ltemp=(x(1,2:size(x,2))+x(1,1:size(x,2)-1))/2; % convolution of input signal and low-pass decomposition filter
   htemp=(x(1,1:size(x,2)-1)-x(1,2:size(x,2)))/2; % convolution of input signal and high-pass decomposition filter
   ca=ltemp(1,1:2:size(ltemp,2)); % downsampling
   ch=htemp(1,1:2:size(htemp,2));
