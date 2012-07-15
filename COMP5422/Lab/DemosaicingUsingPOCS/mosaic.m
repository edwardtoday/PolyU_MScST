%
% mosaic -> Creates a Bayer mosaic from an RGB image
%
%		[X] = mosaic(RGB)
%		RGB			-> Input image 
%		X   	    -> Bayer sampled mosaic
%
% Bahadir K. Gunturk
% Department of Electrical and Computer Engineering
% Louisiana State University
% Email: bahadir@ece.lsu.edu
% URL  : http://www.ece.lsu.edu/~bahadir

function [X] = mosaic(RGB)

% G R
% B G

X = zeros(size(RGB,1),size(RGB,2));

X(1:2:end,2:2:end) = RGB(1:2:end,2:2:end,1); % Red
X(1:2:end,1:2:end) = RGB(1:2:end,1:2:end,2); % Green
X(2:2:end,2:2:end) = RGB(2:2:end,2:2:end,2); % Green
X(2:2:end,1:2:end) = RGB(2:2:end,1:2:end,3); % Blue
    