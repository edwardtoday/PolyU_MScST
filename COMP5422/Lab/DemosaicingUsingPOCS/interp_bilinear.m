%
% interp_bilinear -> Bilinear interpolation from a Bayer mosaic
%
%		[RGB] = interp_bilinear(X)
%		RGB			-> Bilinearly interpolated image 
%		X   	    -> Bayer sampled mosaic
%
% Bahadir K. Gunturk
% Department of Electrical and Computer Engineering
% Louisiana State University
% Email: bahadir@ece.lsu.edu
% URL  : http://www.ece.lsu.edu/~bahadir


function [RGB] = interp_bilinear(X)

% G R
% B G

% masks for Bayer pattern
Mr  = zeros(size(X)); Mr(1:2:end,2:2:end) = 1;   % 0:not red,  1:red
Mb  = zeros(size(X)); Mb(2:2:end,1:2:end) = 1;   % 0:not blue, 1:blue
Mg1 = zeros(size(X)); Mg1(1:2:end,1:2:end) = 1;  % 0: not G1,  1:G1
Mg2 = zeros(size(X)); Mg2(2:2:end,2:2:end) = 1;  % 0: not G2,  1:G2

% Green
Hg = [0 1/4 0; 1/4 1 1/4; 0 1/4 0];
G = conv2((Mg1+Mg2).*X,Hg,'same');

% Red/Blue
Hr = [1/4 1/2 1/4; 1/2 1 1/2; 1/4 1/2 1/4];
R = conv2(Mr.*X,Hr,'same');
B = conv2(Mb.*X,Hr,'same');

RGB(:,:,1) = R;
RGB(:,:,2) = G;
RGB(:,:,3) = B;

RGB(RGB<0) = 0;
RGB(RGB>255) = 255;
